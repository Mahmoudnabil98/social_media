import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/theme/theme.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class CustomCheckbox extends StatefulWidget {
  String? text;
  CustomCheckbox({Key? key, this.text}) : super(key: key);
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isChecked = !isChecked;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isChecked ? primaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(4.0),
                  border: isChecked
                      ? null
                      : Border.all(color: textGrey, width: 1.5),
                ),
                width: 20,
                height: 20,
                child: isChecked
                    ? const Icon(
                        Icons.check,
                        size: 20,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              widget.text!,
              style: regular16pt,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ],
    );
  }
}
