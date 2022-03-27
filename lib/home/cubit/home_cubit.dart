import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/chats/chats_view.dart';
import 'package:social_media/feeds/feeds_view.dart';
import 'package:social_media/home/cubit/home_state.dart';
import 'package:social_media/login/login_view.dart';
import 'package:social_media/model/message_model.dart';
import 'package:social_media/model/user_model.dart';
import 'package:social_media/new_post/new_post_view.dart';
import 'package:social_media/routes/navigation_service.dart';
import 'package:social_media/settings/settings_view.dart';
import 'package:social_media/users/users_view.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../model/post_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  String keyUID = 'uid';
  int currentIndex = 0;

  final keyProfile = GlobalKey<FormState>();
  final keyPost = GlobalKey<FormState>();

  List<Widget> views = [
    FeedsView(),
    ChatsView(),
    const NewPostView(),
    UsersView(),
    SettingsView(),
  ];
  UserModel? userModel;
  List<PostModel>? postList = [];
  List<String> postId = [];
  List<int> likes = [];
  List<UserModel> users = [];
  List<String> title = ['Home', 'Chats', 'ADD Post', 'Users', 'Settings'];
  List<MessageModel> messages = [];

  final ImagePicker _picker = ImagePicker();
  var bioController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var postController = TextEditingController();
  var commetController = TextEditingController();
  var messageController = TextEditingController();
  File? profileImage;
  File? coverImage;
  File? postImage;
  File? chatImage;

  void changeBottomNav(int index) {
    if (index == 1) {
      getAllUsers();
    }

    if (index == 2) {
      emit(HomeNewPostState());
    } else {
      currentIndex = index;
      emit(HomeChangeBottomNavigatorState());
    }
  }

  Future<String> getUid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? uid = sharedPreferences.getString(keyUID);
    return uid!;
  }

  void getUser() async {
    emit(HomeGetUserLoadingState());
    String uId = await getUid();
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(HomeGetUserSuccessState());
    }).catchError((error) {
      emit(HomeGetUserErrorState(error: error.toString()));
    });
  }

  Future<void> imagePicker() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ImagePickedSuccessState());
    } else {
      emit(ImagePickedErrorState());
    }
  }

  Future<void> coverImagePicker() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      log('message1');
      emit(CoverImagePickedSuccessState());
    } else {
      emit(CoverImagePickedErrorState());
      log('message2');
    }
  }

  Future<void> postPicker() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      log('postImage');
      emit(PostImagePickedSuccessState());
    } else {
      emit(PostImagePickedErrorState());
      log('postImage');
    }
  }

  Future<void> chatPicker() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      log('chatImageImage');
      emit(ChatImagePickedSuccessState());
    } else {
      emit(ChatImagePickedErrorState());
      log('chatImageImageError');
    }
  }

  Future<void> uploadProfileImage() async {
    emit(UserUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) => value.ref.getDownloadURL().then((value) {
              updateUser(
                image: value,
                bio: bioController.text,
                name: nameController.text,
                phone: phoneController.text,
              );
              // emit(UploadImageSuccessState());
            }).catchError((error) {
              emit(UploadImageErrorState(error));
            }))
        .whenComplete(() {
      log('UploadImageSuccessState');
      //  emit(UploadImageSuccessState());
    }).catchError((error) {
      log('Url error');
    });
  }

  Future<void> uploadProfileCoverImage() async {
    emit(UserUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) => value.ref.getDownloadURL().then((value) {
              updateUser(
                cover: value,
                bio: bioController.text,
                name: bioController.text,
                phone: phoneController.text,
              );
              // emit(UploadCoverImageSuccessState());
            }).catchError((error) {
              emit(UploadCoverImageErrorState(error));
            }))
        .whenComplete(() {
      log('UploadCoverImageSuccessState');
      // emit(UploadCoverImageSuccessState());
    }).catchError((error) {
      log('Url error');
    });
  }

  Future<void> updateUser({
    String? cover,
    String? image,
    String? name,
    String? phone,
    String? bio,
  }) async {
    emit(UserUploadLoadingState());
    UserModel model = UserModel(
        bio: bioController.text,
        name: nameController.text,
        isEmailVerified: false,
        phone: phoneController.text,
        email: userModel!.email,
        coverImage: cover ?? userModel!.coverImage!,
        image: image ?? userModel!.image!,
        uid: userModel!.uid);
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(model.uid)
        .update(model.toJson())
        .then((value) {
      getUser();
      //emit(UserUploadSuccessState());
      log('UserUploadSuccessState');
    }).catchError((error) {
      emit(UserUploadErrorState(error));
    });
  }

  Future<void> uploadPostImage({
    @required String? text,
    @required String? dateTime,
  }) async {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) => value.ref.getDownloadURL().then((value) {
              createPost(dateTime: dateTime, text: text, postImage: value);
            }).catchError((error) {
              emit(CreatePostErrorState(error));
            }))
        .whenComplete(() {
      log('UploadCoverImageSuccessState');
    }).catchError((error) {
      emit(CreatePostErrorState(error));
    });
  }

  Future<void> createPost({
    @required String? text,
    @required String? dateTime,
    String? postImage,
  }) async {
    emit(CreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image!,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,
      uId: userModel!.uid,
    );
    await FirebaseFirestore.instance
        .collection('Posts')
        .add(model.toJson())
        .then((value) {
      emit(CreatePostSuccessState());
      log('CreatePostSuccessState');
    }).catchError((error) {
      log('CreatePostErrorState');
      emit(CreatePostErrorState(error));
    });
  }

  void removeImagePost() {
    postImage = null;
    emit(RemovePostImageState());
  }

  void getPost() {
    emit(GetPostLoadingState());
    FirebaseFirestore.instance.collection('Posts').get().then((value) {
      value.docs.forEach((element) {
        postId = [];
        postList = [];
        likes = [];
        element.reference.collection("Likes").snapshots().listen((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          postList!.add(PostModel.fromJson(element.data()));

          log('likes length ${likes.length}');
        });
      });

      emit(GetPostSuccessState());
    });
  }

  void likePost(String? postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Likes')
        .doc(userModel!.uid)
        .set({'like': true}).then((value) {
      emit(LikePostSuccessState());
      log("LikePostSuccessState");
    }).catchError((onError) {
      emit(LikePostErrorState());
      log("LikePostErrorState");
    });
  }

  void commentPost(String? postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Comments')
        .doc(userModel!.uid)
        .set({'Comments': commetController.text}).then((value) {
      emit(CommentPostSuccessState());
      log("CommentPostSuccessState");
    }).catchError((onError) {
      emit(CommentPostSuccessState());
      log("CommentPostSuccessState");
    });
  }

  void getAllUsers() {
    emit(HomeGetAllUserLoadingState());
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('Users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != userModel!.uid) {
            users.add(UserModel.fromJson(element.data()));
          }
        });
        emit(HomeGetAllUserSuccessState());
      }).catchError((onError) {
        emit(HomeGetAllUserErrorState(error: onError));
      });
    }
  }

  Future<void> signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    await FirebaseAuth.instance.signOut().then((value) {
      NavigationService.navigationPushNamed(LoginView.routeLogin);
    });
  }

  /// set my chats

  void sendMessage({
    required String? text,
    required String? receiverId,
    required String? dataTime,
    required String? image,
  }) {
    MessageModel messageModel = MessageModel(
        dataTime: dataTime,
        receiverId: receiverId,
        text: text,
        senderId: userModel!.uid,
        image: image ?? '');

    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uid)
        .collection('Chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toJson())
        .then((value) {
      emit(SentMessagesSuccessState());
      log('SentMessagesSuccessState1');
    }).catchError((error) {
      emit(SentMessagesErrorState(error: error));
    });
// set receiver chats
    FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverId)
        .collection('Chats')
        .doc(userModel!.uid)
        .collection('messages')
        .add(messageModel.toJson())
        .then((value) {
      emit(SentMessagesSuccessState());
      log('SentMessagesSuccessState2');
    }).catchError((error) {
      emit(SentMessagesErrorState(error: error));
      log('SentMessagesErrorState2');
    });
  }

  void getmessages({
    required String? receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uid)
        .collection('Chats')
        .doc(receiverId)
        .collection('messages')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessagesSuccessState());
      log('GetMessagesSuccessState');
    }).onError((error) {
      emit(GetMessagesErrorState(error: error));
      log('GetMessagesErrorState');
    });
  }

  void messageControllerClear(BuildContext context) {
    messageController.clear();
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    messageController.text = '';
    emit(ClearMessagesSuccessState());
  }

  Future<void> uploadChatImage({
    @required String? dateTime,
    @required String? text,
    @required String? receiverId,
  }) async {
    emit(UploadChatsImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Chats/${Uri.file(chatImage!.path).pathSegments.last}')
        .putFile(chatImage!)
        .then((value) => value.ref.getDownloadURL().then((value) {
              sendMessage(
                  dataTime: dateTime,
                  image: value,
                  receiverId: receiverId,
                  text: text);
            }).catchError((error) {
              emit(UploadChatsImageErrorState(error));
            }))
        .whenComplete(() {})
        .catchError((error) {
      emit(UploadChatsImageErrorState(error));
    });
  }
}
