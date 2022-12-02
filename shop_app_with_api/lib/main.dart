import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app_with_api/layout/news_app/news_layout.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app_with_api/layout/shop_app/shop_layout.dart';
import 'package:shop_app_with_api/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app_with_api/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shop_app_with_api/shared/components/constants.dart';
import 'package:shop_app_with_api/shared/cubit/app_cubit.dart';
import 'package:shop_app_with_api/shared/cubit/app_cubit_states.dart';
import 'package:shop_app_with_api/shared/network/dio_helper.dart';
//import 'package:shop_app_with_api/shared/network/news_dio_helper.dart';
import 'package:shop_app_with_api/shared/network/local/cache_helper.dart';
import 'package:shop_app_with_api/shared/network/local/news_cache_helper.dart';
import 'package:shop_app_with_api/shared/network/remote/news_dio_helper.dart';
import 'package:shop_app_with_api/shared/styles/themes.dart';

import 'layout/news_app/cubit/cubit.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  //Bloc.observer = MyBlocObserver();
  DioHelper.init(); // Shop App

  await CacheHelper.init();
  late Widget widget;

 // bool isDark = CacheHelper.getData(key: 'isDark')?? false;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding')?? false;
  token = CacheHelper.getData(key: 'token');


  if(onBoarding == true){
    if(token != null) widget = ShopLayout();
    else widget = ShopLoginScreen();
  }else{
    widget = OnBoardingScreen();
  }
  //News App
  NewsDioHelper.init();  // News App
  await NewsCacheHelper.init();
  bool isDark = NewsCacheHelper.getBoolean(key: 'isDark')??false;

  String country = NewsCacheHelper.getKey(key: 'country') ??'jp';
  runApp(MyApp(isDark: isDark, startWidget : widget,country: country));

}

class MyApp extends StatelessWidget {

  final bool isDark;
  final Widget startWidget;
  final String country;

  MyApp({required this.isDark, required this.startWidget, required this.country});

  @override
  Widget build(BuildContext context) {
      return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => NewsCubit()
              ..getBusiness(country)
              ..getSports(country)
              ..getScience(country),
            ),
            BlocProvider(
                create: (BuildContext context) => AppCubit()
                  ..changeAppMode(isDark)..changeCountry(country),
            ),
            BlocProvider(create: (BuildContext context) =>
              ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
            ),
          ],
          child: BlocConsumer<AppCubit, AppCubitStates>(
            listener: (context, state) {
            },
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner : false,
                themeMode: AppCubit.get(context).isDark
                    ? ThemeMode.dark : ThemeMode.light,
                theme: ThemeData(
                    primarySwatch: Colors.deepOrange,
                    scaffoldBackgroundColor: Colors.white,
                    appBarTheme: const AppBarTheme(
                        titleSpacing: 20.0,
                        backwardsCompatibility:false,
                        systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor: Colors.white,
                            statusBarIconBrightness: Brightness.dark
                        ),
                        backgroundColor: Colors.white,
                        elevation: 0.0,
                        titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        iconTheme: IconThemeData(
                          color: Colors.black,
                        )
                    ),
                    floatingActionButtonTheme: const FloatingActionButtonThemeData(
                        backgroundColor: Colors.deepOrange
                    ),
                    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.grey,
                      elevation: 20.0,
                      backgroundColor: Colors.white,
                    ),
                    textTheme: const TextTheme(
                        bodyText1: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        )
                    )
                ),
                darkTheme: ThemeData(
                    primarySwatch: Colors.deepOrange,
                    scaffoldBackgroundColor: HexColor('333739'),
                    appBarTheme: AppBarTheme(
                        titleSpacing: 20.0,
                        backwardsCompatibility:false,
                        systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor:HexColor('333739'),
                            statusBarIconBrightness: Brightness.light
                        ),
                        backgroundColor: HexColor('333739'),
                        elevation: 0.0,
                        titleTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        iconTheme:const IconThemeData(
                          color: Colors.white,
                        )
                    ),
                    floatingActionButtonTheme: const FloatingActionButtonThemeData(
                        backgroundColor: Colors.deepOrange
                    ),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.grey,
                      elevation: 20.0,
                      backgroundColor: HexColor('333739'),
                    ),
                    textTheme: const TextTheme(
                        headline1: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.white
                        ),
                        bodyText1: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        )
                    ),
                    // drawerTheme: DrawerThemeData(
                    //   backgroundColor: HexColor('333739'),
                    // )

                ),
                // home:  startWidget, => Shop App
                home: const NewsLayout(),
              );
            },
          ),

      ) ;
  }
}
