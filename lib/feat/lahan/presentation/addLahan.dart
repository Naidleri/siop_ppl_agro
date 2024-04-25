import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:siop_ppl_agro/feat/lahan/services/services.dart';

class AddLahan extends StatelessWidget {
  const AddLahan({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController lahancontroller = TextEditingController();
    TextEditingController umurcontroller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah lahan'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: lahancontroller,
              decoration: const InputDecoration(
                labelText: 'Masukkan nama lahan',
                hintText: 'Nama lahan',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: umurcontroller,
              decoration: const InputDecoration(
                labelText: 'Masukkan umur tanaman',
                hintText: 'Umur tanaman dalam bulan',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              String Id = await DatabaseMethods().getLahanId();
              Map<String, dynamic> lahanInfoMap = {
                "Id": Id,
                "Lahan": lahancontroller.text,
                "Umur": umurcontroller.text,
              };
              await DatabaseMethods().addLahan(lahanInfoMap).then((value) => {
                    Fluttertoast.showToast(
                        msg: "Data lahan berhasil ditambah",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0)
                  });
            },
            child: const Text('Tambah lahan'),
          ),
        ],
      ),
    );
  }
}
