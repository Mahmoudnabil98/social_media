import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/model/user_model.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  final keyRegister = GlobalKey<FormState>();
  String? email;
  String? password;
  String? name;
  String? phone;

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
    emit(RegisterChangePasswordVisibility());
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
      return 'Please enter the data correctly';
    } else {
      return null;
    }
  }

  void createUser({
    @required String? email,
    @required String? name,
    @required String? phone,
    @required String? uid,
    String? bio = 'Write your bio ...',
    String image =
        'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1647516037~exp=1647516637~hmac=68783e32198856e135ed2be75e88c03c2ac53722074aa4319c4dc9948c006246&w=740',
    String coverImage =
        "https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?t=st=1647516980~exp=1647517580~hmac=a360ed043f5d0d9e48a4c2e37421edeb3f61c31c0535ae94c0605be0fa19b9f6&w=1060",
  }) async {
    UserModel userModel = UserModel(
        email: email,
        name: name,
        phone: phone,
        uid: uid,
        bio: bio,
        image: image,
        coverImage: coverImage);
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .set(userModel.toJson())
        .then((value) {
      emit(CreateUserSuccessStateState());
    }).catchError((onError) {
      emit(CreateUserErrorState(onError.toString()));
    });
  }

  void register({
    @required String? email,
    @required String? password,
    @required String? name,
    @required String? phone,
  }) async {
    emit(RegisterLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      log("Email ${value.user!.email.toString()}");
      log("uid ${value.user!.uid.toString()}");

      createUser(
          email: email,
          name: name,
          phone: phone,
          uid: value.user!.uid.toString());
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }
}
