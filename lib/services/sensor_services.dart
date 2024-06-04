import 'package:firebase_database/firebase_database.dart';

class SensorService {
  Stream getSensorDataStream(String lahanId) {
    return FirebaseDatabase.instance.ref("sensor").child(lahanId).onValue;
  }

  int getSoilMoisturePercentage(int soilValue) {
    if (soilValue < 1060) {
      return 100;
    } else if (soilValue > 2500) {
      return 0;
    }

    final double normalizedSoil = (soilValue - 1060) / (2500 - 1060);
    final double percentage = (1 - normalizedSoil) * 100;
    return percentage.round();
  }

  String convertServo(int servoValue) {
    if (servoValue == 90) {
      return 'Palang terbuka';
    } else {
      return 'Palang tertutup';
    }
  }
}
