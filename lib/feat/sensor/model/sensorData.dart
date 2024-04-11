// import 'dart:convert';

// class SensorData {
//   final String id;
//   final double temperature;
//   final int soil;
//   final int servo;

//   SensorData({
//     required this.id,
//     required this.temperature,
//     required this.soil,
//     required this.servo,
//   });

//   factory SensorData.fromJson(Map<String, dynamic> json) {
//     return SensorData(
//       id: json['id'],
//       temperature: json['temperature'],
//       soil: json['soil'],
//       servo: json['servo'],
//     );
//   }
//   String toJson() => json.encode(toMap());

//   Map<String, dynamic> toMap() => {
//         "temperature": temperature,
//         "soil": soil,
//         "servo": servo,
//       };
// }
import 'package:firebase_database/firebase_database.dart';

class SensorData {
  final double temperature;
  final int soil;
  final int servo;

  SensorData({
    required this.temperature,
    required this.soil,
    required this.servo,
  });

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      temperature: json['temperature'] as double,
      soil: json['soil'] as int,
      servo: json['servo'] as int,
    );
  }
}

class RealtimeDatabaseService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Stream<SensorData> getSensorData() {
    return _database.reference().child('sensor').onValue.map((event) {
      final data = event.snapshot.value as Map<String, dynamic>;
      if (data != null) {
        final temperature = data['temperature'] as double;
        final soil = data['soil'] as int;
        final servo = data['servo'] as int;
        return SensorData(temperature: temperature, soil: soil, servo: servo);
      } else {
        // Handle null case if necessary
        return SensorData(
            temperature: 0.0,
            soil: 0,
            servo:
                0); // Default values or handle differently as per your requirement
      }
    });
  }
}
