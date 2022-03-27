import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  String? text;
  TextAlign? textAlign;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  Alignment? alignment;
  TextOverflow? textOverflow;
  int? maxLines;
  bool? softWrap = false;
  double? textHeight;

  CustomText({
    Key? key,
    this.text = " ",
    this.alignment,
    this.color,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.textAlign,
    this.maxLines,
    this.textHeight,
    this.textOverflow,
    this.softWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text!,
        softWrap: softWrap,
        maxLines: maxLines,
        textAlign: textAlign,
        style: TextStyle(
          overflow: textOverflow,
          height: textHeight,
          color: color ?? Colors.black,
          fontFamily: Theme.of(context).textTheme.toString(),
          fontSize: fontSize?.sp,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
