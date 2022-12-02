
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_login/cubit/states.dart';



class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit(): super(SocialLoginInitialState());
  static SocialLoginCubit get(context) => BlocProvider.of(context);
  // late SocialLoginModel SocialLoginModel;
  void userLogin({required String email, required String password,}) {
    
    emit(SocialLoginLoadingState());
    
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print('Login Success');
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error){
      print('Login Fail');
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(SocialChangePasswordVisibilityState());
  }
}