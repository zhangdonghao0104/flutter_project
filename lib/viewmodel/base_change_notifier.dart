import 'package:flutter/material.dart';
import 'package:flutter_zdh/widget/loading_state_widget.dart';

class BaseChangeNotifier with ChangeNotifier {
  ViewState viewState = ViewState.loading;
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
