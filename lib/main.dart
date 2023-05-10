import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zdh/app_init.dart';
import 'package:flutter_zdh/http/http_manager.dart';
import 'package:flutter_zdh/tab_navigation.dart';

void main() {
  runApp(const MyApp());
  //
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  const MyApp

  ({key});

  @override
  Widget build(BuildContext context) {
    //异步ui更新
    return FutureBuilder(
      future: AppInit.init(),
      builder: (context, snapshot) {
        HttpManager.getData(
          "http://www.wanandroid.com/banner/json",
          success: (result) {
            print(result);
          },
        );
        print(snapshot.connectionState);
        var widget = snapshot.connectionState == ConnectionState.done
            ? TabNavigation()
            : Scaffold(
          body: Center(
            //加载条
            child: CircularProgressIndicator(),
          ),
        );
        return GetMaterialAppWidget(child: widget);
      },
    );
  }
}

class GetMaterialAppWidget extends StatefulWidget {
  final Widget child;

  GetMaterialAppWidget({Key key,   this.child}) : super(key: key);

  @override
  _GetMaterialAppWidgetState createState() => _GetMaterialAppWidgetState();
}

class _GetMaterialAppWidgetState extends State<GetMaterialAppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EyePetizer',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => widget.child,
      },
    );
  }
}
