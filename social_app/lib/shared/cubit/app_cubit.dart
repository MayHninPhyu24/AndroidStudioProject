import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/local/cache_helper.dart';
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
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value){
      emit(AppChangeModeState());
    });
  }


}