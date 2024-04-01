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
    as _i5;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/services/UsersService.dart'
    as _i6;
import 'package:indriver_clone_flutter/src/di/AppModule.dart' as _i15;
import 'package:indriver_clone_flutter/src/domain/repository/AuthRepository.dart'
    as _i7;
import 'package:indriver_clone_flutter/src/domain/repository/GeolocatorRepository.dart'
    as _i10;
import 'package:indriver_clone_flutter/src/domain/repository/SocketRepository.dart'
    as _i9;
import 'package:indriver_clone_flutter/src/domain/repository/UsersRepository.dart'
    as _i8;
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCase.dart'
    as _i11;
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart'
    as _i13;
import 'package:indriver_clone_flutter/src/domain/useCases/socket/SocketUseCases.dart'
    as _i14;
import 'package:indriver_clone_flutter/src/domain/useCases/users/UsersUseCases.dart'
    as _i12;
import 'package:injectable/injectable.dart' as _i2;
import 'package:socket_io_client/socket_io_client.dart' as _i4;

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
    gh.factory<_i4.Socket>(() => appModule.socket);
    gh.factoryAsync<String>(() => appModule.token);
    gh.factory<_i5.AuthService>(() => appModule.authService);
    gh.factory<_i6.UsersService>(() => appModule.usersService);
    gh.factory<_i7.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i8.UsersRepository>(() => appModule.usersRepository);
    gh.factory<_i9.SocketRepository>(() => appModule.socketRepository);
    gh.factory<_i10.GeolocatorRepository>(() => appModule.geolocatorRepository);
    gh.factory<_i11.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i12.UsersUseCases>(() => appModule.useruseCases);
    gh.factory<_i13.GeolocatorUseCases>(() => appModule.geolocatorUseCases);
    gh.factory<_i14.SocketUseCases>(() => appModule.socketUseCases);
    return this;
  }
}

class _$AppModule extends _i15.AppModule {}
