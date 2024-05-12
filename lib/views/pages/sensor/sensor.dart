import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siop_ppl_agro/providers/lahan.dart';
import 'package:siop_ppl_agro/providers/sensor.dart';
import 'package:siop_ppl_agro/views/pages/lahan/lahan.dart';
import 'package:siop_ppl_agro/views/pages/sensor/history.dart';

class SensorPage extends StatelessWidget {
  final String lahanId;
  final String lahanName;
  SensorPage({required this.lahanId, required this.lahanName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            color: Colors.blue,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(24, 152, 119, 1),
                    shape: const CircleBorder()),
                child: Image.asset("assets/images/back icon.png")),
          ),
          Container(
            color: Colors.red,
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
          SizedBox(
            width: 400,
            child: Center(
              child: Image.asset(
                "assets/images/ph meter 1.png",
                width: 150,
                height: 200,
              ),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => SensorProvider(lahanId),
            child: Consumer<SensorProvider>(
              builder: (context, provider, child) {
                if (provider.sensorData == null) {
                  return const Text("Sensor belum terdeteksi");
                }
                final sensorData = provider.sensorData!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$lahanName'),
                    Text('Temperature: ${sensorData.temperature}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        )),
                    Text('Soil Moisture: ${sensorData.soilMoisture}%',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        )),
                    Text('Servo: ${sensorData.servo}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        )),
                  ],
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => (
              LahanProvider().deleteLahan(lahanId),
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeLahan(),
                ),
              )
            ),
            child: const Text("Hapus lahan"),
          ),
          Container(
            color: Colors.red,
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
          //const HistoryPage(),
        ],
      ),
    );
  }
}

// class monitoring extends StatelessWidget {
//   const monitoring({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.white,
//         child: Stack(
//           children: [
//             BackButton(),
//             Positioned(
//               top: 120,
//               left: 20,
//               child: Text(
//                 " Beginilah, kondisi lahan \n anda menurut sensor",
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   height: 1.3,
//                   color: Color.fromRGBO(9, 55, 49, 1),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 200,
//               child: Container(
//                 width: 400,
//                 // Warna latar belakang untuk debugging
//                 child: Center(
//                   child: Image.asset(
//                     "assets/images/ph meter 1.png",
//                     width: 150,
//                     height: 200,
//                   ),
//                 ),
//               ),
//             ),
//             DATA(),
//             Positioned(
//               top: 510,
//               left: 20,
//               right: 0,
//               child: Text(
//                 "History",
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   height: 1.3,
//                   color: Color.fromRGBO(9, 55, 49, 1),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 545,
//               left: 0,
//               right: 0,
//               bottom: 0, // Add bottom: 0 to constrain the scrollable area

//               child: SingleChildScrollView(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   child: Column(
//                     children: [
//                       list(),
//                       list(),
//                       list(),
//                       list(),
//                       list(),
//                       list(),
//                       list(),
//                       list(),
//                       list(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class list extends StatelessWidget {
//   const list({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => monitoring()),
//         );
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 10.0),
//         width: 353,
//         height: 53,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: Color.fromRGBO(9, 55, 49, 1),
//             width: 2,
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Container(
//               width: 60,
//               height: 50,
//               child: Center(
//                 child: Container(
//                   width: 32,
//                   height: 32,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color.fromRGBO(224, 255, 24, 1),
//                   ),
//                   child: Image.asset(
//                     "assets/images/siram.png",
//                     width: 20,
//                     height: 20,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 10),
//             Container(
//               width: 140,
//               child: Text(
//                 'Lahan Balsa 2',
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 12,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             Text(
//               'Senin, 21 Oktober 2024',
//               style: TextStyle(
//                 fontFamily: 'Poppins',
//                 fontSize: 10,
//                 fontWeight: FontWeight.w200,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DATA extends StatelessWidget {
//   const DATA({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: 420,
//       left: 100,
//       child: Container(
//         width: 200,
//         height: 100,
//         child: Column(
//           children: [
//             Text("Temperature :",
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 12,
//                 )),
//             Text("Soil Moisture :",
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 12,
//                 )),
//             Text("Soil Moisture (%) :",
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 12,
//                 )),
//             Text("Servo :",
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 12,
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
