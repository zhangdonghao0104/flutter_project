import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zdh/model/discovery/recommend_model.dart';
import 'package:flutter_zdh/page/discovery/recommend_photo_page.dart';
import 'package:flutter_zdh/utils/ToastUtils.dart';
import 'package:flutter_zdh/utils/cache_image.dart';
import 'package:flutter_zdh/utils/navigation_utils.dart';

import '../../page/discovery/recommend_video_page.dart';

const VIDEO_TYPE = 'video';

class RecommendItemWidget extends StatelessWidget {
  final RecommendItem item;

  const RecommendItemWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.data.content.type == VIDEO_TYPE) {
          // ToastUtils.showTip("跳转视频页面");
          toPage(RecommendVideoPage(item: item));
        } else {
          ToastUtils.showTip("跳转图片页面");
          toPage(RecommendPhotoPage(
            galleryItems: item.data.content.data.urls,
          ));
        }
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[_imageItem(context), _contentTextItem(),_authInfoTextItem()],
        ),
      ),
    );
  }

  //作者头像 信息
  _authInfoTextItem() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: cacheImage(
                  item.data.content.data.owner.avatar,
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: 80,
                child: Text(
                  item.data.content.data.owner.nickname,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  '${item.data.content.data.consumption.collectionCount}',
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          //作者头像
        ],
      ),
    );
  }

  _contentTextItem() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(
        item.data.content.data.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  _imageItem(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    // 安全处理，宽高实际都是有值的
    var width = item.data.content.data.width == 0
        ? maxWidth
        : item.data.content.data.width;
    var height = item.data.content.data.height == 0
        ? maxWidth
        : item.data.content.data.height;

    Widget image = Stack(
      children: <Widget>[
        cacheImage(
          item.data.content.data.cover.feed,
          shape: BoxShape.rectangle,
          width: maxWidth,
          fit: BoxFit.cover,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
          clearMemoryCacheWhenDispose: true, //图片从 tree 中移除，清掉内存缓存，以减少内存压力
        ),
        Positioned(
          top: 5,
          right: 5,
          // Offstage：控制是否显示组件，false 显示
          child: Offstage(
            // offstage 为 false 显示--如果是图片且只有一张，则不显示该图标
            offstage: item.data.content.data.urls != null &&
                item.data.content.data.urls.length == 1,
            child: Icon(
              item.data.content.type == VIDEO_TYPE
                  ? Icons.play_circle_outline
                  : Icons.photo_library,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ],
    );
    //AspectRatio：约束控件的宽高比，保证控件等比缩放
    return AspectRatio(
      aspectRatio: width / height,
      child: image,
    );
  }
}
