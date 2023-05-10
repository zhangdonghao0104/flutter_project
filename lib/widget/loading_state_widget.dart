import 'package:flutter/material.dart';
import 'package:flutter_zdh/config/color.dart';
import 'package:flutter_zdh/config/string.dart';

//页面状态
enum ViewState { loading, done, error }

class LoadingStateWidget extends StatelessWidget {
  final ViewState viewState;
  final VoidCallback retry;
  final Widget child;

  LoadingStateWidget(
      {Key key, this.viewState = ViewState.loading, this.retry, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (viewState == ViewState.loading) {
      return _loadView;
    } else if (viewState == ViewState.error) {
      return _errorView;
    } else {
      return child;
    }
  }

  Widget get _loadView {
    return Center(child: CircularProgressIndicator());
  }

  Widget get _errorView {
    return Center(
      //linearlayout
      child: Column(
        //垂直
        //居中
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/ic_error.png',
            width: 100,
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              StringUtils.net_request_fail,
              style: TextStyle(color: ColorUtils.hitTextColor, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: OutlinedButton(
              onPressed: retry,
              child: Text(
                StringUtils.reload_again,
                style: TextStyle(color: Colors.black87),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.black12)),
            ),
          )
        ],
      ),
    );
  }
}
