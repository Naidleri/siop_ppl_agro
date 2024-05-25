import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siop_ppl_agro/models/historyModel.dart';

class HistoryServices {
  Stream<List<History>> getHistory(String id) {
    return FirebaseFirestore.instance.collection("history$id").snapshots().map(
        (snaphsot) =>
            snaphsot.docs.map((doc) => History.fromMap(doc.data())).toList());
  }
}
