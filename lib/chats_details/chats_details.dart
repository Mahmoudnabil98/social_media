import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/home/cubit/home_cubit.dart';
import 'package:social_media/home/cubit/home_state.dart';
import 'package:social_media/model/message_model.dart';
import 'package:social_media/model/user_model.dart';
import 'package:social_media/widgets/custom_text.dart';
import 'package:social_media/widgets/custom_textfiled.dart';
import 'package:social_media/widgets/primary_button.dart';

class ChatsDetalisView extends StatelessWidget {
  static const chatsDetalisView = '/ChatsDetalisView';
  UserModel? userModel;
  ChatsDetalisView({Key? key, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      HomeCubit.get(context).getmessages(receiverId: userModel!.uid);
      return BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ConditionalBuilder(
                condition: HomeCubit.get(context).messages.length > 0,
                fallback: (context) => const LinearProgressIndicator(),
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                        titleSpacing: 0.0,
                        title: Row(children: [
                          CircleAvatar(
                            radius: 22.r,
                            backgroundColor: Colors.grey,
                            child: CircleAvatar(
                              radius: 20.r,
                              backgroundImage: CachedNetworkImageProvider(
                                userModel!.image.toString(),
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
                                      text: userModel!.name.toString(),
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    userModel!.isEmailVerified == true
                                        ? Icon(
                                            Icons.check_circle,
                                            color: Colors.blueAccent,
                                            size: 16.h,
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ])),
                    body: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.h,
                      ),
                      child: Column(
                        children: [
                          if (state is UploadChatsImageLoadingState)
                            const LinearProgressIndicator(),
                          Expanded(
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    HomeCubit.get(context).messages.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 20.h),
                                itemBuilder: (context, index) {
                                  var message =
                                      HomeCubit.get(context).messages[index];
                                  if (HomeCubit.get(context).userModel!.uid ==
                                      message.senderId) {
                                    return buildMyMessage(context, message);
                                  } else {
                                    return buildMessage(context, message);
                                  }
                                }),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                    prefixIcon: IconButton(
                                        icon: Icon(
                                          Icons.image,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          HomeCubit.get(context).chatPicker();
                                        }),
                                    controller: HomeCubit.get(context)
                                        .messageController,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {},
                                    title: 'Type your message here ...',
                                    textfiledType: TextfiledType.normal),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              CustomPrimaryButton(
                                  buttonColor: Theme.of(context).primaryColor,
                                  textValue: 'Send',
                                  textColor: Colors.white,
                                  width: 100.w,
                                  onPressed: () {
                                    HomeCubit.get(context).uploadChatImage(
                                      text: HomeCubit.get(context)
                                          .messageController
                                          .text,
                                      receiverId: userModel!.uid,
                                      dateTime: DateTime.now().toString(),
                                    );
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          });
    });
  }

  Widget buildMessage(BuildContext context, MessageModel messageModel) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(10.r),
                    topStart: Radius.circular(10.r),
                    bottomEnd: Radius.circular(10.r),
                  )),
              child: CustomText(
                text: messageModel.text,
                color: Colors.black,
              )),
          if (messageModel.image.toString() != '')
            SizedBox(
              height: 10.h,
            ),
          if (messageModel.image.toString() != '')
            CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: messageModel.image.toString(),
              imageBuilder: (context, imageProvider) => Container(
                height: 180.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  ),
                  image: DecorationImage(
                    image: HomeCubit.get(context).coverImage != null
                        ? FileImage(HomeCubit.get(context).coverImage!)
                        : imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
        ],
      ),
    );
  }

  Widget buildMyMessage(BuildContext context, MessageModel messageModel) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10.r),
                    topEnd: Radius.circular(10.r),
                    topStart: Radius.circular(10.r),
                  )),
              child: CustomText(
                text: messageModel.text,
                color: Colors.white,
              )),
          if (messageModel.image.toString() != '')
            SizedBox(
              height: 5.h,
            ),
          if (messageModel.image.toString() != '')
            CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: messageModel.image.toString(),
              imageBuilder: (context, imageProvider) => Container(
                height: 180.h,
                width: 200.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  image: DecorationImage(
                    image: HomeCubit.get(context).coverImage != null
                        ? FileImage(HomeCubit.get(context).coverImage!)
                        : imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
        ],
      ),
    );
  }
}
