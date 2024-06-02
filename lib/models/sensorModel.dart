class SensorData {
  final int servo;
  final int soil;
  final double soilMoisture;
  final double temperature;
  final String palang;

  SensorData(
      {required this.servo,
      required this.soil,
      required this.soilMoisture,
      required this.temperature,
      required this.palang});
}
