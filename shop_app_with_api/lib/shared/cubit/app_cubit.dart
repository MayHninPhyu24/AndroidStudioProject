import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app_with_api/shared/network/local/cache_helper.dart';
import 'package:shop_app_with_api/shared/network/local/news_cache_helper.dart';

import 'app_cubit_states.dart';

class AppCubit extends Cubit<AppCubitStates> {
  AppCubit(): super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  void changeAppMode(bool? fromShared){
    print(fromShared);
    if (fromShared != null) {
      isDark = !fromShared;
    }else{
      isDark = !isDark;
    }
    print('Dark value');
    print(isDark);
    NewsCacheHelper.putBoolean(key: 'isDark', value: isDark).then((value){
      emit(AppChangeModeState());
    });
  }

  String country = "jp";
  void changeCountry(String country){
    print(country);
    if(country.isNotEmpty) {
      country = country;
    }else{
      country = "jp";
    }
    NewsCacheHelper.putKey(key: 'country', value: country).then((value){
      print(country);
      emit(AppChangeCountryState());
    });
  }
}