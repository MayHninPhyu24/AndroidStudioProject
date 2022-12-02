
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/social_register/cubit/states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit(): super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String name,
    required String email,
    required String password,
    required  String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      userCreate(
          name: name,
          email: email,
          uid: value.user!.uid,
          phone: phone,
      );

    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });

  }

  void userCreate({
    required String name,
    required String email,
    required String uid,
    required  String phone,
  }){
    UserModel userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      uid: uid,
      image: 'https://img.freepik.com/free-photo/portrait-young-asia-lady-with-positive-expression-arms-crossed-smile-broadly-dressed-casual-clothing-looking-space-pink-background_7861-3204.jpg?t=st=1647603536~exp=1647604136~hmac=253e5380c1fc2d6e3d13d5956a8d8b0336931f576ca56ce695b2b15d6f3c01cc&w=996',
      cover: 'https://img.freepik.com/free-photo/portrait-young-asia-lady-with-positive-expression-arms-crossed-smile-broadly-dressed-casual-clothing-looking-space-pink-background_7861-3204.jpg?t=st=1647603536~exp=1647604136~hmac=253e5380c1fc2d6e3d13d5956a8d8b0336931f576ca56ce695b2b15d6f3c01cc&w=996',
      bio: 'This is bio.',
      isEmailVerified: false
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userModel.toMap()).then((value) {
          emit(SocialCreateUserSuccessState(uid));
        }).catchError((error) {
         emit(SocialCreateUserErrorState(error));
       });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}