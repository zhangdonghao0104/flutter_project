import 'dart:convert';

import 'package:flutter_zdh/utils/history_repository.dart';
import 'package:flutter_zdh/viewmodel/base_change_notifier.dart';

import '../../model/common_item.dart';


class WatchHistoryViewModel extends BaseChangeNotifier {
  List<Data> itemList = [];
  List<String> watchList = [];

  void loadData() {
    watchList = HistoryRepository.loadHistoryData();
    if (watchList != null) {
      var list = watchList.map((value) {
        return Data.fromJson(json.decode(value));
      }).toList();
      itemList = list;
      notifyListeners();
    }
  }

  void remove(int index) {
    watchList.removeAt(index);
    HistoryRepository.saveHistoryData(watchList);
    loadData();
  }
}