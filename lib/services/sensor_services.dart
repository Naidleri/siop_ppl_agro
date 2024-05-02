import 'package:firebase_database/firebase_database.dart';

class SensorService {
  Stream getSensorDataStream(String lahanId) {
    return FirebaseDatabase.instance.ref("sensor").child(lahanId).onValue;
  }

  double getSoilMoisturePercentage(int soilValue) {
    if (soilValue < 1060) {
      return 100.0;
    } else if (soilValue > 2500) {
      return 0.0;
    }

    final double normalizedSoil = (soilValue - 1060) / (2500 - 1060);
    return (1 - normalizedSoil) * 100;
  }
}
