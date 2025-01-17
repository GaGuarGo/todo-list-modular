import 'dart:developer';
import 'package:todo_list_modular/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_modular/app/exception/auth_exception.dart';
import 'package:todo_list_modular/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMessage != null && infoMessage!.isNotEmpty;

  Future<void> googleLogin() async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.googleLogin();

      if (user != null) {
        success();
      } else {
        _userService.logout();
        setError('Erro realizar Login com o Google');
      }
    } on AuthException catch (e) {
      _userService.logout();
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();

      final user = await _userService.login(email, password);

      if (user != null) {
        success();
      } else {
        setError('Usuário ou senha Inválidos');
      }
    } on AuthException catch (e, s) {
      log(e.message, stackTrace: s);
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage = 'Reset de Senha enviado para seu e-mail';
    } on AuthException catch (e, s) {
      log(e.toString(), stackTrace: s);
      setError(e.message);
    } on Exception catch (e, s) {
      log(e.toString(), stackTrace: s);
      setError('Erro ao Resetar Senha');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
