import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/social_login/social_login_screen.dart';
import 'package:social_app/shared/components/components.dart';

import '../shared/network/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if(state is SocialNewPostState){
            navigateTo(context, NewPostScreen());
          }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
         return Scaffold(
           appBar: AppBar(
             title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
                // defaultTextButton(
                //   function: (){
                //     FirebaseAuth.instance.currentUser!
                //         .sendEmailVerification()
                //         .then((value){
                //       showToast(text: 'check your email',
                //           state: ToastStates.SUCCESS);
                //
                //     }).catchError((error){
                //       showToast(text: error,
                //           state: ToastStates.ERROR);
                //
                //     });
                //   },
                //   text: 'Verify Email',
                // ),
                IconButton(onPressed: (){},
                    icon: Icon(MyFlutterApp.notifications)),
                IconButton(onPressed: (){},
                    icon: Icon(MyFlutterApp.search)),
                IconButton(onPressed: () async{
                  await FirebaseAuth.instance.signOut().then((value) {
                    navigateTo(context,SocialLoginScreen());
                  });
                },
                    icon: Icon(MyFlutterApp.exit_to_app))
              ],
           ),
           body: cubit.screens[cubit.currentIndex],
           bottomNavigationBar: BottomNavigationBar(
             currentIndex: cubit.currentIndex,
             onTap: (index){
                cubit.changeBottomNav(index);
             },
             items: [
               BottomNavigationBarItem(
                 icon:Icon(
                   MyFlutterApp.home,
                 ),
                 label: 'Home'
               ),
               BottomNavigationBarItem(
                   icon:Icon(
                     MyFlutterApp.chat,
                   ),
                   label: 'Chat'
               ),
               BottomNavigationBarItem(
                   icon:Icon(
                     MyFlutterApp.cloud_upload,
                   ),
                   label: 'Post'
               ),
               // BottomNavigationBarItem(
               //     icon:Icon(
               //       MyFlutterApp.location_on,
               //     ),
               //     label: 'Users'
               // ),
               BottomNavigationBarItem(
                   icon:Icon(
                     MyFlutterApp.settings,
                   ),
                   label: 'Setting'
               ),
             ],
           ),
         );
        }
    );
  }
}
