import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/modules/shop_app/login/cubit/states.dart';

import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/network/dio_helper.dart';
import '../../../../shared/network/end_point.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit(): super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel shopLoginModel;
  void userLogin({required String email, required String password,}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email' : email,
          'password' : password,
        },
    ).then((value){
      print(value.data);
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(shopLoginModel));
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());
  }
}