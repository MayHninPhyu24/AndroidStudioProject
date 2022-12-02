import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Programmer'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.account_circle, color:Colors.pink,size: 40,),
              trailing: IconButton(onPressed:(){},icon:Icon(Icons.delete), color: Colors.red,),
              title: Text("Mr John"),
              subtitle: Text('Let\'s study flutter this hiliday'),
              onTap: (){
                print('You tap this listtile');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color:Colors.pink,size: 40,),
              trailing: IconButton(onPressed:(){},icon:Icon(Icons.delete), color: Colors.red,),
              title: Text("Mr John"),
              subtitle: Text('Let\'s study flutter this hiliday'),
              onTap: (){
                print('You tap this listtile');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color:Colors.pink,size: 40,),
              trailing: IconButton(onPressed:(){},icon:Icon(Icons.delete), color: Colors.red,),
              title: Text("Mr John"),
              subtitle: Text('Let\'s study flutter this hiliday'),
              onTap: (){
                print('You tap this listtile');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color:Colors.pink,size: 40,),
              trailing: IconButton(onPressed:(){},icon:Icon(Icons.delete), color: Colors.red,),
              title: Text("Mr John"),
              subtitle: Text('Let\'s study flutter this hiliday'),
              onTap: (){
                print('You tap this listtile');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color:Colors.pink,size: 40,),
              trailing: IconButton(onPressed:(){},icon:Icon(Icons.delete), color: Colors.red,),
              title: Text("Mr John"),
              subtitle: Text('Let\'s study flutter this hiliday'),
              onTap: (){
                print('You tap this listtile');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color:Colors.pink,size: 40,),
              trailing: IconButton(onPressed:(){},icon:Icon(Icons.delete), color: Colors.red,),
              title: Text("Mr John"),
              subtitle: Text('Let\'s study flutter this hiliday'),
              onTap: (){
                print('You tap this listtile');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color:Colors.pink,size: 40,),
              trailing: IconButton(onPressed:(){},icon:Icon(Icons.delete), color: Colors.red,),
              title: Text("Mr John"),
              subtitle: Text('Let\'s study flutter this hiliday'),
              onTap: (){
                print('You tap this listtile');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color:Colors.pink,size: 40,),
              trailing: IconButton(onPressed:(){},icon:Icon(Icons.delete), color: Colors.red,),
              title: Text("Mr John"),
              subtitle: Text('Let\'s study flutter this hiliday'),
              onTap: (){
                print('You tap this listtile');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color:Colors.pink,size: 40,),
              trailing: IconButton(onPressed:(){},icon:Icon(Icons.delete), color: Colors.red,),
              title: Text("Mr John"),
              subtitle: Text('Let\'s study flutter this hiliday'),
              onTap: (){
                print('You tap this listtile');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color:Colors.pink,size: 40,),
              trailing: IconButton(onPressed:(){},icon:Icon(Icons.delete), color: Colors.red,),
              title: Text("Mr John"),
              subtitle: Text('Let\'s study flutter this hiliday'),
              onTap: (){
                print('You tap this listtile');
              },
            ),
          ],
        ),
      ),
      //EdgeInsets.only,all,fromLTRB
      floatingActionButton: FloatingActionButton(
        child: Text("+"),
        onPressed: (){
          print("Hello");
        },
        backgroundColor: Colors.grey,
      ),
    );
  }
}