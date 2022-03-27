import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/edit_profile.dart/edit_profile_view.dart';
import 'package:social_media/home/cubit/home_cubit.dart';
import 'package:social_media/home/cubit/home_state.dart';
import 'package:social_media/routes/navigation_service.dart';

import 'package:social_media/widgets/custom_text.dart';
import 'package:social_media/widgets/primary_button.dart';

// ignore: must_be_immutable
class SettingsView extends StatelessWidget {
  String? title;
  SettingsView({this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
          fallback: (context) => const Center(
                child: LinearProgressIndicator(),
              ),
          condition: HomeCubit.get(context).userModel != null,
          builder: (context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 220.h,
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.fitWidth,
                          imageUrl: HomeCubit.get(context)
                              .userModel!
                              .coverImage
                              .toString(),
                          imageBuilder: (context, imageProvider) => Container(
                            height: 180.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5),
                              ),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                            radius: 62.r,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 60.r,
                              backgroundImage: CachedNetworkImageProvider(
                                  HomeCubit.get(context)
                                      .userModel!
                                      .image
                                      .toString()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  CustomText(
                    textHeight: 1.4.h,
                    text: HomeCubit.get(context).userModel!.name.toString(),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    textHeight: 1.8.h,
                    text: HomeCubit.get(context).userModel!.bio.toString(),
                    fontSize: 16,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              CustomText(
                                textHeight: 1.4.h,
                                text: '100',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                textHeight: 1.8.h,
                                text: 'Post',
                                fontSize: 16,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              CustomText(
                                textHeight: 1.4.h,
                                text: '512',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                textHeight: 1.8.h,
                                text: 'Photos',
                                fontSize: 16,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              CustomText(
                                textHeight: 1.4.h,
                                text: '10K',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                textHeight: 1.8.h,
                                text: 'Followrs',
                                fontSize: 16,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              CustomText(
                                textHeight: 1.4.h,
                                text: '94',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                textHeight: 1.8.h,
                                text: 'Followings',
                                fontSize: 16,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              )),
                          child: CustomPrimaryButton(
                            onPressed: () {},
                            buttonColor: Colors.white,
                            textValue: 'Add Photo',
                            textColor: Theme.of(context).primaryColor,
                            height: 50.h,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor)),
                          child: IconButton(
                            icon: const Icon(
                              Icons.mode_edit_outline,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () {
                              NavigationService.navigationPushNamed(
                                  EditProfileView.editProfileView);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
