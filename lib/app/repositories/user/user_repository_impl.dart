// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list_modular/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list_modular/app/exception/auth_exception.dart';

import './user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  FirebaseAuth _firebaseAuth;
  SqliteConnectionFactory _sqliteConnectionFactory;

  UserRepositoryImpl(
      {required FirebaseAuth firebaseAuth,
      required SqliteConnectionFactory sqliteConnectionFactory})
      : _firebaseAuth = firebaseAuth,
        _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      log(e.toString(), stackTrace: s);
      if (e.code == 'email-already-exists') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message: 'E-mail já utilizado, por favor escolha outro e-mail');
        } else {
          throw AuthException(
              message:
                  'Você se cadastrou no TodoList pelo Google, por favor utilize ele para entrar!');
        }
      } else {
        throw AuthException(message: e.message ?? "Erro ao registrar usuário");
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredetendial = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredetendial.user;
    } on PlatformException catch (e, s) {
      log(e.toString(), stackTrace: s);
      throw AuthException(message: e.message ?? 'Erro ao Realizar Login');
    } on FirebaseAuthException catch (e, s) {
      log(e.toString(), stackTrace: s);
      throw AuthException(message: e.message ?? 'Erro ao Realizar Login');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google')) {
        throw AuthException(
            message:
                'Cadastro realizado com o google, não pode ser resetado a senha');
      } else {
        throw AuthException(message: 'E-mail não Encontrado');
      }
    } on PlatformException catch (e, s) {
      log(e.message.toString(), stackTrace: s);
      throw AuthException(message: 'Erro ao resetar senha');
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;

    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);

        if (loginMethods.contains('password')) {
          throw AuthException(
              message:
                  'Você utilizou o e-mal para cadastro no TodoList, caso tenha esquecido sua senh, por favor clique em \'Esqueci sua Senha?\'');
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

          final userCredential =
              await _firebaseAuth.signInWithCredential(firebaseCredential);
          return userCredential.user;
        }
      }
    } on FirebaseAuthException catch (e, s) {
      log(e.message.toString(), stackTrace: s);
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(
            message:
                'Login inválido você se registrou no TodoList com os seguintes provedores: ${loginMethods?.join(',')}');
      } else {
        throw AuthException(message: 'Erro ao realizar login');
      }
    }
    return null;
  }

  @override
  Future<void> logout() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.rawDelete('delete from todo');

    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      user.reload();
    }
  }
}
