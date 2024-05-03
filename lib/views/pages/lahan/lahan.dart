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
      appBar: AppBar(
        title: const Text("Lahanku"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              // Gunakan Consumer untuk mendapatkan data lahan dari provider
              child: Consumer<LahanProvider>(
                builder: (context, lahanProvider, _) {
                  // Gunakan StreamBuilder untuk membangun UI berdasarkan data lahan
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
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(ds["Id"].toString()),
                                        Text(ds["Lahan"].toString()),
                                        Text("Umur tanaman :${ds["Umur"]}"),
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddLahan(),
                  ),
                );
              },
              child: Text("Tambah lahan"),
            )
          ],
        ),
      ),
    );
  }
}
