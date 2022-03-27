import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/home/cubit/home_cubit.dart';
import 'package:social_media/home/cubit/home_state.dart';

import 'package:social_media/routes/navigation_service.dart';
import 'package:social_media/widgets/custom_text.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/primary_button.dart';

class NewPostView extends StatelessWidget {
  static const String newPostView = '/NewPostView';
  const NewPostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is CreatePostSuccessState) {
        NavigationService.navigationPop();
      }
    }, builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: customAppBar(text: 'Add Post', context: context, action: [
          CustomPrimaryButton(
            textValue: 'POST',
            width: 80.w,
            buttonColor: Theme.of(context).backgroundColor,
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              if (HomeCubit.get(context).keyPost.currentState!.validate()) {
                if (HomeCubit.get(context).postImage == null) {
                  HomeCubit.get(context).createPost(
                      text: HomeCubit.get(context).postController.text,
                      dateTime: DateTime.now().toString());
                } else {
                  HomeCubit.get(context).uploadPostImage(
                      text: HomeCubit.get(context).postController.text,
                      dateTime: DateTime.now().toString());
                }
              }
            },
          ),
        ]),
        body: Form(
          key: HomeCubit.get(context).keyPost,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Column(
              children: [
                if (state is CreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is CreatePostLoadingState)
                  SizedBox(
                    height: 5.h,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 27.r,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 25.r,
                        backgroundImage: CachedNetworkImageProvider(
                          HomeCubit.get(context).userModel!.image == null
                              ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxsIVGXUz77jSd-Zgau2ZqRpL_STVm4gbxWQ&usqp=CAU'
                              : HomeCubit.get(context)
                                  .userModel!
                                  .image
                                  .toString(),
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
                                text: HomeCubit.get(context).userModel!.name,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.blueAccent,
                                size: 16.h,
                              )
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: CustomText(
                              text: 'january 21,2022 at 10.00pm',
                              fontSize: 14,
                              textHeight: 1.4.h,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: HomeCubit.get(context).postController,
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter the text!';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'What on your mind ...',
                    ),
                  ),
                ),
                HomeCubit.get(context).postImage != null
                    ? Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 220.h,
                          child: Stack(children: [
                            Container(
                              height: 200.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    filterQuality: FilterQuality.high,
                                    image: FileImage(
                                      HomeCubit.get(context).postImage!,
                                    )),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.h),
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                radius: 20.h,
                                child: IconButton(
                                    onPressed: () {
                                      HomeCubit.get(context).removeImagePost();
                                    },
                                    icon: Icon(
                                      Icons.remove_circle_outline_rounded,
                                      size: 20.h,
                                    )),
                              ),
                            ),
                          ]),
                        ),
                      )
                    : const SizedBox(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            HomeCubit.get(context).postPicker();
                          },
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.image)),
                              SizedBox(
                                width: 5.w,
                              ),
                              CustomText(
                                text: 'ADD Photo',
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          )),
                      TextButton(
                          onPressed: () {
                            HomeCubit.get(context).postPicker();
                          },
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.tag_rounded)),
                              SizedBox(
                                width: 5.w,
                              ),
                              CustomText(
                                text: 'ADD TAG',
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
