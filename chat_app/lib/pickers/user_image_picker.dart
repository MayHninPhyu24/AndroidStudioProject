
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;
  UserImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  File? _pickerImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource src) async{
    final pickedImageFile = await _picker.getImage(source: src, imageQuality: 50,maxWidth: 150);

    if(pickedImageFile != null) {
      setState(() {
        _pickerImage = File(pickedImageFile.path);
      });
      widget.imagePickFn(_pickerImage!);
    } else{
      print("No image selected");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickerImage != null? FileImage(_pickerImage!): null,
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
              onPressed: ()=> _pickImage(ImageSource.camera),
              textColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.photo_camera_outlined),
              label: Text("Add Image\n from camera", textAlign: TextAlign.center,),
            ),
            FlatButton.icon(
              onPressed: ()=> _pickImage(ImageSource.gallery),
              textColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.image_outlined),
              label: Text("Add Image\n from Gallery", textAlign: TextAlign.center,),
            ),

          ],
        )
      ],
    );
  }
}
