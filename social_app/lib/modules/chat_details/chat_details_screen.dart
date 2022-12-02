import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/shared/network/styles/icon_broken.dart';

import '../../models/user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;

  ChatDetailsScreen(this.userModel);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: userModel.uid);

        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {
            if(state is SendMessageErrorState){
              print('Error');
            }else{
              messageController.text = '';
            }
          },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(
                            userModel.image
                        ),
                      ),
                      SizedBox(width: 15.0,),
                      Text(userModel.name.toString())
                    ],
                  ),
                ),
                body: (SocialCubit.get(context).messages.length > 0)?
                      ConditionalBuilder(
                        condition: SocialCubit.get(context).messages.length > 0,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var message = SocialCubit.get(context).messages[index];
                                      if(SocialCubit.get(context).userModel!.uid == message.senderId){
                                        return buildMyMessage(message);
                                      }
                                      return buildMyMessage(message);
                                    },
                                    separatorBuilder: (context, index) => SizedBox(
                                      height: 15.0,
                                    ),
                                    itemCount: SocialCubit.get(context).messages.length),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: messageController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'type your message here ...',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50.0,
                                      color: Theme.of(context).primaryColor,
                                      child: MaterialButton(
                                        onPressed: (){
                                          SocialCubit.get(context)
                                              .sendMessage(
                                              receiverId: userModel.uid,
                                              dateTime: DateTime.now().toString(),
                                              text: messageController.text);
                                        },
                                        child: Icon(
                                          MyFlutterApp.send,
                                          size: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator()),
                      ) :

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: messageController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'type your message here ...',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    color: Theme.of(context).primaryColor,
                                    child: MaterialButton(
                                      onPressed: (){
                                        SocialCubit.get(context)
                                            .sendMessage(
                                            receiverId: userModel.uid,
                                            dateTime: DateTime.now().toString(),
                                            text: messageController.text);
                                      },
                                      child: Icon(
                                        MyFlutterApp.send,
                                        size: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            }
        );
      }
    );
  }
}

Widget buildMessage(MessageModel model) => Align(
  alignment: AlignmentDirectional.centerStart,
  child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(model.text.toString())
  ),
);

Widget buildMyMessage(MessageModel model) => Align(
  alignment: AlignmentDirectional.centerEnd,
  child: Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(model.text.toString())
  ),
);
