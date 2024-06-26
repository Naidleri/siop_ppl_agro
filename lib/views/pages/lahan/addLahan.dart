import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siop_ppl_agro/models/lahanModel.dart';
import 'package:siop_ppl_agro/providers/lahan.dart';
import 'package:siop_ppl_agro/services/notifikasi_services.dart';
import 'package:siop_ppl_agro/views/pages/sensor/sensor.dart';

class AddLahan extends StatefulWidget {
  final NotificationService notificationService;
  const AddLahan({Key? key, required this.notificationService});

  @override
  _AddLahanState createState() => _AddLahanState();
}

class _AddLahanState extends State<AddLahan> {
  final TextEditingController lahancontroller = TextEditingController();
  final TextEditingController umurcontroller = TextEditingController();
  bool isFormValid = false;
  bool isUmurValid = true;
  int? _umur;

  @override
  void initState() {
    super.initState();
    lahancontroller.addListener(_validateForm);
    umurcontroller.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      isUmurValid = int.tryParse(umurcontroller.text) != null;
      _umur = int.tryParse(umurcontroller.text);
      isFormValid = lahancontroller.text.isNotEmpty &&
          umurcontroller.text.isNotEmpty &&
          isUmurValid;
    });
  }

  @override
  void dispose() {
    lahancontroller.dispose();
    umurcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              padding: MediaQuery.of(context).viewInsets,
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
                    const SizedBox(height: 20),
                    const Text(
                      "Nama lahan",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 3),
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
                    const SizedBox(height: 3),
                    TextField(
                      controller: umurcontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Umur tanaman',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: !isUmurValid,
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Umur tanaman harus berupa angka',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !isFormValid && isUmurValid,
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Data harus diisi',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: isFormValid
                                ? () async {
                                    final lahanProvider =
                                        Provider.of<LahanProvider>(context,
                                            listen: false);
                                    int Id =
                                        await lahanProvider.getLahanId();
                                    Lahan lahan = Lahan(
                                      id: Id,
                                      nama: lahancontroller.text,
                                      umur: _umur!,
                                    );
                                    await lahanProvider.addLahan(lahan);
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Sukses, lahan berhasil ditambahkan',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SensorPage(
                                          lahanId: Id,
                                          lahanName: lahancontroller.text,
                                          notificationService:
                                              widget.notificationService,
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isFormValid
                                  ? const Color.fromARGB(255, 24, 152, 119)
                                  : Colors.grey,
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
                                fontWeight: FontWeight.w600,
                              ),
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
        backgroundColor: const Color.fromRGBO(24, 152, 119, 1),
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
