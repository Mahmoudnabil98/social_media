import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/login/login_view.dart';
import 'package:social_media/model/intro_model.dart';
import 'package:social_media/routes/navigation_service.dart';

import '../../widgets/primary_button.dart';

part 'intro_state.dart';

class IntroCubit extends Cubit<IntroState> {
  IntroCubit() : super(IntroInitial());

  static IntroCubit get(context) => BlocProvider.of(context);

  List<IntroModel> list = [
    IntroModel(
        index: 0,
        dividerColor: Colors.blueGrey,
        dec: "Spinning in the opposite direction \n"
            "to most planets, Venus is the  \n"
            "hottest planet, and one of the"
            "and one of the \n"
            "brightest objects in the sky",
        image: "assets/images/social_life.svg",
        subTitle: "Venus",
        dscColor: Colors.blueGrey,
        subTitleColor: const Color(0xFFE8BB57),
        title: "Planet",
        backgroundColor: const Color(0xFF34210B),
        titleColor: const Color(0xFFA1B6CC)),
    IntroModel(
        index: 1,
        dividerColor: const Color(0xFFCC8E57),
        dec: "The place we call home, \nEarth is the third rock\n"
            "from the sun and the only planet\n"
            "with known life on it",
        image: "assets/images/mobile_posts.svg",
        subTitle: "Earth",
        dscColor: const Color(0xFFD4D4D2),
        subTitleColor: const Color(0xFF888C76),
        title: "Planet",
        backgroundColor: const Color(0xFF21323D),
        titleColor: const Color(0xFFA1B6CC)),
    IntroModel(
        index: 2,
        dividerColor: const Color(0xFFCC8E57),
        dec: "The red planet is dusty,\n"
            "cold world with a thin\n"
            "atmosphere and is home to four NASA robots",
        image: 'assets/images/social_networking.svg',
        subTitle: "Mars",
        dscColor: Colors.blueGrey,
        subTitleColor: const Color(0xFFCC8E57),
        title: "Planet",
        backgroundColor: const Color(0xFF2F1B0A),
        titleColor: const Color(0xFFA1B6CC)),
    IntroModel(
        index: 3,
        dividerColor: const Color(0xFF5183F7),
        dec: "Neptune is now the most\n "
            "distant planet and is a cold and\n dark world "
            "nearly 3 billion miles\n "
            "from the Sun.",
        image: "assets/images/organize.svg",
        subTitle: "Neptune",
        dscColor: Colors.blueGrey,
        subTitleColor: const Color.fromRGBO(81, 131, 247, 1),
        title: "Planet",
        backgroundColor: const Color(0xFF1A224D),
        titleColor: const Color(0xFFA1B6CC)),
  ];

  List<Widget> listFun() => list.map((e) {
        return Container(
          color: e.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: SvgPicture.asset(
                  e.image!,
                  width: 220.0.h,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      e.title!,
                      style: TextStyle(
                        fontSize: 30.0.sp,
                        color: e.titleColor,
                      ),
                    ),
                    Text(
                      e.subTitle!,
                      style: TextStyle(
                          fontSize: 50.0.sp,
                          color: e.subTitleColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.0.h),
                    Divider(color: e.dividerColor!),
                    Text(
                      e.dec!,
                      style: TextStyle(
                          color: e.dscColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 16.0.sp),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.bottomRight,
                child: e.index == 3
                    ? CustomPrimaryButton(
                        textValue: 'Lets Go',
                        onPressed: () {
                          NavigationService.navigationPushReplacementNamed(
                              LoginView.routeLogin);
                        },
                        width: 100.w,
                      )
                    : null,
              )
            ],
          ),
        );
      }).toList();
}
