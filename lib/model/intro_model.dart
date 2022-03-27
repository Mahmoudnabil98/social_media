import 'package:flutter/material.dart';

class IntroModel {
  String? image, title, subTitle, dec;
  int? index;
  Color? backgroundColor, dividerColor, titleColor, subTitleColor, dscColor;

  IntroModel(
      {@required this.index,
      @required this.backgroundColor,
      @required this.dec,
      @required this.dividerColor,
      @required this.dscColor,
      @required this.image,
      @required this.subTitle,
      @required this.titleColor,
      @required this.subTitleColor,
      @required this.title});
}
