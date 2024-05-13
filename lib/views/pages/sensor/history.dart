import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siop_ppl_agro/providers/history.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor History'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => SensorHistoryProvider(),
        child: Consumer<SensorHistoryProvider>(
            builder: (context, provider, child) {
          if (provider.sensorDataList.isEmpty) {
            return Text("No sensor data yet");
          }
          return Column(
            children: [
              Text("Total Sensors: ${provider.sensorCount}"),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.sensorDataList.length,
                  itemBuilder: (context, index) {
                    final sensorData = provider.sensorDataList[index];
                    return ListTile(
                      title: Text(sensorData.key),
                      subtitle: Text(sensorData.servo.toString()),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
