import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/home/cubit/home_cubit.dart';
import 'package:social_media/model/user_model.dart';
import 'package:social_media/widgets/custom_appbar.dart';
import 'package:social_media/widgets/custom_textfiled.dart';
import 'package:social_media/widgets/primary_button.dart';

import '../home/cubit/home_state.dart';

class EditProfileView extends StatelessWidget {
  static const String editProfileView = '/EditProfileView';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var imageFile = HomeCubit.get(context).profileImage;
          UserModel? userModel = HomeCubit.get(context).userModel;
          HomeCubit.get(context).bioController.text = userModel!.bio!;
          HomeCubit.get(context).nameController.text = userModel.name!;
          HomeCubit.get(context).phoneController.text = userModel.phone!;
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: customAppBar(
                text: 'Edit Profile',
                context: context,
                titleSpacing: 0.0,
                action: [
                  CustomPrimaryButton(
                    textValue: 'UPDATE',
                    width: 80.w,
                    buttonColor: Theme.of(context).backgroundColor,
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (HomeCubit.get(context)
                          .keyProfile
                          .currentState!
                          .validate()) {
                        log('validate');

                        HomeCubit.get(context).updateUser();
                      }
                    },
                  ),
                ]),
            body: SingleChildScrollView(
              child: Form(
                key: HomeCubit.get(context).keyProfile,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8),
                  child: Column(
                    children: [
                      if (state is UserUploadLoadingState)
                        const LinearProgressIndicator(),
                      SizedBox(
                        height: 5.h,
                      ),
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
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 180.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    image: HomeCubit.get(context).coverImage !=
                                            null
                                        ? FileImage(
                                            HomeCubit.get(context).coverImage!)
                                        : imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                radius: 20.h,
                                child: IconButton(
                                    onPressed: () {
                                      HomeCubit.get(context).coverImagePicker();
                                    },
                                    icon: Icon(
                                      Icons.camera_enhance,
                                      size: 20.h,
                                    )),
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  child: CircleAvatar(
                                    radius: 62.r,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                        radius: 60.r,
                                        backgroundImage: imageFile != null
                                            ? FileImage(imageFile)
                                            : CachedNetworkImageProvider(
                                                HomeCubit.get(context)
                                                    .userModel!
                                                    .image
                                                    .toString(),
                                              ) as ImageProvider),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 70.w),
                                  alignment: Alignment.bottomCenter,
                                  child: CircleAvatar(
                                    radius: 20.h,
                                    child: IconButton(
                                        onPressed: () {
                                          HomeCubit.get(context).imagePicker();
                                        },
                                        icon: Icon(
                                          Icons.camera_enhance,
                                          size: 20.h,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      if (HomeCubit.get(context).profileImage != null ||
                          HomeCubit.get(context).coverImage != null)
                        Row(
                          children: [
                            if (HomeCubit.get(context).coverImage != null)
                              Expanded(
                                  child: Column(
                                children: [
                                  CustomPrimaryButton(
                                    onPressed: () {
                                      HomeCubit.get(context)
                                          .uploadProfileCoverImage();
                                    },
                                    textValue: 'Update Cover Image',
                                    buttonColor: Theme.of(context).primaryColor,
                                    height: 50.h,
                                    textColor: Colors.white,
                                  ),
                                  if (state is UserUploadLoadingState)
                                    SizedBox(height: 5.h),
                                  if (state is UserUploadLoadingState)
                                    const LinearProgressIndicator()
                                ],
                              )),
                            SizedBox(
                              width: 5.w,
                            ),
                            if (HomeCubit.get(context).profileImage != null)
                              Expanded(
                                child: Column(
                                  children: [
                                    CustomPrimaryButton(
                                      onPressed: () {
                                        HomeCubit.get(context)
                                            .uploadProfileImage();
                                      },
                                      height: 50.h,
                                      textValue: 'Update Profile Image',
                                      buttonColor:
                                          Theme.of(context).primaryColor,
                                      textColor: Colors.white,
                                    ),
                                    if (state is UserUploadLoadingState)
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                    if (state is UserUploadLoadingState)
                                      const LinearProgressIndicator(),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      if (HomeCubit.get(context).profileImage != null ||
                          HomeCubit.get(context).coverImage != null)
                        SizedBox(
                          height: 20.h,
                        ),
                      CustomTextField(
                          prefixIcon: const Icon(Icons.account_circle_sharp),
                          controller: HomeCubit.get(context).nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Name must not is empty';
                            } else {
                              return null;
                            }
                          },
                          title: 'Name',
                          textfiledType: TextfiledType.normal),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                          controller: HomeCubit.get(context).phoneController,
                          prefixIcon: const Icon(
                            Icons.phone,
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Phone number must not is empty';
                            } else {
                              return null;
                            }
                          },
                          title: 'Phone',
                          textfiledType: TextfiledType.normal),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                          controller: HomeCubit.get(context).bioController,
                          prefixIcon: const Icon(
                            Icons.info,
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Bio must not is empty';
                            } else {
                              return null;
                            }
                          },
                          title: 'Bio',
                          textfiledType: TextfiledType.normal),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
