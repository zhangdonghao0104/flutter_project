
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zdh/utils/cache_image.dart';
import 'package:flutter_zdh/utils/navigation_utils.dart';
import 'package:flutter_zdh/viewmodel/discovery/category_detail_viewmodel.dart';
import 'package:flutter_zdh/widget/list_item_widget.dart';

import '../../model/common_item.dart';
import '../../model/discovery/category_model.dart';
import '../../state/base_list_state.dart';

class CategoryDetailPage extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryDetailPage({Key key, this.categoryModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState
    extends BaseListState<Item, CategoryDetailViewModel, CategoryDetailPage> {
  @override
  void init() {
    // 设置不能下拉刷新
    enablePullDown = false;
  }

  @override
  CategoryDetailViewModel get viewModel {
    return CategoryDetailViewModel(widget.categoryModel.id);
  }

  @override
  Widget getContentChild(CategoryDetailViewModel model) {
    return CustomScrollView(
      slivers: [
        _sliverAppBar(),
        _sliverList(model)
      ],
    );
  }

  /// 内容列表
  Widget _sliverList(model) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return ListItemWidget(
              item: model.itemList[index],
              showCategory: false,
              showDivider: false);
        },
        childCount: model.itemList.length,
      ),
    );
  }

  Widget _sliverAppBar() {
    return SliverAppBar(
      leading: GestureDetector(
        onTap: () => back(),
        child: Icon(Icons.arrow_back_ios, color: Colors.black),
      ),
      //阴影
      elevation: 0,
      //亮度
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      expandedHeight: 200.0,
      pinned: true,
      flexibleSpace: _flexibleSpace(),
    );
  }

  // 判断是否展开，从而改变字体颜色
  bool isExpend = true;

  Widget _flexibleSpace() {
    return LayoutBuilder(
      builder: (context, constraints) {
        changeExpendStatus(
          (MediaQuery.of(context).padding.top).toInt() + 56,
          constraints.biggest.height.toInt(),
        );
        return FlexibleSpaceBar(
          title: Text(
            widget.categoryModel.name,
            style: TextStyle(color: isExpend ? Colors.white : Colors.black),
          ),
          centerTitle: true,
          background: cacheImage(widget.categoryModel.headerImage),
        );
      },
    );
  }

  void changeExpendStatus(int statusBarHeight, int offset) {
    if (offset > statusBarHeight && offset < 250) {
      if (!isExpend) {
        isExpend = true;
      }
    } else {
      if (isExpend) {
        isExpend = false;
      }
    }
  }
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Colors.white,
//     body: ProviderWidget<CategoryDetailViewModel>(
//       model: CategoryDetailViewModel(widget.categoryModel.id),
//       onModelInit: (model) {
//         model.loadMore(loadMore: false);
//       },
//       builder: (context, model, child) {
//         return NestedScrollView(
//             headerSliverBuilder: (context, innerBoxIsScrolled) {
//               return [
//                 SliverAppBar(
//                   leading: GestureDetector(
//                     onTap: () => back(),
//                     child: Icon(
//                       Icons.arrow_back,
//                       color: Colors.black,
//                     ),
//                   ),
//                   elevation: 10,
//                   brightness: Brightness.light,
//                   backgroundColor: Colors.white,
//                   expandedHeight: 200.0,
//                   pinned: true,
//                   flexibleSpace: LayoutBuilder(
//                     builder: (context, constraints) {
//                       model.changeExpendStatusByOffset(
//                           (MediaQuery.of(context).padding.top).toInt() + 56,
//                           constraints.biggest.height.toInt());
//                       return FlexibleSpaceBar(
//                         title: Text(
//                           widget.categoryModel.name,
//                           style: TextStyle(
//                               color:
//                                   model.expend ? Colors.white : Colors.black),
//                         ),
//                         centerTitle: false,
//                         background:
//                             cacheImage(widget.categoryModel.headerImage),
//                       );
//                     },
//                   ),
//                 ),
//               ];
//             },
//             body: LoadingStateWidget(
//               viewState: model.viewState,
//               retry: model.retry,
//               child: SmartRefresher(
//                 enablePullDown: false,
//                 enablePullUp: true,
//                 onLoading: model.loadMore,
//                 controller: model.refreshController,
//                 child: ListView.builder(
//                   itemCount: model.itemList.length,
//                   itemBuilder: (context, index) {
//                     return ListItemWidget(
//                         item: model.itemList[index],
//                         showCategory: false,
//                         showDivider: false);
//                   },
//                 ),
//               ),
//             ));
//       },
//     ),
//   );
// }
}
