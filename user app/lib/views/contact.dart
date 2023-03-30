import 'package:fireprotector/constants.dart';
import 'package:fireprotector/widgets/medium_button.dart';
import 'package:fireprotector/widgets/small_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15.h),
                    Text("Contact Us",
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            ?.copyWith(color: kAsh)),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                        "If you have any problems or if you need any help, please contact us on following ways!",
                        style: Theme.of(context).textTheme.headline5),
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
                                Image.asset("assets/images/phone.png",
                                    width: 40.w),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Expanded(
                                    child: SmallButton(
                                      onTap: () => launch("tel://0777777777"),
                                        text: "Make a phone call",
                                        color: kBtnAsh)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.h,
                          horizontal: 20.w,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Find Us",
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
                                Image.asset(
                                  "assets/images/location.png",
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Expanded(
                                  child: SmallButton(
                                    onTap: () async {
                                      // Launch maps application with company's address
                                      final Uri params = Uri(
                                        scheme: 'https',
                                        host: 'www.google.com',
                                        path: '/maps/search/',
                                        query: 'query=123 Main St, Anytown, USA',
                                      );
                                      final String url = params.toString();
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    text: "Get Directions",
                                    color: kBtnAsh,
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
