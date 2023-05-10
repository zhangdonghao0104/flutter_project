import 'dart:convert';

import 'package:flutter_zdh/http/Url.dart';
import 'package:flutter_zdh/http/http_manager.dart';
import 'package:flutter_zdh/model/home_banner_model.dart';
import 'package:flutter_zdh/utils/ToastUtils.dart';
import 'package:flutter_zdh/viewmodel/base_change_notifier.dart';
import 'package:flutter_zdh/widget/loading_state_widget.dart';

class HomePageViewModel extends BaseChangeNotifier {
  List<Data> bannerList = [];

  void refresh() {
    HttpManager.getData(Url.feedUrl,
        success: (json) {
          print(json);
          HomeBannerModel model = HomeBannerModel.fromJson(json);
          bannerList = model.data;
          viewState = ViewState.done;
        },
        fail: (e) {
          ToastUtils.showError(e.toString());
        },
        complete: () => notifyListeners());
  }

  retry() {
    viewState = ViewState.loading;
    notifyListeners();
    refresh();
  }
}
