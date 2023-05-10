import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutter_zdh/http/Url.dart';

class AppInit {
  AppInit._();

  static Future<void> init() async {
    Url.baseUrl = 'http://www.wanandroid.com/banner/json';
    Future.delayed(Duration(milliseconds: 2000), () {
      FlutterSplashScreen.hide();
    });
  }
}
