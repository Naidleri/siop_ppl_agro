import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SensorPage extends StatefulWidget {
  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child("sensor/1");

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

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Temperature: $temperature'),
                  Text('Soil: $soil'),
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
