import 'package:cloud_firestore/cloud_firestore.dart';

class LahanServices {
  Future<String> getLahanId() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Lahan')
        .orderBy('Id', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      int lastId = int.parse(querySnapshot.docs.first.id);
      //  int lastId = int.parse(querySnapshot.docs.first.id.substring(5));
      return '${lastId + 1}';
    } else {
      return '1';
    }
  }

  Future<void> addLahan(Map<String, dynamic> lahanInfoMap) async {
    String nextLahanId = await getLahanId();
    await FirebaseFirestore.instance
        .collection("Lahan")
        .doc(nextLahanId)
        .set(lahanInfoMap);
  }

  Stream<QuerySnapshot> getLahan() {
    return FirebaseFirestore.instance.collection('Lahan').snapshots();
  }

  Future<void> deleteLahan(String id) async {
    await FirebaseFirestore.instance.collection("Lahan").doc(id).delete();
  }
}
