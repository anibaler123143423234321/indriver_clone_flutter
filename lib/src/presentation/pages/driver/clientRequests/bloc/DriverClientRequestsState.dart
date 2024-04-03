import 'package:equatable/equatable.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/utils/BlocFormItem.dart';

class DriverClientRequestsState extends Equatable {

  final Resource? response;
  final Resource? responseCreateDriverTripRequest;
  final BlocFormItem fareOffered;
  final int? idDriver;

  DriverClientRequestsState({
    this.response,
    this.responseCreateDriverTripRequest,
    this.fareOffered = const BlocFormItem(error: 'Ingresa la tarifa'),
    this.idDriver
  });

  DriverClientRequestsState copyWith({
    Resource? response,
    Resource? responseCreateDriverTripRequest,
    Resource? responseDriverPosition,
    BlocFormItem? fareOffered,
    int? idDriver
  }) {
    return DriverClientRequestsState(
      response: response ?? this.response,
      responseCreateDriverTripRequest: responseCreateDriverTripRequest,
      fareOffered: fareOffered ?? this.fareOffered,
      idDriver: idDriver ?? this.idDriver
    );
  }

  @override
  List<Object?> get props => [response, responseCreateDriverTripRequest, fareOffered, idDriver];

}