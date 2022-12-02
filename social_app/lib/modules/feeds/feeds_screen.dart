import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/network/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is LikePostSuccessState){
          print('Success');
        }
        },
      builder: (context, state) {
        return (SocialCubit.get(context).posts.length > 0)?
                ConditionalBuilder(
            condition: SocialCubit.get(context).posts.length > 0 &&
            SocialCubit.get(context).userModel != null,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 20.0,
                    margin: EdgeInsets.all(8.0,),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/portrait-young-asia-lady-with-positive-expression-arms-crossed-smile-broadly-dressed-casual-clothing-looking-space-pink-background_7861-3204.jpg?size=626&ext=jpg&ga=GA1.1.774279577.1647576898'
                          ),
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Communicate with friends',
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

          ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(
                        SocialCubit.get(context).posts[index],
                        context, index),
                    itemCount:  SocialCubit.get(context).posts.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                          height: 8.0,
                        ),
                  ),
                  SizedBox(height: 8.0,)
                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()))
            : Center(child: Text('No Post Available'));
      },
    );
  }

  Widget buildPostItem (PostModel model, context, index) =>Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 20.0,
    margin: EdgeInsets.symmetric(
        horizontal: 8.0
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(
                  '${model.image}'
                ),
              ),
              SizedBox(width: 20.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${model.name}',
                          style: TextStyle(
                              height: 1.4,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(width: 5.0,),
                        Icon(Icons.check_circle,
                          color: Theme.of(context).primaryColor,
                          size: 14.0,
                        )
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          height: 1.4
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 20.0,),
              IconButton(onPressed: () {},
                  icon: Icon(Icons.more_horiz, size: 16.0,))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 0.5,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          if(model.postImage != '')
            Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              height: 190.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${model.postImage}'
                    ),
                    fit: BoxFit.cover,
                  )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            MyFlutterApp.favorite_border,
                            size: 16.0,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5.0,),
                          Text('${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),                            ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            MyFlutterApp.chat,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 5.0,),
                          Text('120 Comments' ,
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),                            ),
                )

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: double.infinity,
              height: 0.5,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15.0,
                        backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel?.image}'
                        ),
                      ),
                      SizedBox(width: 20.0,),
                      Text(
                        'write a comment',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            height: 1.4
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                   SocialCubit.get(context).likePost(
                       SocialCubit.get(context).postId[index]
                   );
                },
                child: Row(
                  children: [
                    Icon(
                      MyFlutterApp.favorite_border,
                      size: 18.0,
                      color: Colors.red,
                    ),
                    SizedBox(width: 5.0,),
                    Text('Like',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),                            ),
            ],
          ),
        ],
      ),
    ),
  );
}
