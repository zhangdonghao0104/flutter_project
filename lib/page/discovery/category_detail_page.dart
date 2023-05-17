

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zdh/utils/cache_image.dart';
import 'package:flutter_zdh/utils/navigation_utils.dart';
import 'package:flutter_zdh/viewmodel/discovery/category_detail_viewmodel.dart';
import 'package:flutter_zdh/viewmodel/discovery/category_viewmodel.dart';
import 'package:flutter_zdh/widget/list_item_widget.dart';
import 'package:flutter_zdh/widget/loading_state_widget.dart';
import 'package:flutter_zdh/widget/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../model/discovery/category_model.dart';

class CategoryDetailPage extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryDetailPage({Key key, this.categoryModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProviderWidget<CategoryDetailViewModel>(
        model: CategoryDetailViewModel(widget.categoryModel.id),
        onModelInit: (model) {
          model.loadMore(loadMore: false);
        },
        builder: (context, model, child) {
          return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    leading: GestureDetector(
                      onTap: () => back(),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    elevation: 10,
                    brightness: Brightness.light,
                    backgroundColor: Colors.white,
                    expandedHeight: 200.0,
                    pinned: true,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        model.changeExpendStatusByOffset(
                            (MediaQuery.of(context).padding.top).toInt() + 56,
                            constraints.biggest.height.toInt());
                        return FlexibleSpaceBar(
                          title: Text(
                            widget.categoryModel.name,
                            style: TextStyle(
                                color:
                                    model.expend ? Colors.white : Colors.black),
                          ),
                          centerTitle: false,
                          background:
                              cacheImage(widget.categoryModel.headerImage),
                        );
                      },
                    ),
                  ),
                ];
              },
              body: LoadingStateWidget(
                viewState: model.viewState,
                retry: model.retry,
                child: SmartRefresher(
                  enablePullDown: false,
                  enablePullUp: true,
                  onLoading: model.loadMore,
                  controller: model.refreshController,
                  child: ListView.builder(
                    itemCount: model.itemList.length,
                    itemBuilder: (context, index) {
                      return ListItemWidget(
                          item: model.itemList[index],
                          showCategory: false,
                          showDivider: false);
                    },
                  ),
                ),
              ));
        },
      ),
    );
  }
}
