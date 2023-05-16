import 'package:flutter_zdh/http/Url.dart';
import 'package:flutter_zdh/http/http_manager.dart';
import 'package:flutter_zdh/model/common_item.dart';
import 'package:flutter_zdh/utils/ToastUtils.dart';
import 'package:flutter_zdh/viewmodel/base_change_notifier.dart';
import 'package:flutter_zdh/widget/loading_state_widget.dart';

class VideoDetailViewModel extends BaseChangeNotifier {
  List<Item> itemList = [];
  int _videoId;

  void loadVideoData(int id) {
    _videoId = id;
    // https://baobab.kaiyanapp.com/api/v4/video/related?id=266986
    HttpManager.requestData('${Url.videoRelatedUrl}$id').then((res) {
      Issue issue = Issue.fromJson(res);
      itemList = issue.itemList;
      viewState = ViewState.done;
    }).catchError((e) {
      ToastUtils.showError(e.toString());
      viewState = ViewState.error;
    }).whenComplete(() => notifyListeners());
  }

  void retry() {
    viewState = ViewState.loading;
    notifyListeners();
    loadVideoData(_videoId);
  }
}
