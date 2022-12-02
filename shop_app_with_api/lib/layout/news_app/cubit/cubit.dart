import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/layout/news_app/cubit/state.dart';
import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sports/sports_screen.dart';
import '../../../shared/cubit/app_cubit.dart';
import '../../../shared/network/local/news_cache_helper.dart';
import '../../../shared/network/remote/news_dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(
      Icons.business
    ),
      label: 'Business'
    ),
    const BottomNavigationBarItem(icon: Icon(
        Icons.science
    ),
        label: 'Science'
    ),
    const BottomNavigationBarItem(icon: Icon(
        Icons.sports
    ),
        label: 'Sports'
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
  ];

  void changeBottomNavBar(int index,context,country){
    currentIndex = index;
    if(index == 0)
      getBusiness(country);
    if(index == 1)
      getSports(country);
    if(index == 2)
      getScience(country);
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness(String country) {
    print("Business");
    print(country);
   emit(NewsGetBusinessLoadingState());
   if(business.isEmpty){
     NewsDioHelper.getData(
       url: 'v2/top-headlines',
       query: {
         'country' : country,
         'category': 'business',
         'apikey': 'f7446ba23fbf4b32a3b7e3d166bb9dd2'
       },
     ).then((value){
       business = value.data['articles'];
       emit(NewsGetBusinessSuccessState());
     }).catchError((error){
       print(error.toString());
       emit(NewsGetBusinessErrorState(error.toString()));
     });
   }else{
     emit(NewsGetBusinessSuccessState());
   }

  }

  List<dynamic> sports = [];

  void getSports(String country) {
    print("Sport");
    emit(NewsGetSportsLoadingState());
    if(sports.length == 0) {
      NewsDioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country' : country,
          'category': 'sports',
          'apikey': 'f7446ba23fbf4b32a3b7e3d166bb9dd2'
        },
      ).then((value){
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience(String country) {

    print("Science");
    print(country);
    science.clear();
    emit(NewsGetScienceLoadingState());
    if(science.length == 0){
      NewsDioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country' : country,
          'category': 'science',
          'apikey': 'f7446ba23fbf4b32a3b7e3d166bb9dd2'
        },
      ).then((value){
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch({required String text}) {
    search.clear();
    emit(NewsGetSearchLoadingState());
      NewsDioHelper.getData(
        url: 'v2/everything',
        query: {
          'q' : text,
          'apikey': 'f7446ba23fbf4b32a3b7e3d166bb9dd2'
        },
      ).then((value){
        search = value.data['articles'];
        print('Search result');
        print(search);
        print(search.length);
        emit(NewsGetSearchSuccessState());
      }).catchError((error){
        emit(NewsGetSearchErrorState(error.toString()));
      });
  }


}