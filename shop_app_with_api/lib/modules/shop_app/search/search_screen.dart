import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/modules/shop_app/search/cubit/cubit.dart';
import 'package:shop_app_with_api/modules/shop_app/search/cubit/states.dart';

import '../../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var form_key = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
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
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Enter text to search";
                        }
                        return null;
                      },
                      onFieldSubmitted: (value){
                        SearchCubit.get(context).search(value);
                      },
                      decoration: InputDecoration(
                        labelText:'search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 10.0,),
                    if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index)
                            {
                              return buildListProduct(
                                  SearchCubit.get(context).model?.data?.data?[index],
                                  context, isOldPrice: false);
                            },
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: SearchCubit.get(context).model!.data!.data!.length),
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
