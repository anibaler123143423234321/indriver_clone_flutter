import 'package:equatable/equatable.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';

class DriverClientRequestsState extends Equatable {

  final Resource? response;

  DriverClientRequestsState({
    this.response,
  });

  DriverClientRequestsState copyWith({
    Resource? response,
  }) {
    return DriverClientRequestsState(
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [response];

}