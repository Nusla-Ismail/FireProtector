import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_stepper/stepper.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../widgets/medium_button.dart';

class Updates extends StatefulWidget {

  @override
  State<Updates> createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int activeStep = 0;
  final int upperBound = 5;
  bool hasData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFireCase();
  }

  getFireCase()async{
    var sub = await _firestore.collection("fire_cases").where("user_id",isEqualTo: _auth.currentUser!.uid).orderBy("timestamp",descending: true).get();
    if(sub.docs.isEmpty){
      hasData = false;
      setState(() {});
      return;
    } else {
      if(sub.docs[0]['isFire']){
        hasData = true;
      }
      activeStep = sub.docs[0]['activity'];
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Updates",
            style: Theme.of(context).textTheme.headline1
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.contact_support_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
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
          child: hasData ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: IconStepper(
                                alignment: Alignment.topLeft,
                                enableStepTapping: false,
                                activeStepBorderPadding: 3,
                                stepColor: kPrimaryColor.withOpacity(0.25),
                                activeStepColor: kPrimaryColor,
                                activeStepBorderColor: kPrimaryColor,
                                direction: Axis.vertical,
                                enableNextPreviousButtons: false,
                                lineLength: 30,
                                stepRadius: 22,
                                icons: [
                                  Icon(Icons.supervised_user_circle, color: Colors.white),
                                  Icon(Icons.flag, color: Colors.white),
                                  Icon(Icons.access_alarm, color: Colors.white),
                                  Icon(Icons.supervised_user_circle, color: Colors.white),
                                  Icon(Icons.flag, color: Colors.white),
                                  Icon(Icons.access_alarm, color: Colors.white),
                                ],



                                // activeStep property set to activeStep variable defined above.
                                activeStep: activeStep,

                                // This ensures step-tapping updates the activeStep.
                                onStepReached: (index) {
                                  setState(() {
                                    activeStep = index;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 22.h,
                                ),
                                Text(
                                  "Notified to Emergency Team",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                SizedBox(
                                  height: 58.h,
                                ),
                                SizedBox(
                                  height: 20.h,
                                  child: Marquee(
                                    text: "Fire Station is Aware about the Fire",
                                    style: Theme.of(context).textTheme.subtitle1,
                                    scrollAxis: Axis.horizontal,
                                    blankSpace: 50,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    startAfter: Duration(seconds: 3),
                                    pauseAfterRound: Duration(seconds: 5),
                                    showFadingOnlyWhenScrolling: true,
                                    accelerationDuration: Duration(seconds: 1),
                                    accelerationCurve: Curves.linear,
                                    decelerationDuration: Duration(milliseconds: 500),
                                    decelerationCurve: Curves.easeOut,
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                SizedBox(
                                  height: 58.h,
                                ),
                                Text(
                                  "Emergency Team Dispatched",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                SizedBox(
                                  height: 58.h,
                                ),
                                Text(
                                  "Emergency Team Arrived",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                SizedBox(
                                  height: 58.h,
                                ),
                                Text(
                                  "Start to Extinguishing the Fire",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                SizedBox(
                                  height: 65.h,
                                ),
                                SizedBox(
                                  height: 20.h,
                                  child: Marquee(
                                    text: "Emergency Team put out the Fire",
                                    style: Theme.of(context).textTheme.subtitle1,
                                    scrollAxis: Axis.horizontal,
                                    blankSpace: 50,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    startAfter: Duration(seconds: 3),
                                    pauseAfterRound: Duration(seconds: 5),
                                    showFadingOnlyWhenScrolling: true,
                                    accelerationDuration: Duration(seconds: 1),
                                    accelerationCurve: Curves.linear,
                                    decelerationDuration: Duration(milliseconds: 500),
                                    decelerationCurve: Curves.easeOut,
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              MediumButton(
                onPressed: () => launch("tel://911"),
                text: "Contact Emergency Team",
                color: kBtnAsh,
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ) : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No fire case Reported", style: TextStyle(fontSize: 20.sp),),
                ],
              )),
        ),
      ),
    );
  }
}
