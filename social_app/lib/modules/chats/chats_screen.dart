import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_details/chat_details_screen.dart';
import 'package:social_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          print(state);
          if(state is SocialGetAllUserErrorState){
            print('Error');
          }else{
            print('Success');
          }
        },
        builder: (context, state) {
          print(SocialCubit.get(context).users.length);
          return ConditionalBuilder(
            condition: SocialCubit.get(context).users.length > 0,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>builChatItem(
                    SocialCubit.get(context).users[index], context),
                separatorBuilder: (context, index) =>Divider(),
                itemCount: SocialCubit.get(context).users.length),
            fallback:  (context) => Center(child: CircularProgressIndicator()),
          );
        }
    );
  }

  Widget builChatItem(UserModel model, context) =>InkWell(
    onTap: (){
      navigateTo(
        context,
        ChatDetailsScreen(model)
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(width: 20.0,),
          Text('${model.name}',
            style: TextStyle(
                height: 1.4,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    ),
  );
}
