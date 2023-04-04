import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_stepper/stepper.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../widgets/medium_button.dart';
import 'contact.dart';

class Updates extends StatefulWidget {

  @override
  State<Updates> createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  int activeStep = 0;

  final int upperBound = 5;

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
                                  Icon(Icons.flag),
                                  Icon(Icons.access_alarm, color: kPrimaryColor),
                                  Icon(Icons.supervised_user_circle, color: kPrimaryColor),
                                  Icon(Icons.flag, color: kPrimaryColor),
                                  Icon(Icons.access_alarm, color: kPrimaryColor),
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
                                  height: 15.h,
                                ),
                                Text(
                                  "Notified to Emergency Team",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  "18:00",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                SizedBox(
                                  height: 48.h,
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
                                Padding(
                                  padding: EdgeInsets.only(left: 1.w),
                                  child: Text(
                                    "18:00",
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                                SizedBox(
                                  height: 43.h,
                                ),
                                Text(
                                  "Emergency Team Dispatched",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  "18:00",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                SizedBox(
                                  height: 42.h,
                                ),
                                Text(
                                  "Emergency Team Arrived",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  "18:00",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                SizedBox(
                                  height: 45.h,
                                ),
                                Text(
                                  "Start to Extinguishing the Fire",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  "18:00",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                SizedBox(
                                  height: 43.h,
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
                                Padding(
                                  padding: EdgeInsets.only(left: 1.w),
                                  child: Text(
                                    "18:00",
                                    style: Theme.of(context).textTheme.subtitle2,
                                  ),
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
                onPressed: (){

                },
                text: "Team Dispatched",
                color: kGreen,
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

