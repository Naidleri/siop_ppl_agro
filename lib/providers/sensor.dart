import 'package:flutter/material.dart';
import 'package:siop_ppl_agro/models/sensorModel.dart';
import 'package:siop_ppl_agro/services/notifikasi_services.dart';
import 'package:siop_ppl_agro/services/sensor_services.dart';

class SensorProvider extends ChangeNotifier {
  final int lahanId;
  final SensorService _sensorService = SensorService();
  final NotificationService _notificationService;

  SensorData? _sensorData;

  SensorData? get sensorData => _sensorData;

  SensorProvider(this.lahanId, this._notificationService) {
    _sensorService.getSensorDataStream(lahanId.toString()).listen((event) {
      final Map<dynamic, dynamic> data =
          event.snapshot.value as Map<dynamic, dynamic>;
      final int servo = data['servo'] as int;
      final String palang = _sensorService.convertServo(servo);
      final int soil = data['soil'] as int;
      final int soilMoisture = _sensorService.getSoilMoisturePercentage(soil);
      final double temperature = data['temperature'] as double;

      _sensorData = SensorData(
        servo: servo,
        soil: soil,
        soilMoisture: soilMoisture,
        temperature: temperature,
        palang: palang,
      );
      _checkNotification(servo);
      notifyListeners();
    });
  }

  void _checkNotification(int servo) {
    if (servo == 90) {
      _notificationService.showNotification(
          "siram otomatis", "Lahan telah berhasil disiram");
    }
  }
}
