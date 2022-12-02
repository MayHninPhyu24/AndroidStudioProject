import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/layout/news_app/cubit/state.dart';
import 'package:shop_app_with_api/shared/components/components.dart';
import 'package:shop_app_with_api/shared/components/news_app_components.dart';

import '../../../layout/news_app/cubit/cubit.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        print('Search List Count');
        print(list.length);
        return Scaffold(
          appBar: AppBar(

          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Enter text to search";
                    }
                    return null;
                  },
                  onFieldSubmitted : (value){
                    NewsCubit.get(context).getSearch(text: value);
                  },
                  decoration: InputDecoration(
                    labelText:'search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(child: articleBuilder(list, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
