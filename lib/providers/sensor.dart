import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:siop_ppl_agro/models/sensorModel.dart';
import 'package:siop_ppl_agro/services/history_services.dart';
import 'package:siop_ppl_agro/services/sensor_services.dart';

class SensorProvider extends ChangeNotifier {
  final String lahanId;
  final SensorService _sensorService = SensorService();
  SensorData? _sensorData;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  SensorData? get sensorData => _sensorData;

  SensorProvider(this.lahanId, this.flutterLocalNotificationsPlugin) {
    _sensorService.getSensorDataStream(lahanId).listen((event) {
      final Map<dynamic, dynamic> data =
          event.snapshot.value as Map<dynamic, dynamic>;

      final int servo = data['servo'] as int;
      final int soil = data['soil'] as int;
      final double soilMoisture =
          _sensorService.getSoilMoisturePercentage(soil);
      final double temperature = data['temperature'] as double;

      _sensorData = SensorData(
        servo: servo,
        soil: soil,
        soilMoisture: soilMoisture,
        temperature: temperature,
      );

      // Check for servo position and trigger notification if necessary
      if (servo == 90) {
        _showNotification('Lahan Anda Telah Disiram');
      }

      notifyListeners();
    });
  }

  Stream<dynamic> getSensorDataStream() {
    return _sensorService.getSensorDataStream(lahanId);
  }

  Future<void> _showNotification(String message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your_channel_id', 'your_channel_name',
            channelDescription: 'Your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker text',
            playSound: true);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Siram Otomatis', message, platformChannelSpecifics);
  }
}
