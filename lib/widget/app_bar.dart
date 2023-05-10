import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
* @author mousse
* @emil zdonghao0104@163.com
* create time 2023/5/10 11:23
* description:顶部导航栏
*/
appBar(String title, {bool showBack = true, List<Widget> actions}) {
  return AppBar(
      //透明模式:light
      brightness: Brightness.light,
      //title 居中
      centerTitle: true,
      //阴影高度
      elevation: 0,
      //背景色
      backgroundColor: Colors.blue,
      //导航栏最左侧widget:是否显示返回按钮
      leading: showBack ? BackButton(color: Colors.blue) : null,
      //导航栏右侧list<widget>
      actions: actions,
      //title文字样式
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.normal),
      ));
}
