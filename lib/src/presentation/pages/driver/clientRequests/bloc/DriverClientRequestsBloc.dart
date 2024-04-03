import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverPosition.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestsUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/drivers-position/DriversPositionUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsState.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsEvent.dart';

class DriverClientRequestsBloc extends Bloc<DriverClientRequestsEvent, DriverClientRequestsState> {

  AuthUseCases authUseCases;
  DriversPositionUseCases driversPositionUseCases;
  ClientRequestsUseCases clientRequestsUseCases;

  DriverClientRequestsBloc(this.clientRequestsUseCases, this.driversPositionUseCases, this.authUseCases): super(DriverClientRequestsState()) {


   on<GetNearbyTripRequest>((event, emit) async {
  AuthResponse authResponse = await authUseCases.getUserSession.run();
  Resource driverPositionResponse = await driversPositionUseCases.getDriverPosition.run(authResponse.user.id!);
  emit(state.copyWith(response: Loading()));
  
  if (driverPositionResponse is Success) {
    DriverPosition? driverPosition = driverPositionResponse.data as DriverPosition?;
    if (driverPosition != null && driverPosition.lat != null && driverPosition.lng != null) {
      // Las coordenadas no son nulas, procede con la solicitud de las solicitudes de viaje cercanas
      print('Driver Position: $driverPosition');
      Resource<List<ClientRequestResponse>> response = await clientRequestsUseCases.getNearbyTripRequest.run(driverPosition.lat!, driverPosition.lng!);
      print('Client Requests Response: $response');

      emit(state.copyWith(response: response));
    } else {
      // Las coordenadas son nulas, maneja el caso apropiadamente
      emit(state.copyWith(response: ErrorData('Driver position coordinates are null')));
    }
  } else if (driverPositionResponse is Error) {
    // Manejar el caso de error al obtener la posición del conductor
    emit(state.copyWith(response: driverPositionResponse));
  }
});

  }

}