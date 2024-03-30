

import 'package:indriver_clone_flutter/src/data/dataSource/remote/services/AuthService.dart';
import 'package:indriver_clone_flutter/src/data/repository/AuthRepositoryImpl.dart';
import 'package:indriver_clone_flutter/src/domain/repository/AuthRepository.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/RegisterUseCase.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule{

  @injectable
  AuthService get authService => AuthService();

  @injectable
  AuthRepository get authRepository => AuthRepositoryImpl(authService);

  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository),
    register: RegisterUseCase(authRepository)
    );

}