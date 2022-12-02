import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/setting_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../models/user_model.dart';
import '../../shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit(): super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users')
      .doc(uid)
      .get().then((value) {
        print(value.data());
        userModel = UserModel.fromJson(value.data()!);
        emit(SocialGetUserSuccessState());
      }).catchError((error) {
        emit(SocialGetUserErrorState(error.toString()));
     });

  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    // UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    // 'Users',
    'Settings',
  ];


  void changeBottomNav(int index) {
    // if(index == 1)
    //   getUsers();
    if(index == 2)
      emit(SocialNewPostState());
    else{
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;

  var picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery
    );

    if(pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else{
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;


  Future getCoverImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery
    );

    if(pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }else{
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }


  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
           value.ref.getDownloadURL().then((value) {
             //emit(SocialUploadProfileImageSuccessState());
             updateUser(
                 name: name,
                 phone: phone,
                 bio: bio,
                 image:value,
             );
           }).catchError((error) {
             emit(SocialUploadProfileImageErrorState());
           });
        }).catchError((error) {
          emit(SocialUploadProfileImageErrorState());
      });
  }


  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  })
  {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
       // emit(SocialUploadCoverImageSuccessState());
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover:value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

//   void updateUserImage({
//     required String name,
//     required String phone,
//     required String bio,
// }) {
//     if(coverImage != null){
//       uploadCoverImage();
//     }
//     else if(profileImage != null) {
//       uploadProfileImage();
//     }
//     else if(coverImage != null && profileImage != null){
//
//     }
//     else{
//       updateUser(name: name, phone: phone, bio: bio);
//     }
//   }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  })
  {
    UserModel model = UserModel(
        name: name,
        email: userModel!.email,
        phone: phone,
        uid: userModel!.uid,
        image: image??userModel!.image,
        cover: cover??userModel!.cover,
        bio: bio,
        isEmailVerified: false
    );

    FirebaseFirestore.instance.collection('users')
        .doc(model.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  // void verifyMail({required String uid}){
  //
  // }

  File? postImage;


  Future getPostImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery
    );

    if(pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    }else{
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }

  void removePostImage() async {
    postImage = null;
    emit(RemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
}){
    emit(CreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
      .ref()
      .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
      .putFile(postImage!)
      .then((value) {
      print(value.ref.getDownloadURL());
      value.ref.getDownloadURL().then((value) {
          print(value);
          createPost(
              dateTime: dateTime,
              text: text,
              postImage: value,
          );
          emit(CreatePostSuccessState());
        }).catchError((error){
          print(error);
          emit(CreatePostErrorState(error.toString()));
        });
    });
  }

  void createPost({
    String? postImage,
    required String dateTime,
    required String text,
  })
  {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
        name: userModel!.name,
        uid: userModel!.uid,
        image: userModel!.image,
        dateTime:  dateTime,
        postImage: (postImage != null) ? postImage as String: '',
        text:  text,
    );

    FirebaseFirestore.instance.collection('posts')
        .add(model.toMap())
        .then((value) {
      getUserData();
    }).then((value) {
      emit(CreatePostSuccessState());
    })
        .catchError((error) {
          print(error.toString());
      emit(CreatePostErrorState(error.toString()));
    });
  }
  
  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];
  List<PostModel>  postModel = [];
  void getPosts() {
    FirebaseFirestore.instance.collection('posts')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference
              .collection('likes')
              .get()
              .then((value) {
                likes.add(value.docs.length);
                postId.add(element.id);
                posts.add(PostModel.fromJson(element.data()));
              postModel.add(PostModel.fromJson(element.data()));
                emit(GetPostSuccessState(postModel));
            }).catchError((error) {
              emit(GetPostErrorState(error.toString()));
            });
          });
    }).catchError((error) {
      emit(GetPostErrorState(error.toString()));
    });
  }

  void likePost(String postId) async{
    emit(LikePostLoadingState());
    await FirebaseFirestore.instance.collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uid)
        .set({
      'like' : true,
    }).then((value) {
      print('Like');
      emit(LikePostSuccessState(postModel));
    }).catchError((error) {
      emit(LikePostErrorState(error.toString()));
    });
  }

  
  List<UserModel> users = [];

  void getUsers()  {
    //if(users.isEmpty){
      FirebaseFirestore.instance.collection('users')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if(element.data()['uid'] != userModel!.uid)
            users.add(UserModel.fromJson(element.data()));
        });
        print(users);
        emit(SocialGetAllUserSuccessState());
      }).catchError((error) {
        print(error);
        emit(SocialGetAllUserErrorState(error.toString()));
      });
    //}
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text
  }) {
    MessageModel model = MessageModel(
        senderId: userModel!.uid,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text);
    //Set My Chats
    FirebaseFirestore.instance
      .collection('users')
      .doc(userModel!.uid)
      .collection('chats')
      .doc(receiverId)
      .collection('messages')
      .add(model.toMap())
      .then((value) => {
        emit(SendMessageSuccessState())
    })
      .catchError((error) {
        emit(SendMessageErrorState());
    });
    // Set Receiver Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) => {
      emit(SendMessageSuccessState())
    })
        .catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({required receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(GetMessageSuccessState());
    });
  }



}