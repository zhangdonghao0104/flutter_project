import 'package:flutter_splash_screen/flutter_splash_screen.dart';

class AppInit {
  AppInit._();

  static Future<void> init() async {
    Future.delayed(Duration(microseconds: 4000), () {
      FlutterSplashScreen.hide();
    });
  }
}
