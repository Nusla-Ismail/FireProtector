import 'package:fireprotector/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedInputField extends StatelessWidget {

  final String labelText;
  final bool isPassword;
  final TextEditingController controller;

  const RoundedInputField({super.key, required this.labelText, this.isPassword=false, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.start,
      textInputAction: TextInputAction.done,
      obscureText: isPassword ? true : false,
      enableSuggestions: isPassword ? false : true,
      style:Theme.of(context).textTheme.headline4,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.visibility, color: Color(0xffB6B8C2),) : null,
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.headline4,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide(color: kAsh, width: 1)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide(color: kAsh, width: 1)),
        ),
      );
  }
}
