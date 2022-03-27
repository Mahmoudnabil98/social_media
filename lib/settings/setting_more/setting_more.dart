import 'package:flutter/material.dart';
import 'package:social_media/widgets/custom_text.dart';

class SettingMoreView extends StatelessWidget {
  const SettingMoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'More settings'),
      ),
      body: Container(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
