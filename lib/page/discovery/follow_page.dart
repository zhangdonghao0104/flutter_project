import 'package:flutter/material.dart';
import 'package:flutter_zdh/model/common_item.dart';
import 'package:flutter_zdh/state/base_list_state.dart';
import 'package:flutter_zdh/viewmodel/discovery/follow_viewmodel.dart';
import 'package:flutter_zdh/widget/discovery/follow_item_widget.dart';

class FollowPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FollowPage();
}

class _FollowPage extends BaseListState<Item, FollowViewModel, FollowPage> {
  @override
  Widget getContentChild(FollowViewModel model) => ListView.separated(
      itemBuilder: (context, index) {
        return FollowItemWidget(item: model.itemList[index]);
      },
      separatorBuilder: (context, index) => Divider(
            height: 0.5,
          ),
      itemCount: model.itemList.length);

  @override
  // TODO: implement viewModel
  FollowViewModel get viewModel => FollowViewModel();
}
