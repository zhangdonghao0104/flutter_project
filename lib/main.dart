import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zdh/app_init.dart';
import 'package:flutter_zdh/http/http_manager.dart';
import 'package:flutter_zdh/page/video/video_detail_pager.dart';
import 'package:flutter_zdh/tab_navigation.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
  //
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    //异步ui更新
    return FutureBuilder(
      future: AppInit.init(),
      builder: (context, snapshot) {
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

  GetMaterialAppWidget({Key key, this.child}) : super(key: key);

  @override
  _GetMaterialAppWidgetState createState() => _GetMaterialAppWidgetState();
}

class _GetMaterialAppWidgetState extends State<GetMaterialAppWidget> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EyePetizer',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => widget.child),
        GetPage(name: '/detail', page: () => VideoDetailPage()),

      ],
    );
  }
}
