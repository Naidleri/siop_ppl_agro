import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siop_ppl_agro/providers/lahan.dart';
import 'package:siop_ppl_agro/views/pages/lahan/addLahan.dart';
import 'package:siop_ppl_agro/views/pages/sensor/sensor.dart';

class HomeLahan extends StatefulWidget {
  const HomeLahan({Key? key}) : super(key: key);

  @override
  State<HomeLahan> createState() => _HomeLahanState();
}

class _HomeLahanState extends State<HomeLahan> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [list()],
      ),
    );
  }
}

class Deskripsi extends StatelessWidget {
  const Deskripsi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 135,
      left: 20,
      right: 0,
      child: Text(
        " Selamat, kebun anda \n memiliki pertumbuhan yang \n signifikan!!!!",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: Color.fromRGBO(9, 55, 49, 1),
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Hi, ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: 'Farmer ',
                  style: TextStyle(
                    color: Color.fromRGBO(206, 239, 1, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5), // Spacer
          const Text(
            'Senin, 17 Oktober 2023', // Tulisan di bawahnya
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonAddLahan extends StatelessWidget {
  const ButtonAddLahan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Tambah Lahan'), // Corrected spelling
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Nama',
                        fillColor: Color.fromARGB(
                            255, 255, 255, 255), // Set form background color
                        filled: true, // Enable filled background
                        contentPadding: EdgeInsets.symmetric(
                          horizontal:
                              10.0, // Add padding between input and border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey), // Grey outline on focus
                        ),
                      ),
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255,
                              255)), // Set input text color to white
                    ),
                    const SizedBox(
                        height: 10.0), // Add vertical padding between inputs
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Umur',
                        fillColor: Color.fromARGB(
                            255, 255, 255, 255), // Set form background color
                        filled: true, // Enable filled background
                        contentPadding: EdgeInsets.symmetric(
                          horizontal:
                              10.0, // Add padding between input and border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey), // Grey outline on focus
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.white), // Set input text color to white
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Red for Batal
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            textStyle: const TextStyle(fontSize: 14.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Batal',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Save form data (replace with your logic)
                            Navigator.pop(context); // Close the dialog
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 96, 255, 101), // Green for Simpan
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            textStyle: const TextStyle(fontSize: 14.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Simpan',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            const Color.fromRGBO(37, 204, 162, 1), // Custom green color
        padding: EdgeInsets.zero,
        textStyle: const TextStyle(fontSize: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: const Text(
        'Tambah lahan',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

class list extends StatefulWidget {
  const list({
    Key? key,
  }) : super(key: key);

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<LahanProvider>(
            builder: (context, lahanProvider, _) {
              return StreamBuilder(
                stream: lahanProvider.getLahan(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot ds = snapshot.data.docs[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SensorPage(
                                      lahanId: ds["Id"],
                                      lahanName: ds["Lahan"],
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 50,
                                    child: Center(
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromRGBO(224, 255, 24, 1),
                                        ),
                                        child: Image.asset(
                                          "assets/images/siram.png",
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Spacer between columns
                                  Container(
                                    width: 140,
                                    child: Text(
                                      ds["Lahan"].toString(),
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Container();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

//  Expanded(
//                 child: Consumer<LahanProvider>(
//                   builder: (context, lahanProvider, _) {
//                     return StreamBuilder(
//                       stream: lahanProvider.getLahan(),
//                       builder: (BuildContext context, AsyncSnapshot snapshot) {
//                         return snapshot.hasData
//                             ? ListView.builder(
//                                 itemCount: snapshot.data.docs.length,
//                                 itemBuilder: (context, index) {
//                                   DocumentSnapshot ds =
//                                       snapshot.data.docs[index];
//                                   return GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => SensorPage(
//                                             lahanId: ds["Id"],
//                                             lahanName: ds["Lahan"],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     child: Container(
//                                       margin: const EdgeInsets.only(
//                                           top: 10, bottom: 10),
//                                       width: MediaQuery.of(context).size.width,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(width: 1),
//                                         borderRadius: BorderRadius.circular(5),
//                                       ),
//                                       child: Column(
//                                           Text(ds["Lahan"].toString()),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               )
//                             : Container();
//                       },
//                     );