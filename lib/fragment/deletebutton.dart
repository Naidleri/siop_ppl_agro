import 'package:flutter/material.dart';
import 'package:siop_ppl_agro/feat/lahan/presentation/lahan.dart';

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
