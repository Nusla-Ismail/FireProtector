import 'package:firebase_core/firebase_core.dart';
import 'package:fireprotector/constants.dart';
import 'package:fireprotector/services/auth_service.dart';
import 'package:fireprotector/views/page_selector.dart';
import 'package:fireprotector/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'firebase_options.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                headline2: GoogleFonts.outfit(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: kHeading,
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
                bodyText1: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                bodyText2: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
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
            home: AuthService(),
          );
        });
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);

    OneSignal.shared.setAppId("d68fa529-b7ac-4e47-976a-e4101100595d");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OneSignal"),),
      body: Text("OneSignal PushNotification"),
    );
  }
}
