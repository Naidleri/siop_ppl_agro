import 'package:flutter/material.dart';
import 'package:siop_ppl_agro/providers/lahan.dart';
import 'package:siop_ppl_agro/services/notifikasi_services.dart';
import 'package:siop_ppl_agro/views/pages/lahan/lahan.dart';

Future<void> DeleteLahanButton(BuildContext context, int lahanId,
    NotificationService notificationService) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Apakah Anda yakin ingin menghapus lahan ini?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Tidak",
              style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await LahanProvider().deleteLahan(lahanId);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Lahan berhasil dihapus"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeLahan(
                                  notificationService: notificationService),
                            ),
                          );
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text("Ya"),
          ),
        ],
      );
    },
  );
}
