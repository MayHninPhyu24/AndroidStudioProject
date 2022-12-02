import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/states.dart';

import '../../../shared/components/components.dart';

class CategoryDetailScreen extends StatefulWidget {

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var form_key = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: form_key,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text('Hello Wrold'),
                    if(state is ShopLoadingCategoryDetailProductState)
                      LinearProgressIndicator(),
                    SizedBox(height: 10.0,),
                    //if(state is ShopSuccessCategoryDetailProductState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index)
                            {
                              print(ShopCubit.get(context).categoryDetailModel);
                              return Container(
                                child: Text("Hwllo"),
                              );
                              // return buildListProduct(
                              //     ShopCubit.get(context).categoryDetailModel?.data,
                              //     context, isOldPrice: false);
                            },
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: 1),
                      ),

                  ],
                ),
              ),
            ),
          ) ;
        },
      ),
    );
  }
}
