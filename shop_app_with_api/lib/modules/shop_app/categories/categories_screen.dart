import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app_with_api/models/shop_app/categories_model.dart';
import 'package:shop_app_with_api/modules/shop_app/categories/category_detail.dart';

import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoriesModel!.data!.data[index], context),
            separatorBuilder: (context, index) => Divider(),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length);
      }
    );
  }

  Widget buildCatItem(DataModel model,context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: InkWell(
      onTap: () {
        print(model.id.toString());
        CacheHelper.saveData(
          key: 'categoryId',
          value: model.id.toString(),
        ).then((value) {
          print(ShopCubit.get(context).categoryDetailModel!.data!.price);
         // navigateAndFinish(context, CategoryDetailScreen(),);
        });
        //ShopCubit.get(context).getCategoryProduct(model.id.toString());
        //navigateTo(context, CategoryDetailScreen(model.id.toString()));
      },
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20.0,),
          Text(model.name.toString(),
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            ),

          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    ),
  );
}
