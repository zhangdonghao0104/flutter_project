
import 'package:flutter/material.dart';
import 'package:flutter_zdh/config/string.dart';
import 'package:flutter_zdh/model/common_item.dart';
import 'package:flutter_zdh/utils/cache_image.dart';
import 'package:flutter_zdh/utils/navigation_utils.dart';

import '../../utils/date_util.dart';

class FollowItemWidget extends StatelessWidget {
  final Item item;

  const FollowItemWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[_videoAuthor(), _product()],
      ),
    );
  }

  Container _product() {
    return Container(
      height: 230,
      child: ListView.builder(
        itemCount: item.data.itemList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // 单个视频介绍
          return _inkWell(
            item: item.data.itemList[index],
            last: index == item.data.itemList.length - 1,
          );
        },
      ),
    );
  }

  //单个视频介绍
  Widget _inkWell({Item item, bool last}) {
    return InkWell(
      onTap: () => toNamed('/detail', item.data),
      child: Container(
        padding: EdgeInsets.only(left: 15, right: last ? 15 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //视频图片
            _videoImage(item),
            _videoName(item),
            _videoTime(item),
          ],
        ),
      ),
    );
  }

  /// 视频上线时间
  Widget _videoTime(item) {
    return Container(
      child: Text(
        formatDateMsByYMDHM(item.data.author.latestReleaseTime),
        style: TextStyle(fontSize: 12, color: Colors.black26),
      ),
    );
  }

  /// 视频名称
  Widget _videoName(item) {
    return Container(
      width: 300,
      padding: EdgeInsets.only(top: 3, bottom: 3),
      child: Text(item.data.title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
    );
  }

  Widget _videoImage(Item item) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Hero(
            tag: '${item.data.id}${item.data.time}',
            child: cacheImage(item.data.cover.feed, width: 300, height: 180),
          ),
        ),
        //类型小图标
        Positioned(
          right: 8,
          top: 8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(color: Colors.white54),
              alignment: AlignmentDirectional.center,
              child: Text(
                item.data.category,
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _videoAuthor() {
    return Container(
      //设置四个方向的间距
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(
        children: <Widget>[
          //剪切椭圆
          ClipOval(
            child: cacheImage(item.data.header.icon, width: 49, height: 49),
          ),
          Expanded(
            flex: 1,
            child: Container(
              //设置左右边距
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                //交叉对其设置
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.data.header.title,
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      item.data.header.description,
                      style: TextStyle(color: Colors.black26, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //右侧关注按钮
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(color: Color(0xfff4f4f4)),
              child: Text(
                StringUtils.add_follow,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
