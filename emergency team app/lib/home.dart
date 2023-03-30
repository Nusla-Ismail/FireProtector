import 'package:fireprotector_emergency_team/confirmation.dart';
import 'package:fireprotector_emergency_team/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'contact.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Fire Cases",
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
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 10.w),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => Confirmation()),
                  );
                },
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(15.r)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          //Hospital
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.black,
                                  width: 5.w,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.assignment_late_outlined, color: kBtnAsh, size: 18.w),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 70.w,
                                        child: Text(
                                            'Case ID',
                                            style: Theme.of(context).textTheme.labelMedium
                                        ),
                                      ),
                                      Text(
                                        ":",
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.w),
                                        child: Text(
                                            "000123123123",
                                            style: Theme.of(context).textTheme.bodyText1
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.today, color: kBtnAsh, size: 18.w),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 70.w,
                                        child: Text(
                                            'Date',
                                            style: Theme.of(context).textTheme.labelMedium
                                        ),
                                      ),
                                      Text(
                                        ":",
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.w),
                                        child: Text(
                                            "2023/03/09",
                                            style: Theme.of(context).textTheme.bodyText1
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.schedule, color: kBtnAsh, size: 18.w),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 70.w,
                                        child: Text(
                                            'Time',
                                            style: Theme.of(context).textTheme.labelMedium
                                        ),
                                      ),
                                      Text(
                                        ":",
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.w),
                                        child: Text(
                                            "09:00",
                                            style: Theme.of(context).textTheme.bodyText1
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, color: kBtnAsh, size: 18.w),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 70.w,
                                        child: Text(
                                            'Location',
                                            style: Theme.of(context).textTheme.labelMedium
                                        ),
                                      ),
                                      Text(
                                        ":",
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.w),
                                        child: Text(
                                            "92/2 Main Street,Colombo",
                                            style: Theme.of(context).textTheme.bodyText1
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.horizontal(right: Radius.circular(10.r)),
                                    color: kBtnAsh,
                                  ),
                                  width: 30.w,
                                  child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
