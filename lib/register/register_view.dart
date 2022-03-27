import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/home/home_view.dart';
import 'package:social_media/login/login_view.dart';
import 'package:social_media/register/cubit/register_cubit.dart';
import 'package:social_media/theme/theme.dart';
import 'package:social_media/widgets/custom_textfiled.dart';
import 'package:social_media/widgets/custom_toast.dart';
import 'package:social_media/widgets/primary_button.dart';
import '../routes/navigation_service.dart';
import '../widgets/custom_checkbox.dart';

// ignore: use_key_in_widget_constructors
class RegisterView extends StatelessWidget {
  static const routeRegister = '/RegisterView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
        if (state is RegisterErrorState) {
          CustomToast.showToast(
              title: state.error, customtoast: ToastType.error);
        }
        if (state is RegisterSuccessState) {
          CustomToast.showToast(
              title: 'Account has been successfully registered',
              customtoast: ToastType.success);
        }

        if (state is CreateUserSuccessStateState) {
          NavigationService.navigationPushReplacementNamed(
              LoginView.routeLogin);
        }
      }, builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).backgroundColor,
          body: Form(
            key: RegisterCubit.get(context).keyRegister,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24.0.w, 40.0.h, 24.0.w, 0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Register new\naccount',
                            style: heading2.copyWith(color: textBlack),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Image.asset(
                            'assets/images/accent.png',
                            width: 99.w,
                            height: 4.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 48.h,
                      ),
                      Column(
                        children: [
                          CustomTextField(
                            onSaved: (newValue) {
                              RegisterCubit.get(context).name = newValue;
                            },
                            validator: (value) =>
                                RegisterCubit.get(context).validate(value),
                            title: 'Name',
                            textfiledType: TextfiledType.normal,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 32.h,
                          ),
                          CustomTextField(
                            onSaved: (newValue) {
                              RegisterCubit.get(context).email = newValue;
                            },
                            validator: (value) =>
                                RegisterCubit.get(context).validateEmail(value),
                            title: 'Email',
                            textfiledType: TextfiledType.normal,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 32.h,
                          ),
                          CustomTextField(
                            keyboardType: TextInputType.phone,
                            onSaved: (newValue) {
                              RegisterCubit.get(context).phone = newValue;
                            },
                            validator: (value) =>
                                RegisterCubit.get(context).validate(value),
                            title: 'Phone',
                            textfiledType: TextfiledType.normal,
                          ),
                          SizedBox(
                            height: 32.h,
                          ),
                          CustomTextField(
                            obscureText: RegisterCubit.get(context).isPassword,
                            onSaved: (newValue) {
                              RegisterCubit.get(context).password = newValue;
                            },
                            validator: (value) =>
                                RegisterCubit.get(context).validate(value),
                            title: 'Password',
                            changePasswordVisibility: RegisterCubit.get(context)
                                .changePasswordVisibility,
                            icon: RegisterCubit.get(context).icon,
                            textfiledType: TextfiledType.password,
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomCheckbox(
                                  text:
                                      'By creating an account, you agree to our'),
                              SizedBox(
                                width: 12.w,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Text(
                                    'Terms & Conditions',
                                    style: regular16pt.copyWith(
                                        color: primaryBlue),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      ConditionalBuilder(
                        fallback: (BuildContext context) =>
                            const Center(child: CircularProgressIndicator()),
                        condition: state is! RegisterLoadingState,
                        builder: (context) => CustomPrimaryButton(
                          buttonColor: primaryBlue,
                          textValue: 'Register',
                          textColor: Colors.white,
                          onPressed: () {
                            if (RegisterCubit.get(context)
                                .keyRegister
                                .currentState!
                                .validate()) {
                              RegisterCubit.get(context)
                                  .keyRegister
                                  .currentState!
                                  .save();
                              RegisterCubit.get(context).register(
                                  email: RegisterCubit.get(context).email,
                                  password: RegisterCubit.get(context).password,
                                  name: RegisterCubit.get(context).name,
                                  phone: RegisterCubit.get(context).phone);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: regular16pt.copyWith(color: textGrey),
                          ),
                          GestureDetector(
                            onTap: () {
                              NavigationService.navigationPopNamed(
                                  LoginView.routeLogin);
                            },
                            child: Text(
                              'Login',
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
        );
      }),
    );
  }
}
