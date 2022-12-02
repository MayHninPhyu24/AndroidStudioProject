import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:invite_app/models/user_model.dart';
import 'package:invite_app/screens/not_invited_screen.dart';

import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool isLoading = false;
  bool isOtpScreen = false;
  var verificationCode;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
  
  Future phoneAuth() async {
    var _phoneNumber = _phoneController.text.trim();
    setState(() {
      isLoading = true;
    });
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential){
          _firebaseAuth.signInWithCredential(credential).then((userData) async{
            if(userData != null) {
              await _fireStore.collection('users').doc(userData.user?.uid).set({
                'name': '',
                'phone' : userData.user?.phoneNumber,
                'uid' : userData.user?.uid,
                'invitesLeft' : 5,
              });
              setState(() {
                isLoading =false;
              });
            }
          });
        },
        verificationFailed: (FirebaseAuthException error){
          print("Firebase Error: ${error.message}");
        },
        codeSent: (String verificationId, int? resendToken){
          setState(() {
            isLoading = false;
            isOtpScreen = true;
            verificationCode = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId){
          setState(() {
            isLoading = false;
            verificationCode = verificationId;
          });
        },timeout: Duration(seconds: 120)
    );
  }

  Future otpSignIn() async {
    setState(() {
      isLoading = true;
    });
    try{
      _firebaseAuth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationCode,
              smsCode: _otpController.text.trim())
      ).then((userData) async{
        UserModel user;
        if(userData != null){
          var userExist = await _fireStore.collection('users')
              .where('phone', isEqualTo: _phoneController.text.trim()).get();
          if(userExist.docs.isNotEmpty) {
            print('user already exist');
            user = UserModel.fromMap(userExist.docs.first);
          }else{
            print('New User Created');
            user = UserModel(
                name: '',
                uid: userData.user?.uid,
                phone: userData.user?.phoneNumber,
                invitesLeft: 5);
            await _fireStore.collection('users').doc(userData.user?.uid)
                .set(UserModel().toMap(user));
          }
          var userInvited = await _fireStore.collection('invites').where(
            'invitee' ,isEqualTo: _phoneController.text.trim()).get();
          if(userInvited.docs.length <1) {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=>NotInvitedScreen()
            ));
            return;
          }
          setState(() {
            isLoading = false;
          });
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomeScreen(user: user,)));
          print('Login Success');
          print(userData.user?.phoneNumber);
        }
      });
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 60),
              height: 150,
              child: Text('Club House',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            Expanded(child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                )
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 60,),
                    Icon(Icons.connect_without_contact, size: 60,
                      color: Colors.blue,),
                    SizedBox(height: 60,),
                    Text('Login With Phone', style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontStyle: FontStyle.italic
                    )),
                    SizedBox(height: 30,),
                    isOtpScreen ?
                   Padding(padding: EdgeInsets.all(10),
                      child: TextField(
                          controller: _otpController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Otp',
                              hintText: 'Enter the otp you got'
                          )
                      ),
                    ) :
                    Padding(padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Phone Number With Country Code',
                          hintText: 'Enter your invited phone number'
                        )
                      ),
                    ),
                    SizedBox(height: 30,),
                    isLoading? CircularProgressIndicator(): Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        onPressed: (){
                          isOtpScreen ? otpSignIn():phoneAuth();
                        },
                        child: Text('Login', style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    ),

    );
  }
}
