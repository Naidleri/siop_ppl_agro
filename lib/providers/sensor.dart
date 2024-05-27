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
      _checknNotification(servo);
      notifyListeners();
    });
  }

  Stream<dynamic> getSensorDataStream() {
    return _sensorService.getSensorDataStream(lahanId.toString());
  }

  void _checknNotification(int servo) {
    if (servo == 90) {
      _notificationService.showNotification(
          "siram otomatis", "Lahan telah berhasil disiram");
    }
  }
}
