import 'package:flutter/cupertino.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeGetUserSuccessState extends HomeState {}

class HomeGetUserErrorState extends HomeState {
  String? error;
  HomeGetUserErrorState({@required this.error});
}

class HomeGetUserLoadingState extends HomeState {}

class HomeGetAllUserSuccessState extends HomeState {}

class HomeGetAllUserErrorState extends HomeState {
  String? error;
  HomeGetAllUserErrorState({@required this.error});
}

class HomeGetAllUserLoadingState extends HomeState {}

class HomeChangeBottomNavigatorState extends HomeState {}

class HomeNewPostState extends HomeState {}

class ImagePickedSuccessState extends HomeState {}

class ImagePickedErrorState extends HomeState {}

class CoverImagePickedSuccessState extends HomeState {}

class CoverImagePickedErrorState extends HomeState {}

class UploadImageSuccessState extends HomeState {}

class UploadImageErrorState extends HomeState {
  String? error;
  UploadImageErrorState(this.error);
}

class UploadCoverImageSuccessState extends HomeState {}

class UploadCoverImageLoadingState extends HomeState {}

class UploadCoverImageErrorState extends HomeState {
  String? error;
  UploadCoverImageErrorState(this.error);
}

class UserUploadLoadingState extends HomeState {}

class UserUploadSuccessState extends HomeState {}

class UserUploadErrorState extends HomeState {
  String? error;
  UserUploadErrorState(this.error);
}

// Create Post
class CreatePostLoadingState extends HomeState {}

class CreatePostErrorState extends HomeState {
  String? error;
  CreatePostErrorState(this.error);
}

class CreatePostSuccessState extends HomeState {}

// picked image Post

class PostImagePickedSuccessState extends HomeState {}

class PostImagePickedErrorState extends HomeState {}

class RemovePostImageState extends HomeState {}

// Get Posts
class GetPostLoadingState extends HomeState {}

class GetPostSuccessState extends HomeState {}

class GetPostErrorState extends HomeState {
  String? error;
  GetPostErrorState({this.error});
}

// Like Posts
class LikePostSuccessState extends HomeState {}

class LikePostErrorState extends HomeState {
  String? error;
  LikePostErrorState({this.error});
}

class CommentPostSuccessState extends HomeState {}

class CommenPostErrorState extends HomeState {
  String? error;
  CommenPostErrorState({this.error});
}

//message
class SentMessagesSuccessState extends HomeState {}

class SentMessagesErrorState extends HomeState {
  String? error;
  SentMessagesErrorState({this.error});
}

class GetMessagesSuccessState extends HomeState {}

class GetMessagesErrorState extends HomeState {
  String? error;
  GetMessagesErrorState({this.error});
}

class ClearMessagesSuccessState extends HomeState {}

// picked image Post

class ChatImagePickedSuccessState extends HomeState {}

class ChatImagePickedErrorState extends HomeState {}

class ChatImagePickedState extends HomeState {}

// image upload

class UploadChatsImageSuccessState extends HomeState {}

class UploadChatsImageLoadingState extends HomeState {}

class UploadChatsImageErrorState extends HomeState {
  String? error;
  UploadChatsImageErrorState(this.error);
}
