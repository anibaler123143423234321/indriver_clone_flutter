import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/CreateClientRequestUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/GetNearbyTripRequestUseCase.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/getTimeAndDistanceUseCase.dart';

class ClientRequestsUseCases {
  CreateClientRequestUseCase createClientRequest;
  GetTimeAndDistanceUseCase getTimeAndDistance;
  GetNearbyTripRequestUseCase getNearbyTripRequest;

  ClientRequestsUseCases({
    required this.getTimeAndDistance,
    required this.createClientRequest,
    required this.getNearbyTripRequest,
  });
}