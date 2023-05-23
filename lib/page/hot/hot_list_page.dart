import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zdh/model/common_item.dart';
import 'package:flutter_zdh/state/base_list_state.dart';
import 'package:flutter_zdh/viewmodel/hot/hot_list_viewmodel.dart';
import 'package:flutter_zdh/widget/list_item_widget.dart';

class HotListPage extends StatefulWidget {
  final String apiUrl;

  const HotListPage({Key key, this.apiUrl}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HotListPageState();
}

class _HotListPageState
    extends BaseListState<Item, HotListViewModel, HotListPage> {
  @override
  Widget getContentChild(HotListViewModel model) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListItemWidget(item: model.itemList[index]);
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Divider(height: 0.5),
          );
        },
        itemCount: model.itemList.length);
  }

  @override
  void init() {
    enablePullUp = false;
  }

  @override
  HotListViewModel get viewModel => HotListViewModel(widget.apiUrl);
}
