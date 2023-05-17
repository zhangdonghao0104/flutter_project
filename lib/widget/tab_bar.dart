import 'package:flutter/material.dart';
import 'package:flutter_zdh/config/color.dart';

TabBar tabBar({
  TabController tabController,
  List<Widget> tabs,
  ValueChanged<int> onTap,
  double fontSize = 14,
  Color labelColor = Colors.black,
  //未选中的颜色
  Color unselectedLabelColor = ColorUtils.hitTextColor,
  //下划线的颜色
  Color indicatorColor = Colors.black,
  //下划线的宽度 大小
  TabBarIndicatorSize indicatorSize = TabBarIndicatorSize.label,


}) {
  return TabBar(
    isScrollable: false,
    controller: tabController,
    tabs: tabs,
    onTap: onTap,//点击 变化控制
    labelColor: labelColor,
    unselectedLabelColor: unselectedLabelColor,
    labelStyle: TextStyle(fontSize: fontSize),
    unselectedLabelStyle: TextStyle(fontSize: fontSize),
    indicatorColor: indicatorColor,
    indicatorSize: indicatorSize,
    physics: NeverScrollableScrollPhysics(),
  );
}
