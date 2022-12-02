import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/states.dart';
import 'package:shop_app_with_api/shared/components/components.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var form_key = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController =TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        print(model!.data!.name);
        nameController.text = model.data?.name?? '';
        emailController.text = model.data?.email?? '';
        phoneController.text = model.data?.phone?? '';

        return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) =>Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: form_key,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserDataState)
                      LinearProgressIndicator(),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText:'Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Email must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText:'Email Address',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText:'Phone',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    defaultButton(function: (){
                      if(form_key.currentState!.validate()){
                        ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text);
                      }
                    },
                        text: 'Update'),
                    SizedBox(height: 20.0,),
                    defaultButton(function: (){
                      signOut(context);
                    },
                        text: 'Logout')
                  ],
                ),
              ),
            ),
            fallback: (context) => CircularProgressIndicator());
      },
    );
  }
}
