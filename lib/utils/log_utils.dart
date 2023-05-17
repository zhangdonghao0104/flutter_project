/*
* @author mousse
* @emil zdonghao0104@163.com
* create time 2023/5/17 14:06
* description:日志封装
*/
class Logger {
  static final Logger _instance = Logger._internal();

  factory Logger() {
    return _instance;
  }

  Logger._internal();

  void log(String tag, String message) {
    print('[$tag] $message');
  }
}
