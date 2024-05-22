import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siop_ppl_agro/providers/history.dart';

class HistoryScreen extends StatelessWidget {
  final String lahanId;

  HistoryScreen({required this.lahanId});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Consumer<HistoryProvider>(
      builder: (context, historyProvider, child) {
        return StreamBuilder<QuerySnapshot>(
          stream: historyProvider.getHistory(lahanId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
              return const Center(
                child: Text(
                  'Riwayat belum tersedia',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data.docs[index];
                      String timestampString = ds['timestamp'];

                      return Container(
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            timestampString,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    ));
  }
}
