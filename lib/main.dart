import 'package:fireprotector/constants.dart';
import 'package:fireprotector/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(color: kPrimaryColor),
              primaryColor: kPrimaryColor,
              textTheme: TextTheme(
                headline1: GoogleFonts.outfit(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                headline2: GoogleFonts.outfit(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffF6F6F7),
                ),
                button: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                headline3: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                headline4: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffB6B8C2),
                ),
                bodyText1: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                bodyText2: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                subtitle1: GoogleFonts.outfit(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                subtitle2: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: kLabelColor,
                ),
              ),
            ),
            home: Login()
          );
        });
  }
}

