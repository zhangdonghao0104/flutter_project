import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zdh/config/string.dart';
import 'package:flutter_zdh/page/home/search_page.dart';
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
        backgroundColor: Colors.white,
        actions: <Widget>[
          _searchIcon()
        ]
      ),
      body: HomeBodyPage(),
    );
  }

  Widget _searchIcon(){
    return OpenContainer(closedBuilder: (context,action){
      return Icon(Icons.search,color: Colors.black87,);
    }, openBuilder: (context,action){
      return SearchPage();
    });
  }
}
