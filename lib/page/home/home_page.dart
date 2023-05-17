import 'package:flutter/material.dart';
import 'package:flutter_zdh/config/string.dart';
import 'package:flutter_zdh/widget/app_bar.dart';
import 'package:flutter_zdh/widget/home_body_page.dart';
import 'package:flutter_zdh/widget/loading_state_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: appBar(
        StringUtils.home,
        showBack: false,
        backgroundColor: Colors.green
      ),
      body: HomeBodyPage()
    );
  }
}
