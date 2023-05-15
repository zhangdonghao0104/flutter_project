import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zdh/config/string.dart';
import 'package:flutter_zdh/model/common_item.dart';
import 'package:flutter_zdh/state/base_list_state.dart';
import 'package:flutter_zdh/viewmodel/home_page_viewmodel.dart';
import 'package:flutter_zdh/widget/app_bar.dart';
import 'package:flutter_zdh/widget/home/banner_widget.dart';
import 'package:flutter_zdh/widget/list_item_widget.dart';
import 'package:flutter_zdh/widget/loading_state_widget.dart';
import 'package:flutter_zdh/widget/provider_widget.dart';

import '../http/http_manager.dart';

const TEXT_HEADER_TYPE = 'textHeader';
class HomeBodyPage extends StatefulWidget {
  @override
  _HomeBodyPageState createState() => _HomeBodyPageState();
}

class _HomeBodyPageState
    extends BaseListState<Item, HomePageViewModel, HomeBodyPage>  {


  _banner(model){

    return Container(
      height: 200,
      padding: EdgeInsets.only(left: 15,top: 15,right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: BannerWidget(model:model),
      ),
    );
  }

  @override
  Widget getContentChild(HomePageViewModel model) {

    // return _banner(model);
    return ListView.separated(
      itemCount: model.itemList.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _banner(model);
        } else {
          if (model.itemList[index].type == TEXT_HEADER_TYPE) {
            return _titleItem(model.itemList[index]);
          }
          return ListItemWidget(item: model.itemList[index]);
        }
      },
      // 分割线设置
      separatorBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          // Divider:分割线
          child: Divider(
            height: model.itemList[index].type == TEXT_HEADER_TYPE || index == 0
                ? 0
                : 0.5,
            color: model.itemList[index].type == TEXT_HEADER_TYPE || index == 0
                ? Colors.transparent
                : Color(0xffe6e6e6),
          ),
        );
      },
    );
  }


  _titleItem(Item item) {
    return Container(
      decoration: BoxDecoration(color: Colors.white24),
      padding: EdgeInsets.only(top: 15, bottom: 5),
      child: Center(
        child: Text(
          item.data.text,
          style: TextStyle(
            //  bold:粗体
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }


  @override
  HomePageViewModel get viewModel => HomePageViewModel();

}
