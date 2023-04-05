import 'package:fireprotector_emergency_team/widgets/small_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: EdgeInsets.fromLTRB(15.w, 0.h, 15.w, 26.h),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(22.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15.h),
                      Text("Contact Us",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline1
                              ?.copyWith(color: kAsh)),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                          "If you have any problems or if you need any help, please contact us on following ways!",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5),
                      SizedBox(height: 30.h),
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 20.w),
                          child: Column(
                            children: [
                              Text(
                                "Contact us through an email for further clarification about your problem. We will reply to you as soon as possible",
                                style: TextStyle(
                                  fontFamily: 'Google',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                  color: kBtnAsh,
                                ),
                              ),
                              SizedBox(height: 30.h),
                              Row(
                                children: [
                                  Image.asset("assets/images/email.png",
                                      width: 40.w),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Expanded(
                                    child: SmallButton(
                                        text: "Send an email",
                                        color: kBtnAsh,
                                         onTap: () async {
                                          final Uri params = Uri(
                                            scheme: 'mailto',
                                            path: 'tonyfergusonofficiall@gmail.com',
                                          );
                                          final String url = params.toString();
                                          try {
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            }
                                          } catch (e) {
                                            print('Error launching URL: $e');
                                          }
                                        },

                                    ),
                                ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 20.w),
                          child: Column(
                            children: [
                              Text(
                                "Make a phone call for solve your issue soon. Phone line available at following hours",
                                style: TextStyle(
                                  fontFamily: 'Google',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                  color: kBtnAsh,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Text(
                                "Mon - Fri : 8.30 a.m to 5.00 p.m",
                                style: TextStyle(
                                  fontFamily: 'Google',
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w800,
                                  height: 1.4,
                                  color: kBtnAsh,
                                ),
                              ),
                              SizedBox(height: 30.h),
                              Row(
                                children: [
                                  Image.asset("assets/images/map.png",
                                      width: 40.w),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: ()async  {
                                        final String googleMapsUrl = 'geo:<37.7749>,<-122.4194>';
                                        try{
                                          if (await canLaunch(googleMapsUrl)){
                                            await launch(googleMapsUrl);
                                          }else{
                                            throw 'Could not launch Google Maps URL';
                                          }
                                        }catch(e){
                                          print('Error launching Google Maps URL: $e');
                                        }
                                      },
                                      child: SmallButton(
                                          text: "Find us on map",
                                          color: kBtnAsh),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 20.w),
                          child: Column(
                            children: [
                              Text(
                                "For more details and updates follow us on social media. We post regularly on the following platforms",
                                style: TextStyle(
                                  fontFamily: 'Google',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 1.4,
                                  color: kBtnAsh,
                                ),
                              ),
                              SizedBox(height: 30.h),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                      GestureDetector(
                                        onTap: () async {
                                          final String facebookUrl = 'https://www.facebook.com/';
                                          try {
                                            if (await canLaunch(facebookUrl)) {
                                              await launch(facebookUrl);
                                            } else {
                                              throw 'Could not launch Facebook URL';
                                            }
                                          } catch (e) {
                                            print('Error launching Facebook URL: $e');
                                          }
                                        },
                                        child: Image.asset(
                                          "assets/images/facebook.png",
                                          width: 40.w,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final String instagramUrl = 'https://www.instagram.com/';
                                          try {
                                            if (await canLaunch(instagramUrl)) {
                                              await launch(instagramUrl);
                                            } else {
                                              throw 'Could not launch Instagram URL';
                                            }
                                          } catch (e) {
                                            print('Error launching Instagram URL: $e');
                                          }
                                        },
                                        child: Image.asset(
                                          "assets/images/instagram.png",
                                          width: 40.w,
                                        ),
                                      ),
                                      GestureDetector(
                                            onTap: () async {
                                              final String twitterUrl = 'https://www.twitter.com/';
                                              try {
                                                if (await canLaunch(twitterUrl)) {
                                                  await launch(twitterUrl);
                                                } else {
                                                  throw 'Could not launch Twitter URL';
                                                }
                                              } catch (e) {
                                                print('Error launching Twitter URL: $e');
                                              }
                                            },
                                            child: Image.asset(
                                              "assets/images/twitter.png",
                                              width: 40.w,
                                            ),
                                          ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}