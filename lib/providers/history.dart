import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siop_ppl_agro/models/historyModel.dart';
import 'package:siop_ppl_agro/services/history_services.dart';

class HistoryProvider extends ChangeNotifier {
  final HistoryServices _serviceHistory = HistoryServices();

  Stream<QuerySnapshot> getHistory(String id) {
    return _serviceHistory.getHistory(id);
  }
}
