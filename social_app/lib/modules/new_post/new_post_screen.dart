import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/shared/network/styles/icon_broken.dart';

import '../../layout/social_layout.dart';
import '../../shared/components/components.dart';

class NewPostScreen extends StatefulWidget {

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  var textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var userModel = SocialCubit.get(context).userModel;
    var profileImage = SocialCubit.get(context).profileImage;
    var coverImage = SocialCubit.get(context).coverImage;

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is CreatePostSuccessState){
          textController.text = '';
          print('Success');
          navigateAndFinish(
            context,
            SocialLayout(),
          );
        }else{
          print('Error');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Create Post',
              actions: [
                defaultTextButton(function: (){
                  if(SocialCubit.get(context).postImage == null) {
                    setState(() {
                      SocialCubit.get(context).createPost(
                          dateTime: DateTime.now().toString(),
                          text: textController.text
                      );
                    });
                  }else{
                   setState(() {
                     SocialCubit.get(context).uploadPostImage(
                         dateTime: DateTime.now().toString(),
                         text: textController.text
                     );
                   });
                  }
                },
                    text: 'Post')
              ]
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState)
                  LinearProgressIndicator(),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        '${userModel!.image}'
                      ),
                    ),
                    SizedBox(width: 20.0,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${userModel.name}',
                            style: TextStyle(
                                height: 1.4,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind.',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 190.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage!) as ImageProvider,
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    IconButton(icon: CircleAvatar(
                      radius: 20.0,
                      child: Icon(
                        MyFlutterApp.close,
                        size: 16.0,
                      ),
                    ),
                      onPressed: (){
                        SocialCubit.get(context).removePostImage();
                      },
                    )
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialCubit.get(context).getPostImage();
                      },
                          child: Row(
                            children: [
                              Icon(MyFlutterApp.image,),
                              SizedBox(width: 5.0,),
                              Text('Add Photo'),
                            ],
                          )),
                    ),
                    SizedBox(width: 15.0,),
                    Spacer(),
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialCubit.get(context).getPostImage();
                      },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 5.0,),
                              Text('# tags',
                              ),
                            ],
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
