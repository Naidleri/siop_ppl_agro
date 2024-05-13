import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siop_ppl_agro/models/historyModel.dart';
import 'package:siop_ppl_agro/services/history_services.dart';

class SensorHistoryProvider extends ChangeNotifier {
  final HistoryServices _service = HistoryServices();
  int _sensorCount = 0;
  final List<SensorHistoryData> _sensorDataList = [];
  final _firestore = FirebaseFirestore.instance;
  final int maxHistoryEntries = 5;

  int get sensorCount => _sensorCount;
  List<SensorHistoryData> get sensorDataList => _sensorDataList;

  SensorHistoryProvider() {
    _service.getSensorDataStream().listen((event) {
      final key = event.snapshot.key!;
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      final servo = data['servo'] as int;

      if (servo == 90) {
        _firestore.collection('history').doc(key).get().then((docSnapshot) {
          if (docSnapshot.exists) {
            updateHistory(key, servo);
          } else {
            sendHistoryData(key, servo);
          }
        });
      }

      _sensorDataList.add(SensorHistoryData(key, servo, data));
      _sensorCount++;
      notifyListeners();
    });
  }

  Future<void> sendHistoryData(String key, int servo) async {
    try {
      DateTime now = DateTime.now();
      String formattedDate =
          '${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}';
      await _firestore.collection("history").doc(key).set({
        'tanggal': [formattedDate],
        'servo': servo,
      });
    } catch (error) {
      print("$error");
    }
  }

  Future<void> updateHistory(String key, int servo) async {
    try {
      DateTime now = DateTime.now();
      String formattedDate =
          "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}";
      await _firestore.collection("history").doc(key).update({
        'tanggal': FieldValue.arrayUnion([formattedDate]),
      });
    } catch (error) {
      print("Error: $error");
    }
  }
}
