import 'package:flutter/material.dart';
import 'package:flutter_zdh/config/string.dart';
import 'package:readmore/readmore.dart';

enum TrimTypeMode {
  Length,
  Line,
}

class ExpandMoreTextWidget extends StatelessWidget {
  final String text;
  final String trimCollapsedText;
  final String trimExpandedText;
  final TextStyle style;
  final TextStyle moreStyle;
  final TextStyle lessStyle;
  final int trimLines;
  final TrimTypeMode trimMode;

  const ExpandMoreTextWidget(this.text,
      {Key key,
        this.trimCollapsedText = StringUtils.more_text,
        this.trimExpandedText = StringUtils.less_text,
        this.style,
        this.moreStyle,
        this.lessStyle,
        this.trimLines = 2,
        this.trimMode = TrimTypeMode.Line})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      // 显示的文本内容
      text,
      // 折叠时显示的文本行数
      trimLines: trimLines,
      // 折叠的模式：TrimMode.Line：按行数折叠；TrimMode.Length：按字母数折叠
      trimMode: trimMode == TrimTypeMode.Line ? TrimMode.Line : TrimMode.Length,
      // 折叠时显示的提示文本：'更多'
      trimCollapsedText: trimCollapsedText,
      // 展开后显示的提示文本:'收起'
      trimExpandedText: trimExpandedText,
      // 显示的文本的类型
      style: style,
      // 折叠时显示的提示文本的类型
      moreStyle: moreStyle,
      // 展开时显示的提示文本的类型
      lessStyle: lessStyle,
    );
  }
}