import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HttpManager {
  static Utf8Decoder utf8decoder = Utf8Decoder();

  static void getData(String url, {Map<String, String> headers,
        Function success,
        Function fail,
        Function complete}) async {
    try {

      final dio = Dio();


      // var response = await http.get(Uri.parse(url), headers: {
      //   'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
      //   'Authority':'baobab.kaiyanapp.com',
      //   'Accept': 'application/json, text/plain, */*',
      //   'Accept-Encoding': 'gzip, deflate, br',
      //   'Accept-Language': 'zh-CN,zh;q=0.9',
      //   'Connection': 'keep-alive',
      //   'Content-Type': 'application/json',
      // });
      dio.options.headers = {
        'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
        'Authority':'baobab.kaiyanapp.com',
        'Accept': 'application/json, text/plain, */*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Connection': 'keep-alive',
        'Content-Type': 'application/json',
      };
      final response = await dio.get(url);
      if(response.statusCode == 200){
        var result = response.data;
       // var decode = json.decode(utf8decoder.convert(response.bodyBytes));
        print(result);
        success(result);

      }
    } catch (e) {
      print(e.toString());
      fail(e);
    } finally {
      if (complete != null) {
        complete();
      }
    }
  }

  // 解析JSON数据
  void parseJsonData(Response response) {

  }

  static Future requestData(String url, {Map<String, String> headers}) async {
    try {
      final dio = Dio();
      dio.options.headers = {
        'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1',
        'Authority':'baobab.kaiyanapp.com',
        'Accept': 'application/json, text/plain, */*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept-Language': 'zh-CN,zh;q=0.9',
        'Connection': 'keep-alive',
        'Content-Type': 'application/json',
      };
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        var result = response.data;
        print(result);
        return result;
      } else {
        throw Exception('"Request failed with status: ${response.statusCode}"');
      }
    } catch (e) {
      Future.error(e);
    }
  }

}
