import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_login/social_login_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/app_cubit.dart';
import 'package:social_app/shared/cubit/app_cubit_states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import 'layout/cubit/cubit.dart';
import 'shared/components/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  FirebaseMessaging.onMessage.listen((event) {
    print("Messaging");
    print(event.data.toString());
  }).onError((error) {
    print('error');
  });

  var token = FirebaseMessaging.instance.getToken();

  print(token);

  Widget widget;
  uid = CacheHelper.getData(key: 'uid');

  isDark = CacheHelper.getData(key: 'isDark');

  print(isDark);
  if (uid != null) {
    widget = SocialLayout();
  }else{
    widget = SocialLoginScreen();
  }
  runApp(MyApp(
    startWidget : widget,isDark: isDark
  ));
}

class MyApp extends StatefulWidget {
  Widget startWidget;
  bool? isDark;

  MyApp({required this.startWidget, this.isDark});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:[
        BlocProvider(
          create: (BuildContext context) => AppCubit()
        ),
          BlocProvider(
            create: (BuildContext context) => SocialCubit()..getUserData()
              ..getPosts()..getUsers(),
          ),
        ],
        child: BlocConsumer<AppCubit, AppCubitStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner : false,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark : ThemeMode.light,
              theme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: const AppBarTheme(
                      titleSpacing: 20.0,
                      backwardsCompatibility:false,
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      titleTextStyle: TextStyle(
                        fontFamily: 'Roboto',
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
                          fontFamily: 'Roboto',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),
                      subtitle1: TextStyle(
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
                    backgroundColor: HexColor('333739'),
                    elevation: 0.0,
                    titleTextStyle: const TextStyle(
                      fontFamily: 'Roboto',
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
                        fontFamily: 'Roboto',
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white
                    ),
                    bodyText1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    ),
                    subtitle1: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    )
                ),

              ),
              home: widget.startWidget,
            );
          },
        ),
    );
  }
}
