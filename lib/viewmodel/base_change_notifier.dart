import 'package:flutter/material.dart';

class BaseChangeNotifier with ChangeNotifier {
  bool _dispose = false; //页面销毁不发送通知
  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    if (!_dispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dispose = true;
  }
}
