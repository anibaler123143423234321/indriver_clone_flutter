// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:indriver_clone_flutter/src/data/dataSource/local/SharefPref.dart'
    as _i3;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/services/AuthService.dart'
    as _i4;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/services/UsersService.dart'
    as _i5;
import 'package:indriver_clone_flutter/src/di/AppModule.dart' as _i10;
import 'package:indriver_clone_flutter/src/domain/repository/AuthRepository.dart'
    as _i6;
import 'package:indriver_clone_flutter/src/domain/repository/UsersRepository.dart'
    as _i7;
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCase.dart'
    as _i8;
import 'package:indriver_clone_flutter/src/domain/useCases/users/UsersUseCases.dart'
    as _i9;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i3.SharefPref>(() => appModule.sharefPref);
    gh.factoryAsync<String>(() => appModule.token);
    gh.factory<_i4.AuthService>(() => appModule.authService);
    gh.factory<_i5.UsersService>(() => appModule.usersService);
    gh.factory<_i6.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i7.UsersRepository>(() => appModule.usersRepository);
    gh.factory<_i8.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i9.UsersUseCases>(() => appModule.useruseCases);
    return this;
  }
}

class _$AppModule extends _i10.AppModule {}