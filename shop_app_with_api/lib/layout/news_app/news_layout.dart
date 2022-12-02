import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/layout/news_app/cubit/cubit.dart';
import 'package:shop_app_with_api/modules/news_app/search/search_screen.dart';
import 'package:shop_app_with_api/shared/cubit/app_cubit.dart';
import 'package:shop_app_with_api/shared/network/remote/news_dio_helper.dart';

import '../../modules/news_app/widget/main_drawer.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/news_cache_helper.dart';
import 'cubit/state.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        },
      builder: (context, state) {
         var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('International News'),
              actions: [
                IconButton(onPressed: (){
                  navigateTo(context, Search(),);
                }, icon: Icon(Icons.search)),
                IconButton(onPressed: (){
                  bool isDark = NewsCacheHelper.getBoolean(key: 'isDark')?? false;
                  AppCubit.get(context).changeAppMode(isDark);
                }, icon: Icon(Icons.brightness_4_outlined)),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            // floatingActionButton: FloatingActionButton(
            //   onPressed: (){
            //
            //   },
            //   child: Icon(
            //     Icons.add
            //   ),
            // ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                var country =AppCubit.get(context).country;

                cubit.changeBottomNavBar(index, context,country);
              },
              items:  cubit.bottomItems,
            ),
            //drawer: MainDrawer(),
          );
      });
  }
}
