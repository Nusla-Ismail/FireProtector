import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fireprotector/constants.dart';
import 'package:fireprotector/views/previous_fires.dart';
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
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: StyleProvider(
          style: Style(),
          child: ConvexAppBar(
            top: -15.h,
            curveSize: 60,
            controller: controller,
            backgroundColor: kPrimaryColor,
            color: Colors.white,
            items: [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.notifications_active, title: 'Updates'),
            ],
            onTap: (int){},
          ),
        ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          Home(),
          Updates(),
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