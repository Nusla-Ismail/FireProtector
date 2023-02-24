import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fireprotector/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/rounded_input_field.dart';

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
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
            backgroundColor: kPrimaryColor,
            color: Colors.white,
            controller: controller,
            items: [
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.notifications_active, title: 'Updates'),
              TabItem(icon: Icons.history, title: 'Previous Fires'),
            ],
            onTap: (int){},
          ),
        ),
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
  double get iconSize => 25;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(fontSize: 12, color: color);
  }
}