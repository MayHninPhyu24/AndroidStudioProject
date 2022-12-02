import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/network/styles/icon_broken.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;

        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                defaultTextButton(
                    function: (){
                      SocialCubit.get(context)
                          .updateUser(
                            name: nameController.text,
                            phone: phoneController.text,
                            bio: bioController.text);
                    },
                    text: 'Update'
                ),
                SizedBox(width: 15.0),
              ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                    SizedBox(height: 10.0,),
                  Container(
                    height: 250.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 190.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(4.0),
                                      topLeft: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                      image: coverImage == null ?
                                      NetworkImage(
                                          '${userModel.cover}'
                                      ) :
                                      FileImage(coverImage) as ImageProvider,
                                      fit: BoxFit.cover,
                                    )
                                ),
                              ),
                              IconButton(icon: CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  MyFlutterApp.photo_camera,
                                  size: 16.0,
                                ),
                              ),
                                onPressed: (){
                                  SocialCubit.get(context).getCoverImage();
                                },
                              )
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null ?
                                  NetworkImage(
                                      '${userModel.image}'
                                  ) : 
                                 FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(icon: CircleAvatar(
                              radius: 20.0,
                              child: Icon(
                                MyFlutterApp.photo_camera,
                                size: 16.0,
                              ),
                            ),
                              onPressed: (){
                                SocialCubit.get(context).getProfileImage();
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  if(SocialCubit.get(context).profileImage != null ||
                    SocialCubit.get(context).coverImage != null
                  )
                    Row(
                    children: [
                      if(SocialCubit.get(context).profileImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                function: (){
                                  SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text);
                                },
                                text: 'Upload profile',
                              ),
                              if(state is SocialUserUpdateLoadingState)
                                SizedBox(height: 5.0,),
                              if(state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      SizedBox(width : 10.0,),
                      if(SocialCubit.get(context).coverImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(function: (){
                                SocialCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text);
                              },
                                text: 'Upload cover',
                              ),
                              if(state is SocialUserUpdateLoadingState)
                                SizedBox(height: 5.0,),
                              if(state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                    ],
                  ),
                    SizedBox(height: 20.0,),
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
                      prefixIcon: Icon(MyFlutterApp.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your bio';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText:'Bio',
                      prefixIcon: Icon(MyFlutterApp.info),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText:'Phone',
                      prefixIcon: Icon(MyFlutterApp.phone_android),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
