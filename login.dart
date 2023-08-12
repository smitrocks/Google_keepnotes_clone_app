import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_login_system/services/auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:keepnotes_clone/home.dart';
import 'package:keepnotes_clone/services/auth.dart';
import 'package:keepnotes_clone/services/firestore_db.dart';
import 'package:keepnotes_clone/services/login_info.dart';

class Login extends StatefulWidget {


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login To App"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(Buttons.Google, onPressed:() async {
              await signInWithGoogle();
              final User? currentUser = await _auth.currentUser;
              LocalDataSaver.saveLoginData(true);
              LocalDataSaver.saveImg(currentUser!.photoURL.toString());
              LocalDataSaver.saveMail(currentUser!.email.toString());
              LocalDataSaver.saveName( currentUser!.displayName.toString());
              LocalDataSaver.saveSyncSet(false);
              await FireDB().getAllStoredNotes();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
            })
          ],
        ),
      ),
    );

  }
}