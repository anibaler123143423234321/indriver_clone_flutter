import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/models/PlacemarkData.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerState.dart';

class ClientMapSeekerBloc
    extends Bloc<ClientMapSeekerEvent, ClientMapSeekerState> {
  GeolocatorUseCases geolocatorUseCases;

  ClientMapSeekerBloc(this.geolocatorUseCases) : super(ClientMapSeekerState()) {
    on<ClientMapSeekerInitEvent>((event, emit) {
      Completer<GoogleMapController> controller =
          Completer<GoogleMapController>();
      emit(state.copyWith(controller: controller));
    });

    on<FindPosition>((event, emit) async {
      Position position = await geolocatorUseCases.findPosition.run();
      add(ChangeMapCameraPosition(
          lat: position.latitude, lng: position.longitude));

      emit(state.copyWith(
        position: position,
      ));

      print('Position Lat: ${position.latitude}');
      print('Position Long: ${position.longitude}');
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      GoogleMapController googleMapController = await state.controller!.future;
      await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(event.lat, event.lng), zoom: 15, bearing: 0)));
    });

    on<OnCameraMove>((event, emit) {
      emit(state.copyWith(cameraPosition: event.cameraPosition));
    });

    on<OnCameraIdle>((event, emit) async {
        PlacemarkData? placemarkData = await geolocatorUseCases.getPlacemarkData.run(state.cameraPosition);
          emit(
            state.copyWith(
              placemarkData: placemarkData,
            )
          );
    });
  
  on<OnAutoCompletedPickUpSelected>((event, emit) {
      emit(
        state.copyWith(
          pickUpLatLng: LatLng(event.lat, event.lng),
          pickUpDescription: event.pickUpDescription
        )
      );
    });

    on<OnAutoCompletedDestinationSelected>((event, emit) {
      emit(
        state.copyWith(
          destinationLatLng: LatLng(event.lat, event.lng),
          destinationDescription: event.destinationDescription
        )
      );
    });
  
  }

  
}
