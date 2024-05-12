import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siop_ppl_agro/services/lahan_services.dart';

class LahanProvider extends ChangeNotifier {
  final LahanServices _lahanServices = LahanServices();

  Future<String> getLahanId() async {
    return _lahanServices.getLahanId();
  }

  Future<void> addLahan(Map<String, dynamic> lahanInfoMap) async {
    await _lahanServices.addLahan(lahanInfoMap);
    notifyListeners();
  }

  Stream<QuerySnapshot> getLahan() {
    return _lahanServices.getLahan();
  }

  Future<void> deleteLahan(String id) async {
    await _lahanServices.deleteLahan(id);
    notifyListeners();
  }
}
