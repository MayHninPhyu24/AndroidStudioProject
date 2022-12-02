import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
      builder: (context, state) {
          var userModel = SocialCubit.get(context).userModel;
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 250.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Container(
                          height: 190.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4.0),
                                topLeft: Radius.circular(4.0),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  '${userModel?.cover}'
                                ),
                                fit: BoxFit.cover,
                              )
                          ),
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 65.0,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage(
                              '${userModel?.image}'
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.0,),
                Text('${userModel!.name}',
                  style: Theme.of(context).textTheme.bodyText1,),
                Text('${userModel.bio}',
                  style: Theme.of(context).textTheme.bodyText1,),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('100',
                                style: Theme.of(context).textTheme.subtitle2,),
                              Text('Posts',
                                style: Theme.of(context).textTheme.caption,),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('100',
                                style: Theme.of(context).textTheme.subtitle2,),
                              Text('Photos',
                                style: Theme.of(context).textTheme.caption,),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('100',
                                style: Theme.of(context).textTheme.subtitle2,),
                              Text('Followers',
                                style: Theme.of(context).textTheme.caption,),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('100',
                                style: Theme.of(context).textTheme.subtitle2,),
                              Text('Followings',
                                style: Theme.of(context).textTheme.caption,),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: (){},
                        child : Text('Add Photo'),
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    OutlinedButton(
                      onPressed: (){
                        navigateTo(context, EditProfileScreen());
                      },
                      child : Icon(
                        MyFlutterApp.edit,
                        size: 16.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
      },
    );
  }
}
