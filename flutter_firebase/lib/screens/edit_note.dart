import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/note.dart';
import 'package:flutter_firebase/services/firestore_service.dart';
import 'package:image_picker/image_picker.dart';
class EditNoteScreen extends StatefulWidget {
  NoteModel note;

  EditNoteScreen(this.note);
  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool loading =false;

  File? imageFile;
  String? fileName;

  Future<void> uploadImage() async{
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage == null){
      return null;
    }
    setState(() {
      fileName = pickedImage.name;
      imageFile = File(pickedImage.path);
    });
  }

  @override
  void initState() {
    titleController.text = widget.note.title;
    descriptionController.text = widget.note.description;
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () async{
            await showDialog(context: context,
                builder: (BuildContext context){
              return AlertDialog(
                title: Text("Please Confirm"),
                content: Text("Are you sure to delete the note?"),
                actions: [
                  // Yes Button
                  TextButton(onPressed: () async{
                    await FirestoreService().deleteNote(widget.note.id);
                    //close the dialog
                    Navigator.pop(context);
                    //close the edit screen
                    Navigator.pop(context);
                  }, child: Text("Yes")),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("No"))
                ],
              );
            });
          },
              icon: Icon(Icons.delete),color: Colors.red,)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  uploadImage();
                },
                child: Container(
                    height: 150,
                    child: imageFile == null ? Center(
                      child: Icon(Icons.image,size: 100,),
                    ): Center(
                      child: Image.file(imageFile!),
                    )
                ),
              ),
              Text("Title", style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 20,),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20,),
              Text("Description", style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 20,),
              TextField(
                controller: descriptionController,
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20,),
              loading? Center(child: CircularProgressIndicator(),):Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(onPressed: () async{
                  if(titleController.text == "" || descriptionController.text =="" || imageFile==null){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All Fields are required!"), backgroundColor: Colors.red,));
                  }else{
                    setState(() {
                      loading = true;
                    });
                    String imageUrl = await FirebaseStorage.instance.ref(fileName).putFile(imageFile!).then((result){
                      return result.ref.getDownloadURL();
                    });
                    print(imageUrl);
                    await FirestoreService().updateNote(widget.note.id, titleController.text, descriptionController.text, imageUrl);
                    setState(() {
                      loading = false;
                      Navigator.pop(context);
                    });
                  }
                }, child: Text("Update Note", style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),),style: ElevatedButton.styleFrom(primary: Colors.orange),),
              )
            ],
          ),
        ),
      ),

    );
  }
}
