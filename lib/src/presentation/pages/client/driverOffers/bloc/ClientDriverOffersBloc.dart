import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverTripRequest.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestsUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/driver-trip-request/DriverTripRequestUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersState.dart';

class ClientDriverOffersBloc extends Bloc<ClientDriverOffersEvent, ClientDriverOffersState> {

  DriverTripRequestUseCases driverTripRequestUseCases;
  ClientRequestsUseCases clientRequestsUseCases;

  ClientDriverOffersBloc(this.driverTripRequestUseCases, this.clientRequestsUseCases): super(ClientDriverOffersState()) {
    on<GetDriverOffers>((event, emit) async {
      emit(
        state.copyWith(
        )
      );
    });

    on<AssignDriver>((event, emit) async {
      emit(
        state.copyWith(
        )
      );

      
    });



  }

}