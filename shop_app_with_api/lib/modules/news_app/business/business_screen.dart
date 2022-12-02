import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/layout/news_app/cubit/cubit.dart';
import 'package:shop_app_with_api/layout/news_app/cubit/state.dart';
import '../../../shared/components/news_app_components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state)  {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;
        return articleBuilder(list);
    },

    );
  }
}
