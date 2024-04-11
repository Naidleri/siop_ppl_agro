part of 'sensor_bloc.dart';

@immutable
sealed class SensorState {}

final class SensorInitial extends SensorState {}

class SensorLoading extends SensorState {}

class SensorLoaded extends SensorState {
  final SensorData data;

  SensorLoaded(this.data);
  @override
  List<Object> get props => [data];
}

class SensorDataError extends SensorState {
  final String message;

  SensorDataError(this.message);
}
