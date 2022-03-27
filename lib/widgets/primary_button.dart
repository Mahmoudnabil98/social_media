import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/theme/theme.dart';

class CustomPrimaryButton extends StatelessWidget {
  final Color? buttonColor;
  final String? textValue;
  final Color? textColor;
  final Function? onPressed;
  double? width;
  double? height;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  CustomPrimaryButton(
      {this.buttonColor,
      @required this.textValue,
      this.textColor,
      @required this.width,
      this.height,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14.0),
      elevation: 0,
      child: Container(
        width: width,
        height: height ?? 50.h,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onPressed!(),
            borderRadius: BorderRadius.circular(14.0),
            child: Center(
              child: Text(
                textValue!,
                style: heading6.copyWith(color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
