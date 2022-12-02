import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/social_login/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../social_register/social_register_screen.dart';
import 'cubit/cubit.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var form_key = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }

          if(state is SocialLoginSuccessState) {
            print('UID' + state.uid);
            CacheHelper.saveData(
              key: 'uid',
              value: state.uid,
            ).then((value) {
              navigateAndFinish(
                context,
                SocialLayout(),
              );
            });
          }
        },
        builder: (context, state) {
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
                            'Login now to communicate with friends',
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
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText:  SocialLoginCubit.get(context).isPassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                              return null;
                            },
                            onFieldSubmitted: (value){
                              if(form_key.currentState!.validate()){
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,);
                              }
                            },
                            decoration: InputDecoration(
                              labelText:'Password',
                              prefixIcon: Icon(
                                  Icons.lock_outline
                              ),
                              suffixIcon: SocialLoginCubit.get(context).suffix != null
                                  ? IconButton(onPressed: (){
                                SocialLoginCubit.get(context).changePasswordVisibility();
                              },
                                  icon: Icon(
                                    SocialLoginCubit.get(context).suffix,
                                  )
                              )
                                  : null,
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 30.0,),
                          ConditionalBuilder(
                            condition: state is! SocialLoginLoadingState,
                            builder: (context) => defaultButton(
                              function: () {
                                if(form_key.currentState!.validate()){
                                  SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'login',
                              isUpperCase: true,
                            ),
                            fallback: (context) => Center(
                                child: CircularProgressIndicator()
                            ),
                          ),




                          SizedBox(height: 15.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account?'),
                              defaultTextButton(function: (){
                                navigateTo(
                                    context, SocialRegisterScreen()
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
        },),
      );
  }
}
