import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class Tile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
