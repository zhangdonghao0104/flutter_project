
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zdh/config/string.dart';
import 'package:flutter_zdh/utils/ToastUtils.dart';

class TabNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  late DateTime lastTime;
  Widget _currentBody = Container(color: Colors.blue);
  int _cuttentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: _currentBody,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _cuttentIndex,
            selectedItemColor: Color(0xff000000),
            unselectedItemColor: Color(0xff9a9a9a),
            type: BottomNavigationBarType.fixed,//字体固定
            items: _item(),
            onTap: _onTap,
          ),
        ));
  }

  _onTap(int index) {
    switch (index) {
      case 0:
        _currentBody = Container(color: Colors.blue);
        break;
      case 1:
        _currentBody = Container(color: Colors.white);
        break;
      case 2:
        _currentBody = Container(color: Colors.red);
        break;
      case 3:
        _currentBody = Container(color: Colors.green);
        break;
    }
    setState(() {
      _cuttentIndex = index;
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
