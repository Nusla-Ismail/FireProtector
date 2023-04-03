import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireprotector_camera/home.dart';
import 'package:fireprotector_camera/login.dart';
import 'package:fireprotector_camera/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'p2pVideo.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return P2PVideo();
        } else {
          return Login();
        }
      },
    );
  }
}
