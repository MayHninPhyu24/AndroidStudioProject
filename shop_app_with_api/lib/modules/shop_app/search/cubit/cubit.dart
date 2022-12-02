import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/models/shop_app/search_model.dart';
import 'package:shop_app_with_api/modules/shop_app/search/cubit/states.dart';
import 'package:shop_app_with_api/shared/components/constants.dart';
import 'package:shop_app_with_api/shared/network/dio_helper.dart';

import '../../../../shared/network/end_point.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit(): super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    DioHelper.postData(
        url: SEARCH,
        data: {
          'text' : text
        },
        token: token,
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    })
    .catchError((error) {
      emit(SearchErrorState());
    });
  }
}