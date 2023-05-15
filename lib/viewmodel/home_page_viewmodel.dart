import 'dart:convert';

import 'package:flutter_zdh/http/Url.dart';
import 'package:flutter_zdh/http/http_manager.dart';
import 'package:flutter_zdh/model/common_item.dart';
import 'package:flutter_zdh/model/issue_model.dart';
import 'package:flutter_zdh/utils/ToastUtils.dart';
import 'package:flutter_zdh/viewmodel/base_change_notifier.dart';
import 'package:flutter_zdh/viewmodel/base_list_viewmodel.dart';
import 'package:flutter_zdh/widget/loading_state_widget.dart';


class HomePageViewModel extends BaseListViewModel<Item, IssueEntity> {
  List<Item> bannerList = [];

  // 设置请求地址
  @override
  String getUrl() => Url.feedUrl;

  // 得到真实数据模型
  @override
  IssueEntity getModel(Map<String, dynamic> json) => IssueEntity.fromJson(json);

  @override
  void getData(List<Item> list) {
    bannerList = list;
    itemList.clear();
    //为Banner占位，后面要接list列表
    itemList.add(Item());
  }

  @override
  void removeUselessData(List<Item> list) {
    // 移除类型为 'banner2' 的数据
    list.removeWhere((item) {
      return item.type == 'banner2';
    });
  }

  @override
  void doExtraAfterRefresh() async {
    // 此处调用加载更多，是为了获取首次列表数据，因为第一个列表数据用来做banner数据了。
    await loadMore();
  }

}
