import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SensorPage extends StatefulWidget {
  final String lahanId;
  SensorPage({required this.lahanId});

  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  late final DatabaseReference dbRef;
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref("sensor").child(widget.lahanId);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Data'),
      ),
      body: StreamBuilder(
        stream: dbRef.onValue,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            var data = snapshot.data!.snapshot.value;
            double temperature = data['temperature'];
            int soil = data['soil'];
            int servo = data['servo'];

            double soilMoisturePercentage = getSoilMoisturePercentage(soil);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Temperature: $temperature'),
                  Text('Soil Moisture: $soil'),
                  Text(
                      'Soil Moisture (%): ${soilMoisturePercentage.toStringAsFixed(1)}'),
                  Text('Servo: $servo'),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
