import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:invite_app/models/user_model.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class CreateAClub extends StatefulWidget {
  final UserModel user;

  CreateAClub(this.user);

  @override
  _CreateAClubState createState() => _CreateAClubState();
}

class _CreateAClubState extends State<CreateAClub> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _speakerController = TextEditingController();
  List<String> categories = [];
  List<Map> speakers = [];
  String selectedCategory = '';
  DateTime? _dateTime;
  String type = "private";

  @override
  void initState() {
    fetchCategories();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future fetchCategories() async{
    FirebaseFirestore.instance.collection('categories').get().then((value){
      value.docs.forEach((element) {
        categories.add(element.data()['title']);
      });

      setState(() {

      });
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1efe5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Create your club', style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value){
                    if(value! ==''){
                      return "Field is required";
                    }
                    return null;
                  },
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Discussion Topic/Title'),
                ),
                SizedBox(height: 30),
                DropDown<String>(
                  hint: Text('Select Category'),
                  items: categories,
                  onChanged: (value) {
                    selectedCategory = value!;
                  },
                ),
                SizedBox(height: 30),
                ListTile(
                  leading: CircleAvatar(
                    child: speakers.length < 1
                        ? Icon(Icons.mic)
                        : Text('${speakers.length}'),
                  ),
                  title: Text('Invite Speakers'),
                  subtitle: Text('Optional'),
                  trailing:   ElevatedButton(
                   child: Text('Add'),
                   onPressed: () async{
                    if (await FlutterContacts.requestPermission()) {
                      var contact = await FlutterContacts.openExternalPick();
                      if(contact != null) {
                        var phone = contact.phones.single.normalizedNumber;
                        print(phone);
                        FirebaseFirestore.instance.collection('users')
                            .where('phone',isEqualTo: phone)
                            .get()
                            .then((value) {
                          if(value.docs.length > 0) {
                            speakers.add({
                              'name' : value.docs.first.data()['name'],
                              'phone' : phone
                            });
                            setState(() {});
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('No User Found. Please invite your friends', style: TextStyle(
                                color: Colors.white,
                              ),),
                              backgroundColor: Colors.red,
                            ));
                          }

                        });

                      }
                    }

                  }),
                ),
                ...speakers.map((user) {
                  var name = user.values.first;
                  var phone = user.values.last;

                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(name),
                    subtitle: Text(phone),
                  );
                }),
                SizedBox(height: 20,),
                Text('Select Data Time below', style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(
                  height: 100,
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.dateAndTime,
                    onDateTimeChanged: (DateTime dateTime) {
                      _dateTime = dateTime;
                    },
                  ),
                ),
                SizedBox(height: 13,),
                Row(
                  children: [
                    Text('Discussion Type:'),
                    Radio(value: "private", groupValue: type, onChanged: (value){
                      setState(() {
                        type = value as String;
                      });
                    },),
                    Text('Private', style: TextStyle(
                      fontSize: 10,
                    ),),
                    Radio(value: "public", groupValue: type, onChanged: (value){
                      setState(() {
                        type = value as String;
                      });
                    },),
                    Text('Public', style: TextStyle(
                      fontSize: 10,
                    ),),
                  ]
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(child: ElevatedButton(
                        onPressed: () async{
                          if(selectedCategory == ''){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Select a category', style: TextStyle(
                                color: Colors.white,
                              ),),
                            ));
                            return;
                          }
                          if(_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            speakers.insert(0,{
                              'name' : widget.user.name,
                              'phone' : widget.user.phone,
                            });

                            await FirebaseFirestore.instance.collection('clubs')
                              .add({
                              'title' : _titleController.text,
                              'category' : selectedCategory,
                              'createdBy' : widget.user.phone,
                              'invited' : speakers,
                              'createdOn' : DateTime.now(),
                              'dateTime' : _dateTime,
                              'type' : type,
                              'status' : 'new'
                            });
                            Navigator.pop(context);
                          }

                        },
                        child: Text('Create'))),
                  ],
                ),
              ],
            ) ),
        ),
      ),
    );
  }
}
