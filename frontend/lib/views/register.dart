import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireprotector/views/login.dart';
import 'package:fireprotector/widgets/underlined_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/large_button.dart';
import '../widgets/rounded_input_field.dart';
import '../widgets/toast.dart';

class Register extends StatefulWidget {

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final fireController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp(BuildContext context) async {

    showDialog(
        context: context,
        builder: (context){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );

    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e){
      if (e.code == 'weak-password') {
        ToastBar(text: 'The password provided is too weak', color: Colors.red).show();
      } else if (e.code == 'email-already-in-use') {
        ToastBar(text: 'The account already exists for that email', color: Colors.red).show();
      }
    } catch (e) {
      ToastBar(text: e.toString(), color: Colors.red).show();
    }

    Navigator.pop(context);

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
                        height: 80.h,
                      ),
                      Text(
                        "Sign up Details",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      UnderlinedInputField(labelText: "Name", controller: nameController),
                      SizedBox(
                        height: 30.h,
                      ),
                      UnderlinedInputField(labelText: "Email", controller: emailController),
                      SizedBox(
                        height: 30.h,
                      ),
                      UnderlinedInputField(labelText: "Nearest Fire Station", controller: fireController),
                      SizedBox(
                        height: 20.h,
                      ),
                      UnderlinedInputField(labelText: "Password", isPassword: true, controller: passwordController),
                      SizedBox(
                        height: 20.h,
                      ),
                      UnderlinedInputField(labelText: "Re-enter Password", isPassword: true, controller: confirmPasswordController),
                      SizedBox(
                        height: 15.h,
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      LargeButton(
                          onPressed: (){
                            signUp(context);
                            },
                          text: "Sign Up"),
                      Expanded(child: SizedBox()),
                      RichText(
                        text: TextSpan(
                          text: 'Do you have an account?  ',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),
                          children: <TextSpan>[
                            TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(builder: (context) => Login()),
                                );
                              },
                              text: 'Login',
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
