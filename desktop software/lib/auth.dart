import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireprotector_camera/home.dart';
import 'package:fireprotector_camera/login.dart';
import 'package:fireprotector_camera/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return Login();
        }
      },
    );
  }
}
