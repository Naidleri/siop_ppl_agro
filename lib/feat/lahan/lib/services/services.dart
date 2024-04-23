import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<String> getLahanId() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Lahan')
        .orderBy('Id', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      int lastId = int.parse(querySnapshot.docs.first.id.substring(5));
      return 'lahan${lastId + 1}';
    } else {
      return 'lahan1';
    }
  }

  Future addLahan(Map<String, dynamic> lahanInfoMap) async {
    String nextLahanId = await getLahanId();
    return await FirebaseFirestore.instance
        .collection("Lahan")
        .doc(nextLahanId)
        .set(lahanInfoMap);
  }
}
