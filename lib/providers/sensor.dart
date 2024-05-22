import 'package:flutter/material.dart';
import 'package:siop_ppl_agro/models/sensorModel.dart';
import 'package:siop_ppl_agro/services/sensor_services.dart';

class SensorProvider extends ChangeNotifier {
  final String lahanId;
  final SensorService _sensorService = SensorService();

  SensorData? _sensorData;

  SensorData? get sensorData => _sensorData;

  SensorProvider(this.lahanId) {
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

      notifyListeners();
    });
  }
  Stream<dynamic> getSensorDataStream() {
    return _sensorService.getSensorDataStream(lahanId);
  }
}
