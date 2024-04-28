import 'package:flutter/material.dart';
import 'package:siop_ppl_agro/feat/lahan/presentation/addLahan.dart';
import 'package:siop_ppl_agro/feat/lahan/services/services.dart';
import 'package:siop_ppl_agro/feat/sensor/services/services.dart';

class SensorPage extends StatefulWidget {
  final String lahanId;
  final String lahanName;
  SensorPage({required this.lahanId, required this.lahanName});

  @override
  _SensorPageState createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Data - ${widget.lahanName}'),
      ),
      body: StreamBuilder(
        stream: FirebaseService().getSensorDataStream(widget.lahanId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            var data = snapshot.data!.snapshot.value;
            double temperature = data['temperature'];
            int soil = data['soil'];
            int servo = data['servo'];

            double soilMoisturePercentage =
                FirebaseService().getSoilMoisturePercentage(soil);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Temperature: $temperature'),
                  Text('Soil Moisture: $soil'),
                  Text(
                      'Soil Moisture (%): ${soilMoisturePercentage.toStringAsFixed(1)}'),
                  Text('Servo: $servo'),
                  ElevatedButton(
                    onPressed: () {
                      String Id = widget.lahanId;
                      DatabaseMethods().deleteLahan(Id);
                    },
                    child: const Text("Hapus lahan"),
                  )
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
