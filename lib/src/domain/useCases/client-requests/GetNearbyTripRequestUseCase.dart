import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/repository/ClientRequestsRepository.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class GetNearbyTripRequestUseCase {
  ClientRequestsRepository clientRequestsRepository;

  GetNearbyTripRequestUseCase(this.clientRequestsRepository);

  Future<Resource<List<ClientRequestResponse>>> run(double driverLat, double driverLng) async {
    return await clientRequestsRepository.getNearbyTripRequest(driverLat, driverLng);
  }
}
