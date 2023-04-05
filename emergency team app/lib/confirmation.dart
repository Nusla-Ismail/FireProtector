import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireprotector_emergency_team/home.dart';
import 'package:fireprotector_emergency_team/updates.dart';
import 'package:fireprotector_emergency_team/widgets/medium_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fireprotector_emergency_team/constants.dart';
import 'package:video_player/video_player.dart';

class Confirmation extends StatefulWidget {
  final String videoURL;
  final int caseID;

  const Confirmation({super.key, required this.videoURL, required this.caseID});

  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  late VideoPlayerController _controller;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        widget.videoURL)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
    print("Video URL: "+widget.videoURL);
    print("Case ID: "+widget.caseID.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Confirmation",
            style: Theme.of(context).textTheme.displayLarge
        ),
        centerTitle: true,
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
                height: 300,
                width: double.infinity,
                color: Colors.amber,
                child: _controller.value.isInitialized ?
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ) : Center(child: CircularProgressIndicator(),
                ),
              ),
              Expanded(child: SizedBox()),
              MediumButton(
                onPressed: (){
                  final ref = _db.collection("fire_cases").doc(widget.caseID.toString());
                  ref.update({"isConfirmed":true, "activity" : 1});
                  Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => Updates(caseID: widget.caseID)));
                },
                text: "Confirm Fire",
                color: kGreen,
              ),
              SizedBox(
                height: 20.h,
              ),
              MediumButton(
                onPressed: (){
                  final ref = _db.collection("fire_cases").doc(widget.caseID.toString());
                  ref.update({"isFire":false});
                  Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(builder: (context) => Home()),
                          (Route<dynamic> route) => false);
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

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}