import 'package:flutter_zdh/viewmodel/base_change_notifier.dart';

class RecommendPhotoViewModel extends BaseChangeNotifier {
  int currentIndex = 1;

  changeIndex(int index) {
    this.currentIndex = index + 1;
    notifyListeners();
  }
}