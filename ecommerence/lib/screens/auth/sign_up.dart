import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerence/consts/colors.dart';
import 'package:ecommerence/consts/my_icons.dart';
import 'package:ecommerence/services/global_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUpScreen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();

  bool _obscureText = true;
  String _fullName = '';
  String _emailAddress = '';
  String _password = '';
  int _phoneNumber = 0;
  File? _pickedImage;

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async{
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    String url = '';
    if (isValid) {
      _formKey.currentState!.save();
      try{
        if(_pickedImage == null){
          _globalMethods.authErrorHandle('Please pick an image', context);
        }else{
          setState(() {
            _isLoading = true;
          });

          await _auth.createUserWithEmailAndPassword(
              email: _emailAddress.toUpperCase().trim(),
              password: _password.trim());
          final User user = _auth.currentUser!;
          final _uid = user.uid;
          final ref = FirebaseStorage.instance
              .ref()
              .child('userImage')
              .child(_fullName + '.jpg');
          await ref.putFile(_pickedImage!);
          url = await(ref.getDownloadURL());

          user.updateProfile(photoURL:  url, displayName: _fullName);
          user.reload();

          await FirebaseFirestore.instance.collection('users').doc(_uid)
              .set({
            'id' : _uid,
            'name' : _fullName,
            'email' : _emailAddress,
            'phoneNumber' : _phoneNumber,
            'imageUrl' : url,
            'joinedAt' : formattedDate,
            'createdAt' : Timestamp.now(),
          });
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

  void _pickImageCamera() async{
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera,
    imageQuality: 10
    );

    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }
  void _pickImageGallery() async{
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    final pickedImageFile = pickedImage == null ? null : File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }
  void _remove(){
    setState(() {
      _pickedImage = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [ColorsConsts.gradientFStart, ColorsConsts.gradientLStart],
                    [ColorsConsts.gradientFEnd, ColorsConsts.gradientLEnd],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.20, 0.25],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 0,
                size: Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Stack(
                  children:[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: CircleAvatar(radius: 71,
                      backgroundColor: ColorsConsts.gradientLEnd,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: ColorsConsts.gradientFEnd,
                        backgroundImage: _pickedImage == null
                            ? null
                            : FileImage(_pickedImage!),
                      ),
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: 120,
                      child: RawMaterialButton(
                        elevation: 10,
                        fillColor: ColorsConsts.gradientLEnd,
                        child: Icon(Icons.add_a_photo),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                        onPressed: (){
                          showDialog(
                            context: context, builder: (BuildContext context){
                            return AlertDialog(title: Text('Choose Option',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: ColorsConsts.gradientLStart
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  InkWell(
                                    onTap:_pickImageCamera,
                                    splashColor: Colors.purpleAccent,
                                    child:Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.camera,
                                            color: Colors.purpleAccent,
                                          ),

                                        ),
                                        Text('Camera', style: TextStyle(
                                          fontSize: 18,
                                          color: ColorsConsts.title
                                        ))
                                      ],
                                    ),
                                  ),

                                  InkWell(
                                    onTap: _pickImageGallery,
                                    splashColor: Colors.purpleAccent,
                                    child:Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.image,
                                            color: Colors.purpleAccent,
                                          ),

                                        ),
                                        Text('Gallery', style: TextStyle(
                                            fontSize: 18,
                                            color: ColorsConsts.title
                                        ))
                                      ],
                                    ),
                                  ),

                                  InkWell(
                                    onTap: _remove,
                                    splashColor: Colors.red,
                                    child:Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.remove_circle,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Text('Remove', style: TextStyle(
                                            fontSize: 18,
                                            color: ColorsConsts.title
                                        ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                            );
                          }
                          );
                        },
                    ),)
                  ]
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('name'),
                            focusNode: _nameFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid full name';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_nameFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(MyAppIcons.user),
                                labelText: 'Full Name',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _fullName = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('email'),
                            focusNode: _emailFocusNode,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passwordFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(Icons.email),
                                labelText: 'Email Address',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _emailAddress = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('phone number'),
                            focusNode: _phoneNumberFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a phone number';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_phoneNumberFocusNode),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(Icons.phone_android),
                                labelText: 'Phone Number',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _phoneNumber = int.parse(value!);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('Password'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Please enter password greater than 7 character.';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _passwordFocusNode,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                labelText: 'Password',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _password = value!;
                            },
                            obscureText: _obscureText,
                            onEditingComplete: _submitForm,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 10),
                            _isLoading
                                ? CircularProgressIndicator()
                                :ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: ColorsConsts.backgroundColor),
                                      ),
                                    )),
                                onPressed: _submitForm,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      MyAppIcons.user,
                                      size: 18,
                                    )
                                  ],
                                )),
                            SizedBox(width: 20),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
