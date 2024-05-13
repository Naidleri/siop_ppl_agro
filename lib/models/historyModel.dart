class HistoryData {
  final int servo;
  final List<String> tanggal;

  HistoryData({required this.servo, required this.tanggal});
}

class SensorHistoryData {
  final String key;
  final int servo;
  final Map<dynamic, dynamic> data;

  const SensorHistoryData(this.key, this.servo, this.data);
}
