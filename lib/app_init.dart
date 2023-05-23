import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutter_zdh/http/Url.dart';
import 'package:flutter_zdh/utils/cache_manager.dart';

class AppInit {
  AppInit._();

  static Future<void> init() async {
    await CacheManager.preInit();
    Future.delayed(Duration(milliseconds: 2000), () {
      FlutterSplashScreen.hide();
    });
  }
}
