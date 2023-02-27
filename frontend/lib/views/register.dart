import 'package:fireprotector/views/login.dart';
import 'package:fireprotector/widgets/underlined_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/large_button.dart';
import '../widgets/rounded_input_field.dart';

class Register extends StatelessWidget {

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
                      UnderlinedInputField(labelText: "Name"),
                      SizedBox(
                        height: 30.h,
                      ),
                      UnderlinedInputField(labelText: "Email"),
                      SizedBox(
                        height: 30.h,
                      ),
                      UnderlinedInputField(labelText: "Email"),
                      SizedBox(
                        height: 20.h,
                      ),
                      UnderlinedInputField(labelText: "Password", isPassword: true),
                      SizedBox(
                        height: 20.h,
                      ),
                      UnderlinedInputField(labelText: "Re-enter Password", isPassword: true),
                      SizedBox(
                        height: 15.h,
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                      LargeButton(onPressed: (){}, text: "Sign Up"),
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
