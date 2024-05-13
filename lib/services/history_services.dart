import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:siop_ppl_agro/models/historyModel.dart';

class HistoryServices {
  final _database = FirebaseDatabase.instance.ref("sensor");

  Stream getSensorDataStream() {
    return _database.onChildAdded;
  }

  Stream<DocumentSnapshot> getHistory(String lahanId) {
    return FirebaseFirestore.instance.collection("history").doc(lahanId).snapshots();
  }
  
}
