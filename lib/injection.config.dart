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
import 'package:indriver_clone_flutter/src/data/dataSource/remote/services/ClientRequestsService.dart'
    as _i8;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/services/DriverCarInfoService.dart'
    as _i10;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/services/DriversPositionService.dart'
    as _i7;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/services/DriverTripRequestsService.dart'
    as _i9;
import 'package:indriver_clone_flutter/src/data/dataSource/remote/services/UsersService.dart'
    as _i6;
import 'package:indriver_clone_flutter/src/di/AppModule.dart' as _i27;
import 'package:indriver_clone_flutter/src/domain/repository/AuthRepository.dart'
    as _i11;
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestsRepository.dart'
    as _i14;
import 'package:indriver_clone_flutter/src/domain/repository/DriverCarInfoRepository.dart'
    as _i18;
import 'package:indriver_clone_flutter/src/domain/repository/DriversPositionRepository.dart'
    as _i16;
import 'package:indriver_clone_flutter/src/domain/repository/DriverTripRequestsRepository.dart'
    as _i17;
import 'package:indriver_clone_flutter/src/domain/repository/GeolocatorRepository.dart'
    as _i15;
import 'package:indriver_clone_flutter/src/domain/repository/SocketRepository.dart'
    as _i13;
import 'package:indriver_clone_flutter/src/domain/repository/UsersRepository.dart'
    as _i12;
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart'
    as _i19;
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestsUseCases.dart'
    as _i24;
import 'package:indriver_clone_flutter/src/domain/useCases/driver-car-info/DriverCarInfoUseCases.dart'
    as _i26;
import 'package:indriver_clone_flutter/src/domain/useCases/driver-trip-request/DriverTripRequestUseCases.dart'
    as _i25;
import 'package:indriver_clone_flutter/src/domain/useCases/drivers-position/DriversPositionUseCases.dart'
    as _i23;
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart'
    as _i21;
import 'package:indriver_clone_flutter/src/domain/useCases/socket/SocketUseCases.dart'
    as _i22;
import 'package:indriver_clone_flutter/src/domain/useCases/users/UsersUseCases.dart'
    as _i20;
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
    gh.factory<_i7.DriversPositionService>(
        () => appModule.driversPositionService);
    gh.factory<_i8.ClientRequestsService>(
        () => appModule.clientRequestsService);
    gh.factory<_i9.DriverTripRequestsService>(
        () => appModule.driverTripRequestsService);
    gh.factory<_i10.DriverCarInfoService>(() => appModule.driverCarInfoService);
    gh.factory<_i11.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i12.UsersRepository>(() => appModule.usersRepository);
    gh.factory<_i13.SocketRepository>(() => appModule.socketRepository);
    gh.factory<_i14.ClientRequestsRepository>(
        () => appModule.clientRequestsRepository);
    gh.factory<_i15.GeolocatorRepository>(() => appModule.geolocatorRepository);
    gh.factory<_i16.DriverPositionRepository>(
        () => appModule.driversPositionRepository);
    gh.factory<_i17.DriverTripRequestsRepository>(
        () => appModule.driverTripRequestsRepository);
    gh.factory<_i18.DriverCarInfoRepository>(
        () => appModule.driverCarInfoRepository);
    gh.factory<_i19.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i20.UsersUseCases>(() => appModule.usersUseCases);
    gh.factory<_i21.GeolocatorUseCases>(() => appModule.geolocatorUseCases);
    gh.factory<_i22.SocketUseCases>(() => appModule.socketUseCases);
    gh.factory<_i23.DriversPositionUseCases>(
        () => appModule.driversPositionUseCases);
    gh.factory<_i24.ClientRequestsUseCases>(
        () => appModule.clientRequestsUseCases);
    gh.factory<_i25.DriverTripRequestUseCases>(
        () => appModule.driverTripRequestUseCases);
    gh.factory<_i26.DriverCarInfoUseCases>(
        () => appModule.driverCarInfoUseCases);
    return this;
  }
}

class _$AppModule extends _i27.AppModule {}
