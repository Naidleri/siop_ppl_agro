import 'package:flutter/material.dart';
import 'package:siop_ppl_agro/views/pages/lahan/lahan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<dynamic> DeleteLahanButton(
    BuildContext context, FlutterLocalNotificationsPlugin notificationsPlugin) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Lahan berhasil dihapus"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HomeLahan(notificationsPlugin: notificationsPlugin),
                ),
              );
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
