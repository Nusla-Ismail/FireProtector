import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireprotector/views/contact.dart';
import 'package:fireprotector/widgets/large_button.dart';
import 'package:fireprotector/widgets/medium_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                onPressed: (){},
                text: "Contact Emergency Team",
                color: kBtnAsh,
              ),
              SizedBox(
                height: 20.h,
              ),
              MediumButton(
                onPressed: (){
                  FirebaseAuth.instance.signOut();
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
