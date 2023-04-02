import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireprotector/views/home.dart';
import 'package:fireprotector/views/page_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../views/login.dart';

class AuthService extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrentUser(){
    User? user = _auth.currentUser;
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return getCurrentUser() == null ? Login() : PageSelector();
  }
}
