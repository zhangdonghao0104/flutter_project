import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zdh/config/string.dart';
import 'package:flutter_zdh/page/discovery/discovery_page.dart';
import 'package:flutter_zdh/page/home/home_page.dart';
import 'package:flutter_zdh/utils/ToastUtils.dart';
import 'package:flutter_zdh/viewmodel/tab_navigation_viewmodel.dart';
import 'package:flutter_zdh/widget/provider_widget.dart';

class TabNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  DateTime lastTime;
  Widget _currentBody = Container(color: Colors.blue);
  int _currentIndex = 0;

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop, //防用户误触 两次退出页面
        child: Scaffold(
          body: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(), //禁止viewpager滑动
            children: [
              DiscoveryPage(),
              HomePage(),
              Container(color: Colors.green),
              Container(color: Colors.amber),
            ],
          ),
          bottomNavigationBar: ProviderWidget<TabNavigationViewModel>(
            model: TabNavigationViewModel(),
            builder: (context, model, child) {
              return BottomNavigationBar(
                currentIndex: model.currentIndex,
                selectedItemColor: Color(0xff000000),
                unselectedItemColor: Color(0xff9a9a9a),
                type: BottomNavigationBarType.fixed,
                //字体固定
                items: _item(),
                onTap: (index) {
                  if (model.currentIndex != index) {
                    _pageController.jumpToPage(index);
                    model.changeBottomTabIndex(index);
                  }
                }, //点击事件
              );
            },
          ),
        ));
  }

  _onTap(int index) {
    switch (index) {
      case 0:
        _currentBody = Container(color: Colors.blue);
        break;
      case 1:
        _currentBody = Container(color: Colors.yellow);
        break;
      case 2:
        _currentBody = Container(color: Colors.red);
        break;
      case 3:
        _currentBody = Container(color: Colors.green);
        break;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  List<BottomNavigationBarItem> _item() {
    return [
      _bottomItem(StringUtils.home, 'images/ic_home_normal.png',
          'images/ic_home_selected.png'),
      _bottomItem(StringUtils.discovery, 'images/ic_discovery_normal.png',
          'images/ic_discovery_selected.png'),
      _bottomItem(StringUtils.hot, 'images/ic_hot_normal.png',
          'images/ic_hot_selected.png'),
      _bottomItem(StringUtils.mine, 'images/ic_mine_normal.png',
          'images/ic_mine_selected.png'),
    ];
  }

  _bottomItem(String title, String normalIcon, String selectIcon) {
    return BottomNavigationBarItem(
      icon: Image.asset(normalIcon, width: 24, height: 24),
      activeIcon: Image.asset(selectIcon, width: 24, height: 24),
      label: title,
    );
  }

  Future<bool> _onWillPop() async {
    if (lastTime == null ||
        DateTime.now().difference(lastTime) > Duration(seconds: 2)) {
      lastTime = DateTime.now();
      ToastUtils.showTip(StringUtils.exit_tip);
      return false;
    } else {
      // 自动出栈
      return true;
    }
  }
}
