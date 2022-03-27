abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  late String? uId;
  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginState {
  late String error;
  LoginErrorState(this.error);
}

class LoginChangePasswordVisibility extends LoginState {}
