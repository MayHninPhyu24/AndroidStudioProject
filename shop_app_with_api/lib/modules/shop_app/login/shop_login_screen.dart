import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_with_api/layout/shop_app/shop_layout.dart';
import 'package:shop_app_with_api/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_app_with_api/modules/shop_app/register/shop_register_screen.dart';
import 'package:shop_app_with_api/shared/components/components.dart';
import 'package:shop_app_with_api/shared/network/local/cache_helper.dart';

import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  var form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){
            if(state.shopLoginModel.status == true){

              print(state.shopLoginModel.message);
              print("Login Token");
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
        builder: (context, state){
          return Scaffold(
          appBar: AppBar(

          ),
          body: Center(
          child: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: form_key,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('LOGIN',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                color: Colors.black
                )),
                Text(
                'Login now to browse our hot offers',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Colors.grey
                ),),
                SizedBox(height: 30.0,),
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

              //   defaultFormField(
              //   controller: passwordController,
              //   type: TextInputType.visiblePassword,
              //   suffix: ShopLoginCubit.get(context).suffix,
              //   onSubmit: (value){
              //     if(form_key.currentState!.validate()){
              //       ShopLoginCubit.get(context).userLogin(
              //         email: emailController.text,
              //         password: passwordController.text,);
              //     }
              //   },
              //   suffixPressed: () {
              //     ShopLoginCubit.get(context).changePasswordVisibility();
              //   },
              //   isPassword: ShopLoginCubit.get(context).isPassword,
              //   validate: (String value){
              //     print(value);
              //     if(value.isEmpty){
              //       return 'password is too short';
              //     }
              //   },
              //   label: 'Password',
              //   prefix: Icons.lock_outline,
              // ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText:  ShopLoginCubit.get(context).isPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password is too short';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value){
                      if(form_key.currentState!.validate()){
                        ShopLoginCubit.get(context).userLogin(
                          email: emailController.text,
                          password: passwordController.text,);
                      }
                    },
                decoration: InputDecoration(
                  labelText:'Password',
                  prefixIcon: Icon(
                      Icons.lock_outline
                  ),
                  suffixIcon: ShopLoginCubit.get(context).suffix != null
                      ? IconButton(onPressed: (){
                    ShopLoginCubit.get(context).changePasswordVisibility();
                  },
                      icon: Icon(
                        ShopLoginCubit.get(context).suffix,
                      )
                  )
                      : null,
                  border: OutlineInputBorder(),
                ),
                ),

              SizedBox(height: 30.0,),
              ConditionalBuilder(
                  condition: state is! ShopLoginLoadingState,
                  builder: (context) => defaultButton(
                      function: () {
                        if(form_key.currentState!.validate()){
                          ShopLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,);
                        }
                      }, text: 'login'),
                fallback: (context) => Center(child: CircularProgressIndicator()),

              ),

              // defaultButton(
              //     function: () {
              //       print(emailController.text);
              //       print(passwordController.text);
              //     },
              //     text: 'login',
              // ),
              // ConditionalBuilder(
              //   condition: state is! ShopLoginLoadingState,
              //   builder: (context) => defaultButton(
              //     function: () {
              //       if(form_key.currentState!.validate()){
              //         ShopLoginCubit.get(context).userLogin(
              //             email: emailController.text,
              //             password: passwordController.text);
              //       }
              //
              //     },
              //     text: 'login',
              //     isUpperCase: true,
              //   ),
              //   fallback: (context) => Center(
              //       child: CircularProgressIndicator()
              //   ),
              // ),




              SizedBox(height: 15.0,),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?'),
                defaultTextButton(function: (){
                  navigateTo(
                  context, ShopRegisterScreen()
                  );
                }, text: 'Register')
              ],
              ),
              ],
            ),
          ),
          ),
          ),
          )
          );
        },
      ),
    );
  }
}
