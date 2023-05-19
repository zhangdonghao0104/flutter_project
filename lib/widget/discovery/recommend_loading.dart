import 'dart:convert';

import 'package:flutter_zdh/http/Url.dart';
import 'package:flutter_zdh/http/http_manager.dart';
import 'package:flutter_zdh/model/discovery/recommend_model.dart';
import 'package:flutter_zdh/utils/ToastUtils.dart';
import 'package:loading_more_list/loading_more_list.dart';

/*
* @author mousse
* @emil zdonghao0104@163.com
* create time 2023/5/19 16:09
* description:推荐页 流式布局 加载管理类
*/
class RecommendLoading extends LoadingMoreBase<RecommendItem> {
  String nextPageUrl;
  bool _hasMore = true;
  bool forceRefresh = false;
  Utf8Decoder utf8decoder = Utf8Decoder();

  @override
  bool get hasMore => _hasMore || forceRefresh;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    forceRefresh = !notifyStateChanged;
    // 内部加载数据
    final bool result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    String url = '';
    if (isloadMoreAction) {
      url = nextPageUrl;
    } else {
      url = Url.communityUrl;
    }

    return HttpManager.requestData(url, headers: Url.httpHeader).then((result) {
      RecommendModel model = RecommendModel.fromJson(result);
      model.itemList.removeWhere((item) {
        return item.type == 'horizontalScrollCard';
      });
      if (!isloadMoreAction) {
        clear();
      }
      addAll(model.itemList);
      nextPageUrl = model.nextPageUrl;
      _hasMore = nextPageUrl != null;
      return true;
    }).catchError((e) {
      ToastUtils.showError(e.toString());
      return false;
    });
  }
}
