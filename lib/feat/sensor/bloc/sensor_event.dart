part of 'sensor_bloc.dart';

@immutable
sealed class SensorEvent {}

class getSensorData extends SensorEvent {
  final String id;
  getSensorData(this.id);
}
