import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_with_api/modules/news_app/web_view/web_view_screen.dart';

// News App Component
//Widget myDivider() =>
Widget buildArticleItem(article, context) => InkWell(
  onTap: () {
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage('${article["urlToImage"]}'),
                fit: BoxFit.cover,
              )
          ),
        ),
        SizedBox(width: 20.0,),
        Expanded(
            child:Container(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                        '${article["title"]}',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1
                    ),
                  ),
                  Text(
                    '${article["publishedAt"]}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            )
        ),
      ],
    ),
  ),
);

Widget articleBuilder(list, {isSearch = false }) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index)=> Divider(),
        itemCount: list.length),
    fallback: (context) => isSearch? Container() : Center(child: CircularProgressIndicator())
);

void navigateTo(context, widget)=> Navigator.push(
  context,
  MaterialPageRoute(builder: (context)=> widget,
  )
);
