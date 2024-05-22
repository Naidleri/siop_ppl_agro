import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siop_ppl_agro/providers/sensor.dart';
import 'package:siop_ppl_agro/views/fragment/deletebutton.dart';
import 'package:siop_ppl_agro/views/pages/sensor/history.dart';

class SensorPage extends StatelessWidget {
  final String lahanId;
  final String lahanName;

  const SensorPage({
    Key? key,
    required this.lahanId,
    required this.lahanName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SensorProvider(lahanId),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 60, bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(24, 152, 119, 1),
                  shape: const CircleBorder(),
                ),
                child: Image.asset("assets/images/back icon.png"),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                " Beginilah, kondisi lahan \n anda menurut sensor",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                  color: Color.fromRGBO(9, 55, 49, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 400,
                child: Center(
                  child: Image.asset(
                    "assets/images/ph meter 1.png",
                    width: 150,
                    height: 200,
                  ),
                ),
              ),
            ),
            Consumer<SensorProvider>(
              builder: (context, sensorProvider, child) {
                return StreamBuilder(
                  stream: sensorProvider.getSensorDataStream(),
                  builder:
                      (BuildContext context, AsyncSnapshot sensorSnapshot) {
                    if (sensorSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      final sensorData = sensorSnapshot.data?.snapshot?.value;
                      if (sensorData != null) {
                        final temperature =
                            sensorData['temperature'] ?? 'Error';
                        final soilNormal = sensorData['soil'];
                        final soilMoisture =
                            sensorData['soilMoisture'] ?? 'Error';
                        final servo = sensorData['servo'] ?? 'Error';

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$lahanName',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Temperature: $temperature °C',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Color.fromRGBO(24, 152, 119, 1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Soil Moisture : $soilNormal',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Color.fromRGBO(24, 152, 119, 1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Servo: $servo',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Color.fromRGBO(24, 152, 119, 1),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Text("Sensor belum terdeteksi");
                      }
                    }
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  DeleteLahanButton(context, lahanId);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  "Hapus lahan",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                "History",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                  color: Color.fromRGBO(9, 55, 49, 1),
                ),
              ),
            ),
            HistoryScreen(lahanId: lahanId)
          ],
        ),
      ),
    );
  }
}
