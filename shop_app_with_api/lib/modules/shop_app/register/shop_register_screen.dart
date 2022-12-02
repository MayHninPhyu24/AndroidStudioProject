import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app_with_api/modules/shop_app/register/cubit/cubit.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../login/cubit/cubit.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {
  var form_key = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if(state is ShopRegisterSuccessState){
            if(state.shopLoginModel.status == true){

              print(state.shopLoginModel.message);
              print(state.shopLoginModel.data!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.shopLoginModel.data!.token,
              ).then((value) {
                navigateAndFinish(context, ShopLayout(),);
              });
            }else{
              showToast(
                  text: state.shopLoginModel.message.toString(),
                  state: ToastStates.ERROR
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: form_key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('REGISTER',
                            style: Theme.of(context).textTheme.headline4?.copyWith(
                                color: Colors.black
                            )),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),),
                        SizedBox(height: 30.0,),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText:'User Name',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText:'Email Address',
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText:  ShopRegisterCubit.get(context).isPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value){

                          },
                          decoration: InputDecoration(
                            labelText:'Password',
                            prefixIcon: Icon(
                                Icons.lock_outline
                            ),
                            suffixIcon: ShopRegisterCubit.get(context).suffix != null
                                ? IconButton(onPressed: (){
                              ShopRegisterCubit.get(context).changePasswordVisibility();
                            },
                                icon: Icon(
                                  ShopRegisterCubit.get(context).suffix,
                                )
                            )
                                : null,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter phone number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText:'Phone',
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                          ),
                        ),

                        SizedBox(height: 30.0,),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if(form_key.currentState!.validate()){
                                  ShopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone:  phoneController.text
                                  );
                                }
                              }, text: 'register'),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?'),
                            defaultTextButton(function: (){
                              navigateTo(
                                  context, ShopLoginScreen()
                              );
                            }, text: 'Login')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
