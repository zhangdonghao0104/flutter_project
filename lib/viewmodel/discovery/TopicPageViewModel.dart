
import 'package:flutter_zdh/http/Url.dart';
import 'package:flutter_zdh/model/discovery/topic_model.dart';
import 'package:flutter_zdh/viewmodel/base_list_viewmodel.dart';

class TopicPageViewModel extends BaseListViewModel<TopicItemModel,TopicModel>{

  @override
  TopicModel getModel(Map<String, dynamic> json) {
    return TopicModel.fromJson(json);
  }

  @override
  String getUrl() {
    return Url.topicsUrl;
  }

}