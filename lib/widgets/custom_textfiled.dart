import 'package:flutter/material.dart';
import 'package:social_media/login/cubit/login_cubit.dart';
import 'package:social_media/theme/theme.dart';

enum TextfiledType { password, normal }

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  TextfiledType? textfiledType = TextfiledType.normal;
  String? title;
  Function? onSaved;
  Function? onChanged;
  Function? validator;
  late FocusNode? focusNode;
  bool? obscureText = false;
  TextInputType? keyboardType = TextInputType.text;
  Function? changePasswordVisibility;
  IconData? icon;
  Widget? prefixIcon;
  TextEditingController? controller;
  CustomTextField(
      {Key? key,
      this.onChanged,
      this.icon,
      this.focusNode,
      this.obscureText,
      this.changePasswordVisibility,
      this.onSaved,
      @required this.keyboardType,
      @required this.validator,
      @required this.title,
      @required this.textfiledType,
      this.controller,
      this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return textfiledType == TextfiledType.normal
        ? Container(
            decoration: BoxDecoration(
              color: textWhiteGrey,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: TextFormField(
              focusNode: focusNode,
              autofocus: true,
              controller: controller,
              onSaved: (newValue) => onSaved!(newValue),
              validator: (value) => validator!(value),
              keyboardType: keyboardType,
              decoration: InputDecoration(
                prefixIcon: prefixIcon,
                hintText: title!,
                hintStyle: heading6.copyWith(color: textGrey),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: textWhiteGrey,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: TextFormField(
              autofocus: true,
              onSaved: (newValue) => onSaved!(newValue),
              validator: (value) => validator!(value),
              obscureText: obscureText!,
              onChanged: (newValue) => onChanged!(newValue),
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: heading6.copyWith(color: textGrey),
                suffixIcon: IconButton(
                  color: textGrey,
                  splashRadius: 1,
                  icon: Icon(
                    icon!,
                  ),
                  onPressed: () => changePasswordVisibility!(),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          );
  }
}
