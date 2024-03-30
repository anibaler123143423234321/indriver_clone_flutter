import 'package:indriver_clone_flutter/src/data/dataSource/remote/services/AuthService.dart';
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/user.dart';
import 'package:indriver_clone_flutter/src/domain/repository/AuthRepository.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class AuthRepositoryImpl implements AuthRepository {

  AuthService authService;

  AuthRepositoryImpl(this.authService);

  @override
  Future<Resource<AuthResponse>> login(String email, String password) {
    return authService.login(email, password);
  }

  @override
  Future<Resource<AuthResponse>> register(User user) {
    return authService.register(user);
  }

}