import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zdh/model/discovery/recommend_model.dart';
import 'package:flutter_zdh/widget/discovery/recommend_item_widget.dart';
import 'package:flutter_zdh/widget/discovery/recommend_loading.dart';
import 'package:loading_more_list/loading_more_list.dart';

/*
* @author mousse
* @emil zdonghao0104@163.com
* create time 2023/5/19 16:28
* description:推荐页
*/
class RecommendPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  RecommendLoading _recommendLoading = RecommendLoading();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            //x轴 两条
            final int crossAxisCount = max(
              // 父容器给的宽度 ~/ 屏幕宽度的一半
                constraints.maxWidth ~/
                    (MediaQuery.of(context).size.width / 2.0),
                2);
            //加载更多
            return LoadingMoreList<RecommendItem>(
              ListConfig <RecommendItem>(
                extendedListDelegate:
                  SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5,
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 5,
                  ),
                itemBuilder: (context,item,indel)=>RecommendItemWidget(item: item,),
                sourceList: _recommendLoading,
                padding: const EdgeInsets.all(5.0),
                lastChildLayoutType: LastChildLayoutType.foot,
              )
            );
          },
        ),
      ),

    );
  }


  @override
  void dispose() {
    super.dispose();
    _recommendLoading.dispose();
  }

  Future<void> _refresh() async {
    return _recommendLoading.refresh().whenComplete(() => null);
  }

  @override
  bool get wantKeepAlive => true;
}
