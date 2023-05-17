import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zdh/model/discovery/topic_model.dart';
import 'package:flutter_zdh/state/base_list_state.dart';
import 'package:flutter_zdh/utils/cache_image.dart';
import 'package:flutter_zdh/viewmodel/discovery/TopicPageViewModel.dart';

class TopicPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TopicPageState();
}

class _TopicPageState
    extends BaseListState<TopicItemModel, TopicPageViewModel, TopicPage> {
  @override
  Widget getContentChild(TopicPageViewModel model) => ListView.separated(
        itemCount: model.itemList.length,
        itemBuilder: (context, index) {
          return OpenContainer(
              closedBuilder: (context, action) {
                return _closedWidget(model.itemList[index]);
              },
            openBuilder: (context, action) {
              return Container(color: Colors.blue);
            },
          );
        },
    separatorBuilder: (context, index) {
    return Divider(
      height: 0.5,
    );
  },
      );

  @override
  // TODO: implement viewModel
  TopicPageViewModel get viewModel => TopicPageViewModel();

  Widget _closedWidget(item) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        child: cacheImage(
          item.data.image,
          width: MediaQuery.of(context).size.width,
          height: 200
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
