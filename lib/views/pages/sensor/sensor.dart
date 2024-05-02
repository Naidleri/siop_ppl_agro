import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siop_ppl_agro/providers/sensor.dart';

class SensorPage extends StatelessWidget {
  final String lahanId;
  final String lahanName;
  SensorPage({required this.lahanId, required this.lahanName});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SensorProvider(lahanId),
      child: Consumer<SensorProvider>(
        builder: (context, provider, child) {
          if (provider.sensorData == null) {
            return CircularProgressIndicator();
          }
          final sensorData = provider.sensorData!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Sensor Data - $lahanName'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Temperature: ${sensorData.temperature}'),
                Text('Soil Moisture: ${sensorData.soilMoisture}%'),
                Text('Servo: ${sensorData.servo}'),
                ElevatedButton(
                  onPressed: () => (context),
                  child: const Text("Hapus lahan"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//  return Scaffold(
//           appBar: AppBar(
//             title: Text('Sensor Data - $lahanName'),
//           ),
//           body: Consumer<SensorViewModel>(
//             builder: (context, model, _) {
//               if (model.sensorData.temperature == 0.0) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Temperature: ${model.sensorData.temperature}'),
//                       Text('Soil Moisture: ${model.sensorData.soilMoisture}'),
//                       Text('Servo: ${model.sensorData.servo}'),
//                       ElevatedButton(
//                         onPressed: () => model.deleteLahan(context),
//                         child: const Text("Hapus lahan"),
//                       )
//                     ],
//                   ),
//                 );
//               } else {
//                 return Center(
//                   child: Column(
//                     children: [
//                       Text("Sensor data belum tersedia"),
//                       ElevatedButton(
  
//                         onPressed: () => model.deleteLahan(context),
//                         child: const Text("Hapus lahan"),
//                       )
//                     ],
//                   ),
//                 );
//               }
//             },
//           ),
//         );