import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_with_api/modules/shop_app/login/shop_login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}
class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboarding.jpeg',
        title: 'On Board 1 Title',
        body: 'On Board 1 body'),
    BoardingModel(
        image: 'assets/images/onboarding1.jpg',
        title: 'On Board 2 Title',
        body: 'On Board 2 body'),
    BoardingModel(
        image: 'assets/images/onboarding2.png',
        title: 'On Board 3 Title',
        body: 'On Board 3 body'),
    BoardingModel(
        image: 'assets/images/onboarding3.png',
        title: 'On Board 4 Title',
        body: 'On Board 4 body')
  ];

  bool isLast = false;

  void submit () {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value){
      if(value){
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: submit,
            text: 'SKIP'
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index){
                  if(index == boarding.length - 1){
                    setState(() {
                      isLast = true;
                    });
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5.0
                    ),
                    count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(isLast) {
                    submit();
                  }else{
                    boardController.nextPage(
                    duration: Duration(
                    milliseconds: 750,
                    ),
                    curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                child: Icon(
                  Icons.arrow_forward_ios,
                ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        SizedBox(height: 30.0,),
        Text('${model.title}',
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 15.0),
        Text('${model.body}',
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 15.0),

      ],
    );
}
