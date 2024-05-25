import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siop_ppl_agro/models/lahanModel.dart';

class LahanServices {
  Future<String> getLahanId() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('lahan')
        .orderBy('Id', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      int lastId = int.parse(querySnapshot.docs.first.id);
      return '${lastId + 1}';
    } else {
      return '1';
    }
  }

  Future<void> addLahan(Lahan lahan) async {
    String nextLahanId = await getLahanId();
    await FirebaseFirestore.instance
        .collection("lahan")
        .doc(nextLahanId)
        .set(lahan.toMap());
  }

  Stream<List<Lahan>> getLahan() {
    return FirebaseFirestore.instance.collection('lahan').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Lahan.fromMap(doc.data())).toList());
  }

  Future<void> deleteLahan(String id) async {
    await FirebaseFirestore.instance.collection("lahan").doc(id).delete();
  }
}
