
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/states.dart';
import 'package:shop_app_with_api/models/shop_app/category_detail_model.dart';
import 'package:shop_app_with_api/models/shop_app/favorites_model.dart';
import 'package:shop_app_with_api/models/shop_app/home_model.dart';
import 'package:shop_app_with_api/modules/shop_app/categories/categories_screen.dart';
import 'package:shop_app_with_api/modules/shop_app/favourites/favorites_screen.dart';
import 'package:shop_app_with_api/modules/shop_app/products/products_screen.dart';
import 'package:shop_app_with_api/modules/shop_app/settings/settings_screen.dart';
import 'package:shop_app_with_api/shared/components/constants.dart';
import 'package:shop_app_with_api/shared/network/dio_helper.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/login_model.dart';
import '../../../shared/network/end_point.dart';
import '../../../shared/network/local/cache_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  
  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};


  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavourite!,
        });
      });

      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    })
     .catchError((error) {
       print(error.toString());
       emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
        url: GET_CATEGORIES,
        token: token
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    })
        .catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id' : productId
        },
      token: token,
    ).then((value) {
          changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
          print(value.data);
          if(!changeFavoritesModel!.status!){
            favorites[productId] = !favorites[productId]!;
          }else{
            getFavorites();
          }
          emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
        }).catchError((error) {
           favorites[productId] = !favorites[productId]!;
           emit(ShopErrorChangeFavoritesState());
        });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
        url: FAVORITES,
        token: token
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    })
        .catchError((error) {
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel);
      emit(ShopSuccessUserDataState(userModel!));
    })
    .catchError((error) {
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
  required String name,
  required String email,
  required String phone,  
}) {
    emit(ShopLoadingUpdateUserDataState());

    DioHelper.putData(
        url: UPDATE_PROFILE,
        data: {
          'name' :name,
          'email' :email,
          'phone' : phone,
        },
        token: token
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel);
      emit(ShopSuccessUpdateUserDataState(userModel!));
    })
        .catchError((error) {
      emit(ShopErrorUpdateUserDataState());
    });
  }

  CategoryDetailModel? categoryDetailModel;
  void getCategoryProduct() {
    emit(ShopLoadingCategoryDetailProductState());
    String categoryId = CacheHelper.getData(key: 'categoryId')?? null;
    print(categoryId);
    if(categoryId.isNotEmpty){
      DioHelper.getData(
          url: CATEGORY_DETAIL+categoryId,
          token: token
      ).then((value) {
        categoryDetailModel = CategoryDetailModel.fromJson(value.data);
        print(categoryDetailModel);
        print(value.data);

        emit(ShopSuccessCategoryDetailProductState(categoryDetailModel!));
      })
          .catchError((error) {
        print('Error');
        print(error.toString());
        emit(ShopErrorCategoryDetailProductState());
      });
    }

  }


}