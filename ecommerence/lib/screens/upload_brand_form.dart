import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerence/consts/colors.dart';
import 'package:ecommerence/services/global_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadBrandForm extends StatefulWidget {
  static const routeName = '/UploadBrandForm';

  @override
  _UploadBrandFormState createState() => _UploadBrandFormState();
}

class _UploadBrandFormState extends State<UploadBrandForm> {
  final _formKey = GlobalKey<FormState>();

  var _brandTitle = '';
  File? _pickedImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;
  String url = '';
  var uuid = Uuid();

  showAlertDialog(BuildContext context, String title, String body) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _trySubmit() async{
    final isValid = _formKey.currentState!.validate();

    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      try{
        if(_pickedImage == null){
          print("NULL");
          _globalMethods.authErrorHandle('Please pick an image', context);
        }else{
          setState(() {
            _isLoading = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child('brandImage')
              .child(_brandTitle + '.jpg');
          await ref.putFile(_pickedImage!);
          url = await(ref.getDownloadURL());

          final User user = _auth.currentUser!;
          final _uid = user.uid;
          final _brandId = uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'

          await FirebaseFirestore.instance.collection('brands').doc(_brandId)
              .set({
            'brandId' : _brandId,
            'brandTitle' : _brandTitle,
            'brandImage' : url,
            'userId' : _uid,
            'createdAt' : Timestamp.now(),
          });
          Fluttertoast.showToast(
              msg: "Brand Successfully Uploaded.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
          _pickedImage = null;
          _formKey.currentState!.reset();
          Navigator.canPop(context)? Navigator.pop(context): null;
        }
      }catch(error){
        _globalMethods.authErrorHandle('$error.message', context);
      }finally{
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    // widget.imagePickFn(pickedImageFile);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    final pickedImageFile = pickedImage == null ? null : File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile!;
    });
    // widget.imagePickFn(pickedImageFile);
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: kBottomNavigationBarHeight * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorsConsts.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: _trySubmit,
            splashColor: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: _isLoading
                      ? Center(child: Container(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator()))
                      : Text('Upload',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center),
                ),
                GradientIcon(
                  Typicons.upload,
                  20,
                  LinearGradient(
                    colors: <Color>[
                      Colors.green,
                      Colors.yellow,
                      Colors.deepOrange,
                      Colors.orange,
                      Colors.yellowAccent
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Card(
                margin: EdgeInsets.fromLTRB(15, 30, 15, 15),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: TextFormField(
                                  key: ValueKey('Title'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a Title';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Brand Title',
                                  ),
                                  onSaved: (value) {
                                    _brandTitle = value!;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),

                        /* Image picker here ***********************************/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              //  flex: 2,
                              child: this._pickedImage == null
                                  ? Container(
                                margin: EdgeInsets.all(10),
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(4),
                                  color:
                                  Theme.of(context).backgroundColor,
                                ),
                              )
                                  : Container(
                                margin: EdgeInsets.all(10),
                                height: 200,
                                width: 200,
                                child: Container(
                                  height: 200,
                                  // width: 200,
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.only(
                                    //   topLeft: const Radius.circular(40.0),
                                    // ),
                                    color:
                                    Theme.of(context).backgroundColor,
                                  ),
                                  child: Image.file(
                                    this._pickedImage!,
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: FlatButton.icon(
                                    textColor: Colors.white,
                                    onPressed: _pickImageCamera,
                                    icon: Icon(Icons.camera,
                                        color: Colors.purpleAccent),
                                    label: Text(
                                      'Camera',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .textSelectionColor,
                                      ),
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: FlatButton.icon(
                                    textColor: Colors.white,
                                    onPressed: _pickImageGallery,
                                    icon: Icon(Icons.image,
                                        color: Colors.purpleAccent),
                                    label: Text(
                                      'Gallery',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .textSelectionColor,
                                      ),
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: FlatButton.icon(
                                    textColor: Colors.white,
                                    onPressed: _removeImage,
                                    icon: Icon(
                                      Icons.remove_circle_rounded,
                                      color: Colors.red,
                                    ),
                                    label: Text(
                                      'Remove',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  GradientIcon(
      this.icon,
      this.size,
      this.gradient,
      );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
