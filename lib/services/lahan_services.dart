import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siop_ppl_agro/models/lahanModel.dart';

class LahanServices {
  Future<int> getLahanId() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('lahan')
        .orderBy('Id', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      Map<String, dynamic>? data =
          querySnapshot.docs.first.data() as Map<String, dynamic>?;
      int lastId = data?['Id'] ?? 0;
      return lastId + 1;
    } else {
      return 1;
    }
  }

  Future<void> addLahan(Lahan lahan) async {
    int nextLahanId = await getLahanId();
    lahan = Lahan(id: nextLahanId, nama: lahan.nama, umur: lahan.umur);
    await FirebaseFirestore.instance
        .collection("lahan")
        .doc(nextLahanId.toString())
        .set(lahan.toMap());
  }

  Stream<List<Lahan>> getLahan() {
    return FirebaseFirestore.instance.collection('lahan').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Lahan.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<void> deleteLahan(int id) async {
    await FirebaseFirestore.instance
        .collection("lahan")
        .doc(id.toString())
        .delete();
  }
}
