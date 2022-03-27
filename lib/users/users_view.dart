import 'package:flutter/material.dart';

class UsersView extends StatelessWidget {
  String? title;
  UsersView({this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('$title');
  }
}
