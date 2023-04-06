import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireprotector_emergency_team/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_stepper/stepper.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../constants.dart';
import '../widgets/medium_button.dart';
import 'contact.dart';

class Updates extends StatefulWidget {
  final int caseID;

  const Updates({super.key, required this.caseID});

  @override
  State<Updates> createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  int activeStep = 0;
  final int upperBound = 5;
  String uid = "";
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getActivity();
  }

  getActivity()async{
    DocumentSnapshot<Map<String, dynamic>> ref = await _db.collection("fire_cases").doc(widget.caseID.toString()).get();
    activeStep = ref.data()!["activity"];
    uid = ref.data()!["user_id"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => Home()),
                (Route<dynamic> route) => false);
        return false;
      },
      child: Scaffold(

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
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => Contact()),
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
                                    Icon(Icons.flag, color: Colors.white,),
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
                                    height: 63.h,
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
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  SizedBox(
                                    height: 58.h,
                                  ),
                                  Text(
                                    "Emergency Team Arrived",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  SizedBox(
                                    height: 63.h,
                                  ),
                                  Text(
                                    "Start to Extinguishing the Fire",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  SizedBox(
                                    height: 68.h,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                    child: Marquee(
                                      text: "Emergency Team put out the Fire",
                                      style: Theme.of(context).textTheme.titleMedium,
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
                if(activeStep!=5)
                MediumButton(
                  onPressed: () async {

                      setState(() {
                        activeStep++;
                      });
                      if(activeStep!=5){
                        await FirebaseFirestore.instance
                            .collection("fire_cases")
                            .doc(widget.caseID.toString())
                            .update({
                          'activity': activeStep,
                        });
                      } else {
                        await FirebaseFirestore.instance
                            .collection("fire_cases")
                            .doc(widget.caseID.toString())
                            .update({
                          'isFire': false,
                        });

                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(uid)
                            .update({
                          'isFire': false,
                        });

                        var user_ref = await FirebaseFirestore.instance.collection("users").doc(uid).get();
                        var playerID = user_ref.data()!["notification"];

                        await OneSignal.shared.postNotification(
                          OSCreateNotification(
                            playerIds: [playerID],
                            content: "The fire has been put out",
                            heading: "Fire Alert",
                          ),
                        );
                      }

                  },
                  text: activeStep == 1 ? "Team Dispatched" : activeStep == 2 ? "Team Arrived" : activeStep == 3 ? 'Started to Extinguishing the Fire' : "Completed",
                  color: kGreen,
                ),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}

