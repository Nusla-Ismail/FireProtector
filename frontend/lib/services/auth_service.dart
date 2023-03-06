import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireprotector/views/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../views/login.dart';

class AuthService extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){

        if(snapshot.hasData){
          return Home();
        }
        else{
          return Login();
        }
      },
    );
  }
}
