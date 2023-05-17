import 'package:flutter/cupertino.dart';
import 'package:flutter_zdh/viewmodel/base_viewmodel.dart';
import 'package:flutter_zdh/widget/provider_widget.dart';

import '../widget/loading_state_widget.dart';

/*
* @author mousse
* @emil zdonghao0104@163.com
* create time 2023/5/17 9:46
* description: 通用分页state封装
*/
abstract class BaseState<M extends BaseViewModel, T extends StatefulWidget>
    extends State<T>
    with AutomaticKeepAliveClientMixin {
  M get viewModel;

  Widget getContentChild(M model); //真实的分页控件

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return ProviderWidget<M>(
        model: viewModel,
        onModelInit: (model)=>model.refresh(),
      builder: (context, model, child) {
        return LoadingStateWidget(
          viewState: model.viewState,
          retry: model.retry,
          child: getContentChild(model),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
