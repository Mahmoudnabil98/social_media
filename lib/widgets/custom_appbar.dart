import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/widgets/custom_text.dart';

PreferredSizeWidget customAppBar(
    {required String? text,
    required BuildContext? context,
    double? titleSpacing,
    List<Widget>? action}) {
  return AppBar(
      titleSpacing: titleSpacing,
      title: CustomText(
        text: text.toString(),
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
      actions: action);
}
