import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import '../models/meal.dart';
import '../screens/meal_detail_screen.dart';
import 'package:provider/provider.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem({
    required this.id,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
  });

  String get complexityText {
    switch(complexity){
      case Complexity.Simple: return 'Simple';break;
      case Complexity.Challenging: return 'Challenging';break;
      case Complexity.Hard: return 'Hard';break;
      case Complexity.Simple: return 'Simple'; break;
      default: return 'Unknown'; break;
    }
  }

  String get affodabilityText {
    switch(affordability){
      case Affordability.Affordable: return 'Affordable';break;
      case Affordability.Pricey: return 'Pricey';break;
      case Affordability.Luxurious: return 'Luxurious';break;
      default: return 'Unknown'; break;
    }
  }

  void selectMeal(BuildContext ctx){
    Navigator.of(ctx).pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    ).then((result) {
      print(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr: TextDirection.rtl,
      child: SingleChildScrollView(
        child: InkWell(
          onTap: ()=> selectMeal(context),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),

            ),
            elevation: 4,
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Hero(
                        tag: id,
                        child:InteractiveViewer(
                            child: FadeInImage(
                              width: double.infinity,
                              height: 230,
                              placeholder: AssetImage('assets/images/a2.png'),
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: Container(
                        width: 300,
                        color: Colors.black54,
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: Text(
                          '${lan.getTexts("meal-$id")}' ,
                          style: TextStyle(fontSize: 26, color: Colors.white),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      )
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.schedule, color: Theme.of(context).splashColor,),
                          SizedBox(width: 6,),
                          Text('$duration min', style: TextStyle(
                            color: Theme.of(context).splashColor
                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.work,color: Theme.of(context).splashColor,),
                          SizedBox(width: 6,),
                          Text('${lan.getTexts("$complexity")}', style: TextStyle(
                              color: Theme.of(context).splashColor
                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.attach_money,color: Theme.of(context).splashColor,),
                          SizedBox(width: 6,),
                          Text('${lan.getTexts("$affordability")}', style: TextStyle(
                              color: Theme.of(context).splashColor
                          ),),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
