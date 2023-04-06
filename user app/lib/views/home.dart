import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireprotector/views/contact.dart';
import 'package:fireprotector/views/login.dart';
import 'package:fireprotector/widgets/large_button.dart';
import 'package:fireprotector/widgets/medium_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';


import '../constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  VideoPlayerController? _controller;
  bool isConfirmed = false;
  bool hasData = false;

  @override
  void initState(){
    super.initState();
    getFireCase();
    setOneSignal();
  }

  getFireCase()async{
    var sub = await _firestore.collection("fire_cases").where("user_id",isEqualTo: _auth.currentUser!.uid).orderBy("timestamp",descending: true).get();
    if(sub.docs.isEmpty){
      hasData = false;
      setState(() {});
      return;
    } else {
      var fireCase = sub.docs[0];
      isConfirmed = fireCase['isConfirmed'];
      if(fireCase['isFire']){
        hasData = true;
      }
      _controller = VideoPlayerController.network(fireCase['video_url'])
        ..initialize().then((_) {
          setState(() {});
          _controller!.play();
          _controller!.setLooping(true);
        });
      setState(() {});
    }
    
  }


  void setOneSignal() async{
    final status = await OneSignal.shared.getDeviceState();
    final String? oneSignalID = status?.userId;

    print("User ID: $oneSignalID");

    _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid).update({"notification":oneSignalID});
  }

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
              FirebaseAuth.instance.signOut();
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
          child: RefreshIndicator(
            onRefresh: () async{
              getFireCase();
            },
            child: Center(
              child: SingleChildScrollView(
                child: hasData ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.r)),
                        border: Border.all(color: isConfirmed? kGreen : kRed, width: 2),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(left: Radius.circular(4.r)),
                                color: isConfirmed? kGreen : kRed,
                              ),
                              padding: EdgeInsets.all(6.w),
                              child: Image.asset("assets/images/announcement_icon.png", width: 22.w),
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                            Flexible(
                              child: Text(
                                isConfirmed? "Fire Station is aware about the fire":"Fire Station is not aware about the fire",
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
                      child: _controller != null ?
                      AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                      ) : Center(child: CircularProgressIndicator(),
                      ),
                    ),
                    SizedBox(
                      height: 90.h,
                    ),
                    MediumButton(
                      onPressed: () => launch("tel://911"),
                      text: "Contact Emergency Team",
                      color: kBtnAsh,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    MediumButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("False Alarm"),
                              content: Text("Are you sure you want to report a false alarm? This will notify the fire station that no fire is detected."),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("Cancel"),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                  child: Text("Confirm"),
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                    Navigator.of(context).pop();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("False Alarm Reported"),
                                          content: Text("The fire station has been notified that no fire is detected."),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text("OK"),
                                              onPressed: () => Navigator.of(context).pop(),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      text: "False Alarm",
                      color: kRed,
                    ),

                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ) : Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Column(
                        children: [
                          Text("No fire case Reported", style: TextStyle(fontSize: 20.sp),),
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
