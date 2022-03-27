import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/widgets/custom_textfiled.dart';

class CommentView extends StatelessWidget {
  static String commentView = '/CommentView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            CommentTreeWidget<Comment, Comment>(
              Comment(
                  avatar: 'null',
                  userName: 'null',
                  content: 'felangel made felangel/cubit_and_beyond public '),
              [
                Comment(
                    avatar: 'null',
                    userName: 'null',
                    content: 'A Dart template generator which helps teams'),
                Comment(
                    avatar: 'null',
                    userName: 'null',
                    content:
                        'A Dart template generator which helps teams generator which helps teams generator which helps teams'),
                Comment(
                    avatar: 'null',
                    userName: 'null',
                    content: 'A Dart template generator which helps teams'),
                Comment(
                    avatar: 'null',
                    userName: 'null',
                    content:
                        'A Dart template generator which helps teams generator which helps teams '),
              ],
              treeThemeData:
                  TreeThemeData(lineColor: Colors.grey[500]!, lineWidth: 3),
              avatarRoot: (context, data) => const PreferredSize(
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey,
                ),
                preferredSize: Size.fromRadius(18),
              ),
              avatarChild: (context, data) => const PreferredSize(
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.grey,
                ),
                preferredSize: Size.fromRadius(12),
              ),
              contentChild: (context, data) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'dangngocduc',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            '${data.content}',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.grey[700], fontWeight: FontWeight.bold),
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8.w,
                            ),
                            const Text('Like'),
                            SizedBox(
                              width: 24.w,
                            ),
                            const Text('Reply'),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              contentRoot: (context, data) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'dangngocduc',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${data.content}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.grey[700], fontWeight: FontWeight.bold),
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8.w,
                            ),
                            const Text('Like'),
                            SizedBox(
                              width: 24.w,
                            ),
                            const Text('Reply'),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Expanded(
                child: Container(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 50.h,
                      child: CustomTextField(
                        keyboardType: TextInputType.text,
                        textfiledType: TextfiledType.normal,
                        title: 'Write a Comment ...',
                      ),
                    ))),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      ),
    );
  }
}
