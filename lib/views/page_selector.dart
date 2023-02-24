import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fireprotector/constants.dart';
import 'package:fireprotector/views/updates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/rounded_input_field.dart';
import 'home.dart';

class PageSelector extends StatefulWidget{
  const PageSelector({Key? key}) : super(key: key);

  @override
  State<PageSelector> createState() => _HomeState();
}

class _HomeState extends State<PageSelector> with SingleTickerProviderStateMixin{
  late TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: StyleProvider(
          style: Style(),
          child: ConvexAppBar(
            top: -15.h,
            controller: controller,
            backgroundColor: kPrimaryColor,
            color: Colors.white,
            items: [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.notifications_active, title: 'Updates'),
              TabItem(icon: Icons.history, title: 'Previous Fires'),
            ],
            onTap: (int){},
          ),
        ),
      body: TabBarView(
        controller: controller,
        children: [
          Home(),
          Updates(),
          Container(
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
                            padding: EdgeInsets.all(7.w),
                            child: Image.asset("assets/images/announcement_icon.png", width: 25.w),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Flexible(
                            child: Text(
                              "Fire Station is not aware about the fire",
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18.sp),
                              maxLines: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 30;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 22;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(fontSize: 12, color: color);
  }
}