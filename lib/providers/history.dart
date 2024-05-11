import 'package:flutter/material.dart';
import 'package:siop_ppl_agro/models/historyModel.dart';
import 'package:siop_ppl_agro/services/history_services.dart';

class SensorHistoryProvider extends ChangeNotifier {
  final HistoryServices _service = HistoryServices();
  int _sensorCount = 0;
  final List<SensorHistoryData> _sensorDataList = [];

  int get sensorCount => _sensorCount;
  List<SensorHistoryData> get sensorDataList => _sensorDataList;

  SensorHistoryProvider() {
    _service.getSensorDataStream().listen((event) {
      final key = event.snapshot.key!;
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      final servo = data['servo'] as int;
      _sensorDataList.add(SensorHistoryData(key, servo, data));
      _sensorCount++;
      notifyListeners();
    });
  }
}
