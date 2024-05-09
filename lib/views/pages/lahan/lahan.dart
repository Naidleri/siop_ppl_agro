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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderText(),
          const Deskripsi(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset("assets/images/orang.png")),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(right: 30, top: 10),
                  child: const Text("Mau menambah lahan kah?"),
                ),
              ),
            ],
          ),
          Center(
              child: Container(
            padding: const EdgeInsets.only(right: 30, top: 10, bottom: 2),
            child: const AddLahan(),
          )),
          Expanded(
            child: Consumer<LahanProvider>(
              builder: (context, lahanProvider, _) {
                return StreamBuilder(
                  stream: lahanProvider.getLahan(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            shrinkWrap: true,
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
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        height: 50,
                                        child: Center(
                                          child: Container(
                                            width: 32,
                                            height: 32,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(
                                                  224, 255, 24, 1),
                                            ),
                                            child: Image.asset(
                                              "assets/images/siram.png",
                                              width: 20,
                                              height: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
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
    return Stack(
      children: [
        Image.asset(
          "assets/images/circle-left.png",
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 30),
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Hi, ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: 'Farmer ',
                  style: TextStyle(
                    color: Color.fromRGBO(206, 239, 1, 1),
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Deskripsi extends StatelessWidget {
  const Deskripsi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
      child: const Text(
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
