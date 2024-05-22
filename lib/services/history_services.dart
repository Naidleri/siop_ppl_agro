import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:siop_ppl_agro/models/historyModel.dart';

class HistoryServices {
  Stream<QuerySnapshot> getHistory(String id) {
    return FirebaseFirestore.instance.collection("history$id").snapshots();
  }
}
