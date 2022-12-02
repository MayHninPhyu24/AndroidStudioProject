import 'package:flutter/material.dart';
import 'package:shop_app_with_api/layout/news_app/news_layout.dart';

import '../../../shared/components/components.dart';
import '../../../shared/cubit/app_cubit.dart';
import '../../../shared/network/local/news_cache_helper.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);
  Widget buildListTile(String title, IconData icon,
      Function() tapHandler, BuildContext ctx) {
    return ListTile(
      leading: Icon(icon, size:26, color: Theme.of(ctx).splashColor,),
      trailing: Icon(Icons.arrow_forward_ios, size: 26,
        color: Theme.of(ctx).splashColor,
      ),
      title: Text(title,
          style: Theme.of(ctx).textTheme.bodyText1
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text("World Wide News",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(height: 20,),
          buildListTile("Japan",Icons.flag,
                  () {
                    AppCubit.get(context).changeCountry("jp");
                    navigateTo(context, const NewsLayout(),);
                  },
              context),
          buildListTile("Eg",Icons.flag,
                  () {
                    AppCubit.get(context).changeCountry("eg");
                  navigateTo(context, const NewsLayout(),);
              },
              context),
        ],
      ),
    );
  }
}
