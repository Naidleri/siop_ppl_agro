class HistoryData {}

class SensorHistoryData {
  final String key;
  final int servo;
  final Map<dynamic, dynamic> data; // Dynamic map to handle various sensor data

  const SensorHistoryData(this.key, this.servo, this.data);
}
