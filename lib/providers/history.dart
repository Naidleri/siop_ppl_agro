import 'package:cloud_firestore/cloud_firestore.dart';
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

      if (servo == 90) {
        sendDataToFirestore(key, servo, data);
      }

      _sensorDataList.add(SensorHistoryData(key, servo, data));
      _sensorCount++;
      notifyListeners();
    });
  }
  Future<void> sendDataToFirestore(
      String key, int servo, Map<dynamic, dynamic> data) async {
    try {
      DateTime now = DateTime.now();
      String formattedDate =
          '${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}';
      await FirebaseFirestore.instance.collection("history").doc(key).set({
        'date': formattedDate,
        'servo': servo,
      });
    } catch (error) {
      print("$error");
    }
  }

  void monitorServoValue(String key, int servo) {
    if (servo == 90) {
      updateHistory(key, servo);
    }
  }

  Future<void> updateHistory(
    String key,
    int servo,
  ) async {
    try {
      DateTime now = DateTime.now();
      String formattedDate =
          '${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}';
      await FirebaseFirestore.instance.collection("history").doc(key).update({
        'date': formattedDate,
        'servo': servo,
      });
    } catch (error) {
      print("$error");
    }
  }
}
