import 'package:shop_app_with_api/models/shop_app/login_model.dart';

abstract class AppCubitStates {}

class AppInitialState extends AppCubitStates {}

class AppLoadingState extends AppCubitStates {}

class AppSuccessState extends AppCubitStates {}

class AppChangeModeState extends AppCubitStates {}

class AppChangeCountryState extends AppCubitStates {}
