import 'package:fireprotector/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/rounded_input_field.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xff212121),
            image: DecorationImage(
              image: AssetImage("assets/back_design.png"),
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
                  child: Image.asset("assets/logo.png"),
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
                RoundedInputField(labelText: "Email Address"),
                SizedBox(
                  height: 20.h,
                ),
                RoundedInputField(labelText: "Password", isPassword: true),
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
                Button(onPressed: (){}, text: "Login"),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
