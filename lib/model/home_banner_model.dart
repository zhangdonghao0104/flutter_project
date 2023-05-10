/// data : [{"desc":"我们支持订阅啦~","id":30,"imagePath":"https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png","isVisible":1,"order":2,"title":"我们支持订阅啦~","type":0,"url":"https://www.wanandroid.com/blog/show/3352"},{"desc":"","id":6,"imagePath":"https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png","isVisible":1,"order":1,"title":"我们新增了一个常用导航Tab~","type":1,"url":" https://www.wanandroid.com/navi"},{"desc":"一起来做个App吧","id":10,"imagePath":"https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png","isVisible":1,"order":1,"title":" 一起来做个App吧","type":1,"url":"https://www.wanandroid.com/blog/show/2"}]
/// errorCode : 0
/// errorMsg : ""

class HomeBannerModel {
  HomeBannerModel({
    List<Data> data,
    num errorCode,
    String errorMsg,
  }) {
    _data = data;
    _errorCode = errorCode;
    _errorMsg = errorMsg;
  }

  HomeBannerModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
    _errorCode = json['errorCode'];
    _errorMsg = json['errorMsg'];
  }

  List<Data> _data;
  num _errorCode;
  String _errorMsg;

  HomeBannerModel copyWith({
    List<Data> data,
    num errorCode,
    String errorMsg,
  }) =>
      HomeBannerModel(
        data: data,
        errorCode: errorCode,
        errorMsg: errorMsg,
      );

  List<Data> get data => _data;

  num get errorCode => _errorCode;

  String get errorMsg => _errorMsg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data.map((v) => v.toJson()).toList();
    }
    map['errorCode'] = _errorCode;
    map['errorMsg'] = _errorMsg;
    return map;
  }
}

/// desc : "我们支持订阅啦~"
/// id : 30
/// imagePath : "https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png"
/// isVisible : 1
/// order : 2
/// title : "我们支持订阅啦~"
/// type : 0
/// url : "https://www.wanandroid.com/blog/show/3352"

class Data {
  Data({
    String desc,
    num id,
    String imagePath,
    num isVisible,
    num order,
    String title,
    num type,
    String url,
  }) {
    _desc = desc;
    _id = id;
    _imagePath = imagePath;
    _isVisible = isVisible;
    _order = order;
    _title = title;
    _type = type;
    _url = url;
  }

  Data.fromJson(dynamic json) {
    _desc = json['desc'];
    _id = json['id'];
    _imagePath = json['imagePath'];
    _isVisible = json['isVisible'];
    _order = json['order'];
    _title = json['title'];
    _type = json['type'];
    _url = json['url'];
  }

  String _desc;
  num _id;
  String _imagePath;
  num _isVisible;
  num _order;
  String _title;
  num _type;
  String _url;

  Data copyWith({
    String desc,
    num id,
    String imagePath,
    num isVisible,
    num order,
    String title,
    num type,
    String url,
  }) =>
      Data(
        desc: desc,
        id: id,
        imagePath: imagePath,
        isVisible: isVisible,
        order: order,
        title: title,
        type: type,
        url: url,
      );

  String get desc => _desc;

  num get id => _id;

  String get imagePath => _imagePath;

  num get isVisible => _isVisible;

  num get order => _order;

  String get title => _title;

  num get type => _type;

  String get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['desc'] = _desc;
    map['id'] = _id;
    map['imagePath'] = _imagePath;
    map['isVisible'] = _isVisible;
    map['order'] = _order;
    map['title'] = _title;
    map['type'] = _type;
    map['url'] = _url;
    return map;
  }
}
