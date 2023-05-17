import 'package:flutter_zdh/http/Url.dart';
import 'package:flutter_zdh/model/issue_model.dart';
import 'package:flutter_zdh/model/paging_model.dart';
import 'package:flutter_zdh/viewmodel/base_list_viewmodel.dart';

import '../../model/common_item.dart';

class FollowViewModel extends BaseListViewModel<Item, Issue> {


  @override
  String getUrl() {
    // TODO: implement getUrl
    return Url.followUrl;
  }

  @override
  Issue getModel(Map<String, dynamic> json) =>Issue.fromJson(json);

}