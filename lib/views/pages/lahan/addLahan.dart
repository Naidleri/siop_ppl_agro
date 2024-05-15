import 'package:flutter/material.dart';
import 'package:siop_ppl_agro/services/lahan_services.dart';
import 'package:siop_ppl_agro/views/pages/lahan/lahan.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AddLahan extends StatelessWidget {
  final FlutterLocalNotificationsPlugin notificationsPlugin;

  const AddLahan({Key? key, required this.notificationsPlugin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController lahancontroller = TextEditingController();
    TextEditingController umurcontroller = TextEditingController();

    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Tambah lahan",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.black,
                      padding: const EdgeInsets.only(bottom: 10),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Nama lahan",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextField(
                      controller: lahancontroller,
                      decoration: const InputDecoration(
                        hintText: 'Nama lahan',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Umur tanaman",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextField(
                      controller: umurcontroller,
                      decoration: const InputDecoration(
                        hintText: 'Umur tanaman',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 164, 36, 36),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              textStyle: const TextStyle(fontSize: 14.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              'Batal',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () async {
                              String Id = await LahanServices().getLahanId();
                              Map<String, dynamic> lahanInfoMap = {
                                "Id": Id,
                                "Lahan": lahancontroller.text,
                                "Umur": umurcontroller.text,
                              };
                              await LahanServices().addLahan(lahanInfoMap);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeLahan(
                                    notificationsPlugin: notificationsPlugin,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 24, 152, 119),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              textStyle: const TextStyle(fontSize: 14.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              'Simpan',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
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
            const Color.fromRGBO(24, 152, 119, 1), // Custom green color
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
