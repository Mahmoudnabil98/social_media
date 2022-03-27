import 'dart:developer';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/home/cubit/home_cubit.dart';
import 'package:social_media/home/cubit/home_state.dart';
import 'package:social_media/new_post/new_post_view.dart';
import 'package:social_media/routes/navigation_service.dart';
import 'package:social_media/widgets/custom_appbar.dart';

class HomeView extends StatelessWidget {
  static String homeView = '/HomeView';
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is HomeNewPostState) {
        log("message");
        NavigationService.navigationPushNamed(NewPostView.newPostView);
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: customAppBar(
            text: HomeCubit.get(context)
                .title[HomeCubit.get(context).currentIndex],
            context: context,
            action: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_rounded,
                  color: Colors.black,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.black,
                  )),
            ]),
        body: SingleChildScrollView(
          child:
              HomeCubit.get(context).views[HomeCubit.get(context).currentIndex],
        ),
        bottomNavigationBar: BottomNavyBar(
          showElevation: true,
          items: [
            BottomNavyBarItem(
                icon: const Icon(Icons.home),
                title: const Text('Home'),
                inactiveColor: Colors.grey.shade500,
                activeColor: Colors.blueAccent),
            BottomNavyBarItem(
                icon: const Icon(Icons.message),
                title: const Text('Chats'),
                inactiveColor: Colors.grey.shade500,
                activeColor: Colors.blueAccent),
            BottomNavyBarItem(
                icon: const Icon(Icons.upload_file_rounded),
                title: const Text('Post'),
                inactiveColor: Colors.grey.shade500,
                activeColor: Colors.blueAccent),
            BottomNavyBarItem(
                icon: const Icon(Icons.people),
                title: const Text('Users'),
                inactiveColor: Colors.grey.shade500,
                activeColor: Colors.blueAccent),
            BottomNavyBarItem(
                icon: const Icon(Icons.settings),
                title: const Text('Settings'),
                inactiveColor: Colors.grey.shade500,
                activeColor: Colors.blueAccent),
          ],
          selectedIndex: HomeCubit.get(context).currentIndex,
          onItemSelected: (index) {
            HomeCubit.get(context).changeBottomNav(index);
          },
        ),
      );
    });
  }
}



 // SafeArea(
            //   child: ConditionalBuilder(
            //     builder: (context) {
            //       return Column(
            //         children: [
            //           HomeCubit.get(context).userModel!.isEmailVerified ==
            //                   false
            //               ? Container(
            //                   color: Colors.amber.withOpacity(0.5),
            //                   height: 50.h,
            //                   child: Row(
            //                     children: [
            //                       const Expanded(
            //                           flex: 1,
            //                           child: Icon(Icons.info_outline)),
            //                       Expanded(
            //                           flex: 5,
            //                           child: Text(
            //                             'please verify your email',
            //                             style: heading6,
            //                           )),
            //                       Expanded(
            //                         child: CustomPrimaryButton(
            //                           onPressed: () {
            //                             FirebaseAuth.instance.currentUser!
            //                                 .sendEmailVerification()
            //                                 .then((value) {
            //                               CustomToast.showToast(
            //                                   title: 'Check Email!',
            //                                   customtoast: ToastType.success);
            //                             });
            //                           },
            //                           buttonColor: Colors.amber.withOpacity(0.5),
            //                           textValue: 'SEND',
            //                           textColor: Colors.blueAccent,
            //                           width: 20.w,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 )
            //               : Container(),
            //         ],
            //       );
            //     },
            //     condition: HomeCubit.get(context).userModel != null,
            //     fallback: (BuildContext context) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     },
            //   ),
            //),
