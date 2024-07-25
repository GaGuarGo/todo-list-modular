import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_modular/app/repositories/user/user_repository.dart';

import './user_service.dart';

class UserServiceImpl extends UserService {
  UserServiceImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  UserRepository _userRepository;

  @override
  Future<User?> register(String email, String password) =>
      _userRepository.register(email, password);
}
