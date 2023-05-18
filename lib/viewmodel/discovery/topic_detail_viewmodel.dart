import 'package:flutter_zdh/model/common_item.dart';
import 'package:flutter_zdh/model/discovery/topic_detail_model.dart';
import 'package:flutter_zdh/model/paging_model.dart';
import 'package:flutter_zdh/utils/ToastUtils.dart';
import 'package:flutter_zdh/viewmodel/base_list_viewmodel.dart';
import 'package:flutter_zdh/viewmodel/base_viewmodel.dart';
import 'package:flutter_zdh/widget/loading_state_widget.dart';

import '../../http/Url.dart';
import '../../http/http_manager.dart';

/*
* @author mousse
* @emil zdonghao0104@163.com
* create time 2023/5/18 11:46
* description:主题列表 点击 详情vm
*/
class TopicDetailViewModel extends BaseViewModel {
  TopicDetailModel topicDetailModel = TopicDetailModel();
  List<TopicDetailItemData> itemList = [];
  int _id;

  TopicDetailViewModel(this._id);

  @override
  void refresh() {
    // http://baobab.kaiyanapp.com/api/v3/lightTopics/internal/613
    HttpManager.requestData('${Url.topicsDetailUrl}$_id').then((res) {
      topicDetailModel = TopicDetailModel.fromJson(res);
      itemList = topicDetailModel.itemList;
      viewState = ViewState.done;
    }).catchError((e) {
      ToastUtils.showError(e.toString());
      viewState = ViewState.error;
    }).whenComplete(() => notifyListeners());
  }
}
