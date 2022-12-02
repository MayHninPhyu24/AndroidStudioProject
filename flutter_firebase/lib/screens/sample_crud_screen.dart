import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_firebase/services/auth_service.dart';

class SampleCRUDScreen extends StatelessWidget {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        // actions: [
        //   TextButton.icon(onPressed: () async{
        //     await AuthService().signOut();
        //   },
        //     icon: Icon(Icons.logout),
        //     label: Text("Sign out"),
        //     style: TextButton.styleFrom(
        //         primary: Colors.white
        //     ),
        //   )
        // ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async{
                  CollectionReference users = firestore.collection('users');
                  print(users);
                  // await users.add({
                  //   'name' : 'Rahul'
                  // });

                  await users.doc("flutter123").set({
                    'name': "Google Flutter"
                  });
                },
                child: Text("Add New Data to FireStore")),
            ElevatedButton(onPressed: () async{
              CollectionReference users = firestore.collection('users');
              //Get All doc
              // QuerySnapshot allResults = await users.get();
              // allResults.docs.forEach((DocumentSnapshot result) {
              //   print(result.data());
              // });

              //Get only One flutter123 doc
              DocumentSnapshot result = await users.doc("flutter123").get();
              print(result.data());

              // users.doc("flutter123").snapshots().listen((result) {
              //   print(result.data());
              // });

            }, child: Text("Read Data From Firestore")),

            //Update
            ElevatedButton(onPressed: () async{
              await firestore.collection('users').doc("flutter123").update({
                'name' : "Flutter Firebase"
              });
            },
                child: Text("Update data in firestore")),

            //Delete
            ElevatedButton(onPressed: () async{
              await firestore.collection('users').doc("flutter123").delete();
            }, child: Text("Delete Data from firestore")),
          ],
        ),
      ),
    );
  }
}
