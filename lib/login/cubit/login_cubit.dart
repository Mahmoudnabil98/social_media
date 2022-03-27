import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  String? email, password;
  String keyUID = 'uid';

  final keyLogin = GlobalKey<FormState>();
  IconData icon = Icons.visibility_outlined;

  bool isPassword = true;
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  void changePasswordVisibility() {
    isPassword = !isPassword;
    icon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibility());
  }

  validateEmail(String? value) {
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  validate(String? value) {
    if (value == null || value.length <= 6) {
      return 'weak password';
    } else {
      return null;
    }
  }

  Future<void> saveUID(String? uId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(keyUID, uId!).then((value) {
      log('save Uid');
    });
  }

  Future<void> login(
      {@required String? email, @required String? password}) async {
    emit(LoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      log("Email ${value.user!.email.toString()}");
      log("uid ${value.user!.uid.toString()}");
      emit(LoginSuccessState(value.user!.uid.toString()));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }
}
