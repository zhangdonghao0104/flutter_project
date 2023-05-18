import 'package:flutter/material.dart';
import 'package:flutter_zdh/model/discovery/topic_detail_model.dart';
import 'package:flutter_zdh/state/base_state.dart';
import 'package:flutter_zdh/utils/cache_image.dart';
import 'package:flutter_zdh/viewmodel/discovery/topic_detail_viewmodel.dart';
import 'package:flutter_zdh/widget/app_bar.dart';
import 'package:flutter_zdh/widget/discovery/topic_detail_item_widget.dart';

/*
* @author mousse
* @emil zdonghao0104@163.com
* create time 2023/5/18 15:15
* description:主题详情页
*/
class TopicDetailPage extends StatefulWidget {
  final int detailId;

  const TopicDetailPage({Key key, this.detailId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TopicDetailPageState();
}

class _TopicDetailPageState
    extends BaseState<TopicDetailViewModel, TopicDetailPage> {
  @override
  Widget getContentChild(TopicDetailViewModel model) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(model.topicDetailModel.brief,
          showBack: true, backgroundColor: Color(0xffffff)),
      body: CustomScrollView(
        slivers: <Widget>[
          _headWidget(model.topicDetailModel),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return TopicDetailItemWidget(model: model.itemList[index]);
              },
              childCount: model.itemList.length,
            ),
          )
        ],
      ),
    );
  }

  Widget _headWidget(TopicDetailModel topicDetailModel) {
    return SliverToBoxAdapter(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              //标题下的图片
              cacheImage(
                topicDetailModel.headerImage,
                width: MediaQuery.of(context).size.width,
                height: 250,
              ),
              //图片下的文案
              Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
                child: Text(
                  topicDetailModel.text,
                  style: TextStyle(fontSize: 12, color: Color(0xff9a9a9a)),
                ),
              ),
              //文案下的分割线
              Container(
                height: 5,
                color: Colors.black12,
              ),
            ],
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 230,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              alignment: Alignment.center,
              child: Text(
                topicDetailModel.brief,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFF5F5F5)),
                  borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement viewModel
  TopicDetailViewModel get viewModel => TopicDetailViewModel(widget.detailId);
}
