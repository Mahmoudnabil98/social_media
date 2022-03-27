import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/home/home_view.dart';
import 'package:social_media/login/cubit/login_cubit.dart';
import 'package:social_media/login/cubit/login_state.dart';
import 'package:social_media/register/register_view.dart';
import 'package:social_media/theme/theme.dart';
import 'package:social_media/widgets/custom_checkbox.dart';
import 'package:social_media/widgets/custom_textfiled.dart';
import 'package:social_media/widgets/custom_toast.dart';
import 'package:social_media/widgets/primary_button.dart';
import '../routes/navigation_service.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class LoginView extends StatelessWidget {
  static const routeLogin = '/LoginView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            CustomToast.showToast(
                title: state.error, customtoast: ToastType.error);
          }

          if (state is LoginSuccessState) {
            CustomToast.showToast(
                title: 'Sign in successfully', customtoast: ToastType.success);
            LoginCubit.get(context).saveUID(state.uId).then((value) {
              NavigationService.navigationPushReplacementNamed(
                  HomeView.homeView);
            });
          }
        },
        builder: (context, state) => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: SafeArea(
              child: Form(
                key: LoginCubit.get(context).keyLogin,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login to your\naccount',
                              style: heading2.copyWith(color: textBlack),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Image.asset(
                              'assets/images/accent.png',
                              width: 99.h,
                              height: 4.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 48.h,
                        ),
                        Column(
                          children: [
                            CustomTextField(
                              textfiledType: TextfiledType.normal,
                              onSaved: (newValue) =>
                                  LoginCubit.get(context).email = newValue,
                              validator: (value) =>
                                  LoginCubit.get(context).validateEmail(value),
                              title: 'Email',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            CustomTextField(
                              obscureText: LoginCubit.get(context).isPassword,
                              textfiledType: TextfiledType.password,
                              onSaved: (newValue) =>
                                  LoginCubit.get(context).password = newValue,
                              validator: ((value) =>
                                  LoginCubit.get(context).validate(value)),
                              title: 'Password',
                              keyboardType: TextInputType.text,
                              changePasswordVisibility: LoginCubit.get(context)
                                  .changePasswordVisibility,
                              icon: LoginCubit.get(context).icon,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        CustomCheckbox(
                          text: 'Remember me',
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        ConditionalBuilder(
                          fallback: (BuildContext context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          condition: state is! LoginLoadingState,
                          builder: (context) {
                            return CustomPrimaryButton(
                              buttonColor: primaryBlue,
                              textValue: 'Login',
                              textColor: Colors.white,
                              onPressed: () {
                                if (LoginCubit.get(context)
                                    .keyLogin
                                    .currentState!
                                    .validate()) {
                                  LoginCubit.get(context)
                                      .keyLogin
                                      .currentState!
                                      .save();
                                  LoginCubit.get(context).login(
                                      email: LoginCubit.get(context).email,
                                      password:
                                          LoginCubit.get(context).password);
                                }
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Center(
                          child: Text(
                            'OR',
                            style: heading6.copyWith(color: textGrey),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        CustomPrimaryButton(
                          buttonColor: const Color(0xfffbfbfb),
                          textValue: 'Login with Google',
                          textColor: textBlack,
                          onPressed: () {},
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: regular16pt.copyWith(color: textGrey),
                            ),
                            GestureDetector(
                              onTap: () {
                                NavigationService.navigationPushNamed(
                                    RegisterView.routeRegister);
                              },
                              child: Text(
                                'Register',
                                style: regular16pt.copyWith(color: primaryBlue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
