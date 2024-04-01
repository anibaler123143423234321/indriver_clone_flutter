import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/models/AuthResponse.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/socket/SocketUseCases.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapLocation/bloc/DriverMapLocationEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapLocation/bloc/DriverMapLocationState.dart';

class DriverMapLocationBloc
    extends Bloc<DriverMapLocationEvent, DriverMapLocationState> {
  SocketUseCases socketUseCases;
  GeolocatorUseCases geolocatorUseCases;
  StreamSubscription? positionSubscription;

  DriverMapLocationBloc(this.geolocatorUseCases, this.socketUseCases)
      : super(DriverMapLocationState()) {
      
    on<DriverMapLocationInitEvent>((event, emit) async {
      Completer<GoogleMapController> controller =
          Completer<GoogleMapController>();
      emit(
        state.copyWith(
          controller: controller,
                  )
      );
    });

    on<FindPosition>((event, emit) async {
      Position position = await geolocatorUseCases.findPosition.run();
      add(ChangeMapCameraPosition(lat: position.latitude, lng: position.longitude));
      add(AddMyPositionMarker(lat: position.latitude, lng: position.longitude));
      Stream<Position> positionStream = geolocatorUseCases.getPositionStream.run();
      positionSubscription = positionStream.listen((Position position) {
        add(UpdateLocation(position: position));
      });
      emit(
        state.copyWith(
          position: position,
        )
      );
    });

    on<AddMyPositionMarker>((event, emit) async {
      BitmapDescriptor descriptor = await geolocatorUseCases.createMarker.run('assets/img/car_pin.png');
      Marker marker = geolocatorUseCases.getMarker.run(
        'my_location',
        event.lat,
        event.lng,
        'Mi posicion',
        '',
        descriptor
      );
      emit(
        state.copyWith(
          markers: {
            marker.markerId: marker
          },
        )
      );
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      try {
        GoogleMapController googleMapController = await state.controller!.future;
        await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.lat, event.lng),
            zoom: 16,
            bearing: 0
          )
        ));
      } catch (e) {
        print('ERROR EN ChangeMapCameraPosition: $e');
      }
      
    });  

    on<UpdateLocation>((event, emit) async {
      add(AddMyPositionMarker(lat: event.position.latitude, lng: event.position.longitude));
      add(ChangeMapCameraPosition(lat: event.position.latitude, lng: event.position.longitude));
      emit(
        state.copyWith(
          position: event.position
        )
      );
    });

    on<StopLocation>((event, emit) {
      positionSubscription?.cancel();
    });

    on<ConnectSocketIo>((event, emit) {
      socketUseCases.connect.run();
    });

    on<DisconnectSocketIo>((event, emit) {
      socketUseCases.disconnect.run();
    });


  }
}
