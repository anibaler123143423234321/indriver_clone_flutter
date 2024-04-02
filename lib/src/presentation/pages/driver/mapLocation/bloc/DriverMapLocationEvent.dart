import 'package:geolocator/geolocator.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverPosition.dart';


abstract class DriverMapLocationEvent {}

class DriverMapLocationInitEvent extends DriverMapLocationEvent {}
class FindPosition extends DriverMapLocationEvent {}
class UpdateLocation extends DriverMapLocationEvent {
  final Position position;
  UpdateLocation({required this.position});
}

class SaveLocationData extends DriverMapLocationEvent {
  final DriverPosition driverPosition;
  SaveLocationData({ required this.driverPosition });
}

class DeleteLocationData extends DriverMapLocationEvent {
  final int idDriver;
  DeleteLocationData({ required this.idDriver });
}


class StopLocation extends DriverMapLocationEvent {}
class AddMyPositionMarker extends DriverMapLocationEvent {
  final double lat;
  final double lng;
  AddMyPositionMarker({ required this.lat, required this.lng });
}
class ChangeMapCameraPosition extends DriverMapLocationEvent {
  final double lat;
  final double lng;
  ChangeMapCameraPosition({
    required this.lat,
    required this.lng,
  });
}

class ConnectSocketIo extends DriverMapLocationEvent{}
class DisconnectSocketIo extends DriverMapLocationEvent{}
class EmitDriverPositionSocketIo extends DriverMapLocationEvent{}
