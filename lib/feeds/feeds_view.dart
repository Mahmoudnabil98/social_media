import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/feeds/comment/comment_view.dart';
import 'package:social_media/home/cubit/home_cubit.dart';
import 'package:social_media/home/cubit/home_state.dart';
import 'package:social_media/model/post_model.dart';
import 'package:social_media/routes/navigation_service.dart';
import 'package:social_media/widgets/custom_text.dart';

class FeedsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      HomeCubit.get(context).getPost();
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return ConditionalBuilder(
                condition: HomeCubit.get(context).postList!.length > 0,
                builder: (BuildContext context) => Container(
                    margin: EdgeInsets.all(8.0.w),
                    child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buildPostItem(context,
                            HomeCubit.get(context).postList![index], index),
                        separatorBuilder: (cotext, index) => SizedBox(
                              height: 5.h,
                            ),
                        itemCount: HomeCubit.get(context).postList!.length)),
                fallback: (BuildContext context) =>
                    const LinearProgressIndicator(),
              );
            }),
      );
    });
  }

  Widget buildPostItem(
    BuildContext context,
    PostModel postModel,
    int index,
  ) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundImage: CachedNetworkImageProvider(
                      postModel.image.toString(),
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
                            text: postModel.name.toString(),
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          HomeCubit.get(context).userModel!.isEmailVerified ==
                                  false
                              ? const SizedBox()
                              : Icon(
                                  Icons.check_circle,
                                  color: Colors.blueAccent,
                                  size: 16.h,
                                )
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CustomText(
                          text: postModel.dateTime.toString().padLeft(2, '0'),
                          fontSize: 12.sp,
                          textHeight: 1.4.h,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/images/svg/menu.svg',
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              width: double.infinity,
              child: CustomText(
                text: postModel.text,
                textHeight: 1.3.h,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                children: [
                  InkWell(
                    child: CustomText(
                        text: '#Software',
                        fontSize: 14.sp,
                        color: Colors.blueAccent),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  InkWell(
                    child: CustomText(
                        text: '#Software',
                        fontSize: 14.sp,
                        color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            postModel.postImage != ''
                ? Container(
                    height: 200.h,
                    width: double.infinity.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            postModel.postImage.toString(),
                          ),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomText(
                        alignment: Alignment.bottomRight,
                        text: 'Good',
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: 20.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          HomeCubit.get(context)
                              .likePost(HomeCubit.get(context).postId[index]);
                        },
                        child: SvgPicture.asset(
                          'assets/images/svg/fav.svg',
                          color: Colors.redAccent,
                        ),
                      ),
                      CustomText(
                        text: "${HomeCubit.get(context).likes[index]}",
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                      InkWell(
                        onTap: () {},
                        child:
                            SvgPicture.asset('assets/images/svg/comment.svg'),
                      ),
                      CustomText(
                        text: '60',
                      ),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset('assets/images/svg/share.svg'),
                      ),
                      CustomText(
                        text: '5',
                      ),
                    ],
                  )),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/images/svg/tag.svg',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              color: Colors.grey.shade500,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(children: [
                Expanded(
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 18.r,
                      backgroundImage: CachedNetworkImageProvider(
                        HomeCubit.get(context).userModel!.image.toString(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap: () {
                      NavigationService.navigationPushNamed(
                          CommentView.commentView);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      alignment: Alignment.centerLeft,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15)),
                      child: CustomText(
                        text: 'write a comment ...',
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}
