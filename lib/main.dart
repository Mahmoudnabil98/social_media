import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/chats_details/chats_details.dart';
import 'package:social_media/edit_profile.dart/edit_profile_view.dart';
import 'package:social_media/feeds/comment/comment_view.dart';
import 'package:social_media/home/cubit/home_cubit.dart';
import 'package:social_media/home/home_view.dart';
import 'package:social_media/intro/intro_view.dart';
import 'package:social_media/login/login_view.dart';
import 'package:social_media/new_post/new_post_view.dart';
import 'package:social_media/routes/navigation_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/register/register_view.dart';
import 'package:social_media/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? uId = sharedPreferences.getString('uid');
  runApp(MyApp(
    uid: uId,
  ));
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  String? uid;
  MyApp({Key? key, this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => HomeCubit()
                ..getUser()
                ..getPost()),
        ],
        child: ScreenUtilInit(
            designSize: const Size(375, 864),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: () => MaterialApp(
                initialRoute:
                    uid != null ? HomeView.homeView : IntroView.introView,
                routes: {
                  IntroView.introView: (context) => IntroView(),
                  RegisterView.routeRegister: (context) => RegisterView(),
                  LoginView.routeLogin: (context) => LoginView(),
                  HomeView.homeView: (context) => const HomeView(),
                  NewPostView.newPostView: (context) => const NewPostView(),
                  EditProfileView.editProfileView: (context) =>
                      EditProfileView(),
                  CommentView.commentView: (context) => CommentView(),
                  ChatsDetalisView.chatsDetalisView: (context) =>
                      ChatsDetalisView(),
                },
                navigatorKey: NavigationService.navigatorKey,
                theme: lightTheme,
                debugShowCheckedModeBanner: false,
                onUnknownRoute: (RouteSettings settings) {
                  return MaterialPageRoute<void>(
                    settings: settings,
                    builder: (BuildContext context) =>
                        const Scaffold(body: Center(child: Text('Not Found'))),
                  );
                },
                home: uid != null ? const HomeView() : IntroView()

                // LoginView(),
                )));
  }
}
