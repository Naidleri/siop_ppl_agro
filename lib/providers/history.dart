import 'package:flutter/material.dart';
import 'package:siop_ppl_agro/models/historyModel.dart';
import 'package:siop_ppl_agro/services/history_services.dart';

class HistoryProvider extends ChangeNotifier {
  final HistoryServices _serviceHistory = HistoryServices();

  Stream<List<History>> getHistory(String id) {
    return _serviceHistory.getHistory(id);
  }
}
