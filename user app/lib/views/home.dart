import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireprotector/views/contact.dart';
import 'package:fireprotector/views/login.dart';
import 'package:fireprotector/widgets/large_button.dart';
import 'package:fireprotector/widgets/medium_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


import '../constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
/*
  @override
  void initState(){
    super.initState();

    setOneSignal();
  }

  void setOneSignal() async{
    final status = await OneSignal.shared.getDeviceState();
    final String? oneSignalID = status?.userId;

    print("User ID: $oneSignalID");

    _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid).update({"notification":oneSignalID});
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Home",
            style: Theme.of(context).textTheme.headline1
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.contact_support_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => Login()),
              );
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/main_back.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  border: Border.all(color: kRed, width: 2),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(4.r)),
                          color: kRed,
                        ),
                        padding: EdgeInsets.all(6.w),
                        child: Image.asset("assets/images/announcement_icon.png", width: 22.w),
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Flexible(
                        child: Text(
                          "Fire Station is not aware about the fire",
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16.sp),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.amber,
                child: Center(
                    child: Text(
                      "Live Video",
                      style: Theme.of(context).textTheme.button,
                    ),
                ),
              ),
              Expanded(child: SizedBox()),
              MediumButton(
                onPressed: () => launch("tel://911"),
                text: "Contact Emergency Team",
                color: kBtnAsh,
              ),
              SizedBox(
                height: 20.h,
              ),
              MediumButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("False Alarm"),
                        content: Text("Are you sure you want to report a false alarm? This will notify the fire station that no fire is detected."),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          TextButton(
                            child: Text("Confirm"),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("False Alarm Reported"),
                                    content: Text("The fire station has been notified that no fire is detected."),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () => Navigator.of(context).pop(),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                text: "False Alarm",
                color: kRed,
              ),

              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
