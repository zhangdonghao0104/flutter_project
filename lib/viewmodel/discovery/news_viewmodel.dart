
import 'dart:io';

import 'package:flutter_zdh/http/Url.dart';
import 'package:flutter_zdh/model/discovery/news_model.dart';
import 'package:flutter_zdh/viewmodel/base_list_viewmodel.dart';

class NewsViewModel extends BaseListViewModel<NewsItemModel, NewsModel> {
  @override
  NewsModel getModel(Map<String, dynamic> json) {
    return NewsModel.fromJson(json);
  }


  @override
  String getNextUrl(NewsModel model) {
    String deviceModel = Platform.isAndroid ? "Android" : "IOS";
    return "${model.nextPageUrl}&vc=6030000&deviceModel=$deviceModel";
  }

  @override
  String getUrl() {
    String deviceModel = Platform.isAndroid ? "Android" : "IOS";
    return Url.newsUrl + deviceModel;
  }
}
