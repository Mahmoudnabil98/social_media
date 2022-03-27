import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:social_media/intro/cubit/intro_cubit.dart';

// ignore: must_be_immutable
class IntroView extends StatelessWidget {
  static const String introView = '/Intro';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<IntroCubit>(
        create: (context) => IntroCubit(),
        child: BlocConsumer<IntroCubit, IntroState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                body: LiquidSwipe(
                  pages: IntroCubit.get(context).listFun(),
                  enableLoop: true,
                  fullTransitionValue: 600,
                  waveType: WaveType.liquidReveal,
                ),
              );
            }));
  }
}
