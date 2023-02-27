import 'package:fireprotector/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LargeButton extends StatelessWidget {

  final Function onPressed;
  final String text;

  const LargeButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: ()=> onPressed(),
        style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
            padding: EdgeInsets.symmetric(vertical: 12.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap
        ),
        child: Text(
          text,
          style: GoogleFonts.outfit(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
