import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireprotector/views/home.dart';
import 'package:fireprotector/views/page_selector.dart';
import 'package:fireprotector/views/register.dart';
import 'package:fireprotector/widgets/large_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/rounded_input_field.dart';
import '../widgets/toast.dart';

class Login extends StatefulWidget {

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn(BuildContext context) async {

    showDialog(
        context: context,
        builder: (context){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => PageSelector()),
      );
    } on FirebaseAuthException catch (e){
      if (e.code == 'user-not-found') {
        ToastBar(text: 'No user found for that email', color: Colors.red).show();
      } else if (e.code == 'wrong-password') {
        ToastBar(text: 'Incorrect Password', color: Colors.red).show();
      } else if (e.code == 'invalid-email') {
        ToastBar(text: 'Email is invalid', color: Colors.red).show();
      }
      Navigator.pop(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff212121),
                  image: DecorationImage(
                    image: AssetImage("assets/images/back_design.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Image.asset("assets/images/logo.png"),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      Text(
                        "Login Details",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      RoundedInputField(labelText: "Email Address", controller: emailController),
                      SizedBox(
                        height: 20.h,
                      ),
                      RoundedInputField(labelText: "Password", isPassword: true, controller: passwordController),
                      SizedBox(
                        height: 15.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password ?",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      LargeButton(
                          onPressed: (){
                            if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
                              ToastBar(text: 'Please fill all the fields!', color: Colors.red).show();
                            } else {
                              ToastBar(text: 'Please wait...', color: Colors.orange).show();

                              signIn(context);
                            }
                          },
                          text: "Login"),
                      Expanded(child: SizedBox()),
                      RichText(
                        text: TextSpan(
                          text: 'Don’t you have an account?  ',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),
                          children: <TextSpan>[
                            TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(builder: (context) => Register()),
                                );
                              },
                              text: 'Sign Up',
                              style: TextStyle(
                                fontFamily: 'Google',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
