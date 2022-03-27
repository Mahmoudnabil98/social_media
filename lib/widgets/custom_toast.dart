import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media/theme/theme.dart';

enum ToastType { error, success }

class CustomToast {
  static Future<void> showToast(
      {@required String? title, @required ToastType? customtoast}) async {
    if (customtoast == ToastType.error) {
      Fluttertoast.showToast(
          msg: title!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
    } else if (customtoast == ToastType.success) {
      Fluttertoast.showToast(
          msg: title!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: primaryBlue,
          textColor: Colors.white);
    }
  }
}
