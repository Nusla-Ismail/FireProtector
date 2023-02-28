import 'package:fireprotector/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviousFires extends StatelessWidget {
  const PreviousFires({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Previous Fires",
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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 35.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(10.r)),
                ),
                elevation: 3,
                margin: EdgeInsets.only(bottom: 16.h),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "2020-02-10",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: kBtnAsh,
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(10.r)),
                          ),
                          child: SizedBox(
                            width: 40.w,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 30.w,
                            ),
                          ),
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
    );
  }
}
