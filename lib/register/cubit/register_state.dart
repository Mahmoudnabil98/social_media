// ignore_for_file: must_be_immutable

part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  late String error;
  RegisterErrorState(this.error);
}

class RegisterChangePasswordVisibility extends RegisterState {}

class CreateUserSuccessStateState extends RegisterState {}

class CreateUserErrorState extends RegisterState {
  late String error;
  CreateUserErrorState(this.error);
}
