import 'package:fireprotector_emergency_team/confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'constants.dart';
import 'home.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  OneSignal.shared.setAppId(dotenv.env["ONESIGNAL"]!);
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                headline2: GoogleFonts.outfit(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  color: kBtnAsh,
                ),
                button: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                headline3: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: kBtnAsh,
                ),
                headline4: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: kLabelColor,
                ),
                headline5: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  color: kBtnAsh,
                ),
                labelMedium: GoogleFonts.outfit(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: kBtnAsh,
                ),
                bodyText1: GoogleFonts.outfit(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                //todo : Don't remove
                subtitle1: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                subtitle2: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),

            home: Home(),
          );
        });
  }
}