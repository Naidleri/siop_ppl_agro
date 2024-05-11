import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:siop_ppl_agro/models/historyModel.dart';

class HistoryServices {
  final _database = FirebaseDatabase.instance.ref("sensor");
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream getSensorDataStream() {
    return _database.onChildAdded;
  }

  // Future<void> updateHistoryData(HistoryData historyData) async {
  //   final historyRef =
  //       _firestore.collection('history').doc(historyData.id.toString());

  //   final existingHistoryData = await historyRef.get();
  //   if (existingHistoryData.exists) {
  //     final timestamps = historyData.timestamps;
  //     timestamps.removeAt(0);
  //     timestamps.add(DateTime.now().millisecondsSinceEpoch);

  //     await historyRef.update({
  //       'timestamps': timestamps,
  //     });
  //   } else {
  //     await historyRef.set({
  //       'id': historyData.id,
  //       'timestamps': historyData.timestamps,
  //     });
  //   }
  // }
}
