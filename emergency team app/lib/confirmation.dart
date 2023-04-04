import 'package:fireprotector_emergency_team/main.dart';
import 'package:fireprotector_emergency_team/updates.dart';
import 'package:fireprotector_emergency_team/widgets/medium_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';

class Confirmation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Confirmation",
            style: Theme.of(context).textTheme.headline1
        ),
        centerTitle: true,
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
                onPressed: (){
                  Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => Updates()));
                },
                text: "Confirm Fire",
                color: kGreen,
              ),
              SizedBox(
                height: 20.h,
              ),
              MediumButton(
                onPressed: (){
                  Navigator.pop(context);
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