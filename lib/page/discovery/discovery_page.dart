import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zdh/config/string.dart';
import 'package:flutter_zdh/page/discovery/news_page.dart';
import 'package:flutter_zdh/page/discovery/recommend_page.dart';
import 'package:flutter_zdh/page/discovery/topic_page.dart';
import 'package:flutter_zdh/page/discovery/category_page.dart';
import 'package:flutter_zdh/page/discovery/follow_page.dart';
import 'package:flutter_zdh/widget/app_bar.dart';
import 'package:flutter_zdh/widget/tab_bar.dart';

const TAB_LABEL = ['关注', '分类', '专题', '资讯', '推荐'];

class DiscoveryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return Scaffold(
      appBar: appBar(
        StringUtils.discovery,
        showBack: false,
        backgroundColor: Colors.white,
        //tabBar与tabVarView结合使用
        bottom: tabBar(
          // 与TabBarView 同一个 controller
          tabController: _tabController,
          labelColor: Colors.green,
          indicatorColor: Colors.green,
          tabs: TAB_LABEL.map((String label) {
            return Tab(text: label);
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        // physics: NeverScrollableScrollPhysics(),//禁止左右滑动
        children: <Widget>[
          FollowPage(),
          CategoryPage(),
          TopicPage(),
          NewsPage(),
          RecommendPage(),
        ],
      ),
    );
  }

  Container _flexibleSpace() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ic_img_avatar.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _onTap() {}

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: TAB_LABEL.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
