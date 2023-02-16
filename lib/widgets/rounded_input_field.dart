import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedInputField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        isDense: true,
        labelText: "labelText",
        labelStyle: TextStyle(
          fontFamily: "SF",
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
        ),
        floatingLabelStyle: TextStyle(
          fontFamily: "SF",
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Color(0xffFAFAFA),
        // enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(6.r),
        //     borderSide: BorderSide(color: kSecondaryColor, width: 2)),
        // disabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(6.r),
        //     borderSide: BorderSide(color: kSecondaryColor, width: 2)),
        // focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(6.r),
        //     borderSide: BorderSide(color: kSecondaryColor, width: 2)),
      ),
    );
  }
}
