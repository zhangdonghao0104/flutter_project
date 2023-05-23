import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zdh/config/string.dart';
import 'package:flutter_zdh/utils/navigation_utils.dart';
import 'package:flutter_zdh/viewmodel/home/search_viewmodel.dart';
import 'package:flutter_zdh/widget/home/search_item_widget.dart';
import 'package:flutter_zdh/widget/loading_state_widget.dart';
import 'package:flutter_zdh/widget/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: ProviderWidget<SearchViewModel>(
            model: SearchViewModel(),
            onModelInit: (model) => model.getKeyWords(),
            builder: (context, model, child) {
              return Column(
                children: <Widget>[
                  _searchBar(model, context),
                  Expanded(
                    flex: 1,
                    child: Stack(
                      children: <Widget>[
                        // 热搜关键字提示
                        _keyWordWidget(model),
                        _searchVideoWidget(model),
                        _emptyWidget(model)
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _keyWordWidget(SearchViewModel model) {
    return Offstage(
      offstage: model.hideKeyWord,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Center(
              child: Text(
                StringUtils.hot_key_word,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            // Wrap：可以为子控件进行水平或者垂直方向布局，可以使子控件自动换行
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 6,
              runSpacing: 10,
              children: _keyWordWidgets(model),
            ),
          )
        ],
      ),
    );
  }

  Widget _searchVideoWidget(SearchViewModel model) {
    return Offstage(
      offstage: model.dataList == null || model.dataList.length == 0,
      child: LoadingStateWidget(
        viewState: model.viewState,
        retry: model.retry,
        child: Column(
            children: <Widget>[
        //搜做结果统计文本
        Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        child: Text(
          '— 「${model.query}」搜索结果共${model.total}个 —',
          style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.bold),
        ),
      ),
      //显示搜索结果
      Expanded(
        flex: 1,
        child: SmartRefresher(
            enablePullDown: false,
            enablePullUp: true,
            onLoading: model.loadMore,
            controller: model.refreshController,
            child: ListView.builder(
              itemCount: model.dataList.length,
              itemBuilder: (context, index) {
                return SearchItemWidget(item: model.dataList[index]);
              },
            ))
      )],
      ),
    ),);
  }
  /// 搜索内容为空时显示的 Widget
  Widget _emptyWidget(SearchViewModel model) {
    return Offstage(
      offstage: model.hideEmpty,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.sentiment_dissatisfied, size: 60, color: Colors.black54),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                StringUtils.no_data,
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // 热搜关键字
  List<Widget>  _keyWordWidgets(SearchViewModel model) {
    return model.keyWords.map((keyword) {
      return GestureDetector(
        onTap: () {
          // 隐藏键盘
          _hideTextInput();
          model.query = keyword;
          model.loadMore(loadMore: false);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
          decoration: BoxDecoration(
            color: Color(0x1A000000),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            keyword,
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
        ),
      );
    }).toList();
  }

  // 隐藏键盘
  _hideTextInput() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  Widget _searchBar(SearchViewModel model, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 16),
      child: Row(
        children: <Widget>[
          _arrowBack(),
          _inputBox(model),
        ],
      ),
    );
  }

  Widget _arrowBack() {
    return IconButton(
        onPressed: () => back(),
        icon: Icon(
          Icons.arrow_back,
          size: 20,
          color: Colors.black26,
        ));
  }

  Widget _inputBox(SearchViewModel model) {
    return Expanded(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 30),
        child: TextField(
          autofocus: true,
          onSubmitted: (value) {
            model.query = value;
            model.loadMore(loadMore: false);
          },
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 15),
              prefixIcon: Icon(
                Icons.search,
                size: 20,
                color: Colors.black26,
              ),
              fillColor: Color(0x0d000000),
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)),
              hintText: StringUtils.interest_video,
              hintStyle: TextStyle(fontSize: 13)),
        ),
      ),
    );
  }
}
