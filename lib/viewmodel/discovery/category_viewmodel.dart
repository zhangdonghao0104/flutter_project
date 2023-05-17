
import 'package:flutter/cupertino.dart';
import 'package:flutter_zdh/http/Url.dart';
import 'package:flutter_zdh/http/http_manager.dart';
import 'package:flutter_zdh/model/discovery/category_model.dart';
import 'package:flutter_zdh/utils/ToastUtils.dart';
import 'package:flutter_zdh/utils/log_utils.dart';
import 'package:flutter_zdh/viewmodel/base_viewmodel.dart';

import '../../widget/loading_state_widget.dart';

/*
* @author mousse
* @emil zdonghao0104@163.com
* create time 2023/5/17 10:06
* description:获取分类接口数据 页面状态控制
*/
class CategoryViewModel extends BaseViewModel{
  List<CategoryModel> list = [];

  @override
  void refresh() async{
    HttpManager.getData(
      Url.categoryUrl,
      success: (result) {
        print('分类请求成功了');
        // print(result.toString());
        // debugPrint('mousse',result:result.toString());
        list = (result as List)
            .map((model) => CategoryModel.fromJson(model))
            .toList();
        viewState = ViewState.done;
      },
      fail: (e){
        ToastUtils.showError(e.toString());
        viewState = ViewState.error;
      },
      complete: () => notifyListeners(),
    );
  }

}