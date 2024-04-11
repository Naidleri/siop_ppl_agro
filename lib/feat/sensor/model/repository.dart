import 'package:firebase_database/firebase_database.dart';
import 'package:siop_ppl_agro/feat/sensor/model/sensorData.dart';

class SensorRepository {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future<SensorData?> getSensorData(String sensorId) async {
    try {
      final snapshot = await _database.ref('sensor/$sensorId').once();
      final data = snapshot.snapshot.value as Map<String, dynamic>;
      return SensorData.fromJson(data);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
