import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zdh/config/string.dart';
import 'package:flutter_zdh/viewmodel/home_page_viewmodel.dart';
import 'package:flutter_zdh/widget/app_bar.dart';
import 'package:flutter_zdh/widget/home/banner_widget.dart';
import 'package:flutter_zdh/widget/loading_state_widget.dart';
import 'package:flutter_zdh/widget/provider_widget.dart';

import '../http/http_manager.dart';

class HomeBodyPage extends StatefulWidget {
  @override
  _HomeBodyPageState createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends State<HomeBodyPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ProviderWidget<HomePageViewModel>(

        model: HomePageViewModel(),
        onModelInit: (model) =>model.refresh(),
        builder: (context, model, child) {
          return LoadingStateWidget(
            viewState: model.viewState,
            child:
            _banner(model),
          );
        });
  }

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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
