import 'package:flutter/material.dart';

class FutureScreen extends StatefulWidget {
  const FutureScreen({Key? key}) : super(key: key);

  @override
  _FutureScreenState createState() => _FutureScreenState();
}

class _FutureScreenState extends State<FutureScreen> {

  Future<void> getData() async {
   try{
     final userId = await Future.delayed(Duration(seconds: 3), () {
       print('User Id 100');
       return 1;
     });
     await Future.delayed(Duration(seconds: 2), (){
       print('Hey its flutter user $userId');
     });
     print("Random line of code");
   }catch(error){
     print(error);
   }
  }

  Future<String> getUserName() async{
    final String user = await Future.delayed(Duration(seconds: 2),
            (){
          return "Hello Guest";
        });
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Tutorial'),
      ),
        body: FutureBuilder(
          future: getUserName(),
          builder:(context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return Center(
                child: Text(snapshot.data),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
    );
  }
}
