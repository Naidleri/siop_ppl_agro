import 'package:flutter/material.dart';
import 'package:siop_ppl_agro/views/pages/lahan/lahan.dart';

Future<dynamic> DeleteLahanButton(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Lahan berhasil dihapus"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeLahan(),
                ),
              );
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}
