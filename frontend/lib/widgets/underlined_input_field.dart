import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class UnderlinedInputField extends StatelessWidget {

  final bool isPassword;
  final String labelText;

  const UnderlinedInputField({super.key, this.isPassword = false, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.bottom,
      textAlign: TextAlign.start,
      textInputAction: TextInputAction.done,
      obscureText: isPassword ? true : false,
      enableSuggestions: isPassword ? false : true,
      style:Theme.of(context).textTheme.headline4,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.visibility, color: Color(0xffB6B8C2)) : null,
        hintText: labelText,
        hintStyle: Theme.of(context).textTheme.headline4,
        isDense: true,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: kAsh, width: 1)
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kAsh, width: 1)
        ),
      ),
    );
  }
}
