import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/chats_details/chats_details.dart';
import 'package:social_media/home/cubit/home_cubit.dart';
import 'package:social_media/home/cubit/home_state.dart';
import 'package:social_media/model/user_model.dart';
import 'package:social_media/widgets/custom_text.dart';

class ChatsView extends StatelessWidget {
  String? title;
  ChatsView({this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: HomeCubit.get(context).users.length > 0,
            fallback: (context) => const LinearProgressIndicator(),
            builder: (context) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => chatItem(
                          context, HomeCubit.get(context).users[index]),
                      separatorBuilder: (context, index) => Divider(
                            color: Colors.grey[500],
                          ),
                      itemCount: HomeCubit.get(context).users.length));
            },
          );
        });
  }

  Widget chatItem(BuildContext context, UserModel userModel) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatsDetalisView(userModel: userModel)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                radius: 20.r,
                backgroundImage: CachedNetworkImageProvider(
                  userModel.image.toString(),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        textHeight: 1.4.h,
                        text: userModel.name.toString(),
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      userModel.isEmailVerified == true
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.blueAccent,
                              size: 16.h,
                            )
                          : SizedBox()
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomText(
                      text: DateTime.now().toString(),
                      fontSize: 12.sp,
                      textHeight: 1.4.h,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
