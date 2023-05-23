import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_zdh/config/string.dart';
import 'package:flutter_zdh/page/video/video_item_widget.dart';
import 'package:flutter_zdh/utils/navigation_utils.dart';
import 'package:flutter_zdh/viewmodel/mine/watch_history_viewmodel.dart';
import 'package:flutter_zdh/widget/app_bar.dart';
import 'package:flutter_zdh/widget/provider_widget.dart';

class WatchHistoryPage extends StatefulWidget {
  @override
  _WatchHistoryPageState createState() => _WatchHistoryPageState();
}

class _WatchHistoryPageState extends State<WatchHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(StringUtils.watch_history,showBack: true,backgroundColor: Colors.white,backBottomColor: Colors.grey),
      body: ProviderWidget<WatchHistoryViewModel>(
        model: WatchHistoryViewModel(),
        onModelInit: (model) {
          model.loadData();
        },
        builder: (context, model, child) {
          return Stack(
            children: <Widget>[
              _haveData(model),
              _noData(model),
            ],
          );
        },
      ),
    );
  }

  /// 有数据时显示的Widget
  Widget _haveData(WatchHistoryViewModel model) {
    return Offstage(
      offstage: model.itemList == null || model.itemList.length == 0,
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListView.separated(
          itemCount: model.itemList?.length ?? 0,
          itemBuilder: (context, index) {
            // 侧滑删除
            return _slidable(model, index);
          },
          separatorBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.only(left: 15, top: 5, right: 15),
                child: Divider(height: 0.5));
          },
        ),
      ),
    );
  }


// 侧滑删除
  Widget _slidable(WatchHistoryViewModel model, int index) {
    return Slidable(
      // 滑出选项的面板 动画
      actionPane: SlidableDrawerActionPane(),
      child: VideoItemWidget(
        data: model.itemList[index],
        callBack: () {
          // TODO:跳转到 '/detail'
          toNamed('/detail', model.itemList[index]);
        },
        titleColor: Colors.black87,
        categoryColor: Colors.black26,
        openHero: true,
      ),
      // 右侧按钮列表
      secondaryActions: <Widget>[
        IconSlideAction(
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => model.remove(index),
        ),
      ],
    );
  }

  /// 没有数据时显示的Widget
  Widget _noData(WatchHistoryViewModel model) {
    return Offstage(
      //控制控件显示或隐藏
      offstage: model.itemList != null && model.itemList.length > 0,
      child: Center(
        child: Image.asset(
          'images/ic_no_data.png',
        ),
      ),
    );
  }
}