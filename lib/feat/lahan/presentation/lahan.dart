import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siop_ppl_agro/feat/lahan/services/services.dart';
import 'package:siop_ppl_agro/feat/sensor/presentation/sensor.dart';

class HomeLahan extends StatefulWidget {
  const HomeLahan({super.key});

  @override
  State<HomeLahan> createState() => _HomeLahanState();
}

class _HomeLahanState extends State<HomeLahan> {
  Stream? _LahanSteam;

  getontheload() async {
    _LahanSteam = DatabaseMethods().getLahan();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allLahan() {
    return StreamBuilder(
        stream: _LahanSteam,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          Text(ds["Lahan"].toString()),
                          Text("Umur tanaman :${ds["Umur"]}"),
                        ],
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lahanku"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: allLahan(),
            )
          ],
        ),
      ),
    );
  }
}
