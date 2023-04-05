import 'package:fireprotector_emergency_team/confirmation.dart';
import 'package:fireprotector_emergency_team/constants.dart';
import 'package:fireprotector_emergency_team/updates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fireprotector_emergency_team/contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  late int caseID;
  late String date;
  late String time;
  late String location;

   Future<List<QueryDocumentSnapshot>> getData() async {
    QuerySnapshot querySnapshot = await _db.collection("fire_cases").where('isFire', isEqualTo: true).get();
    print("called");
    print("snapshot: "+querySnapshot.docs.length.toString());
    return querySnapshot.docs;
  }

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
          padding: EdgeInsets.fromLTRB(10.w, 30.h, 10.w, 0),
          child: RefreshIndicator(
            onRefresh: () async {
              await getData();
              setState(() {});
            },
            child:
            FutureBuilder<List<QueryDocumentSnapshot>>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No data to show!', style: TextStyle(fontSize: 20.sp));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: GestureDetector(
                        onTap: (){
                          if (snapshot.data![i]["isConfirmed"] == true){
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => Updates(caseID: snapshot.data![i]["case_id"])),
                            );
                          }
                          else{
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => Confirmation(videoURL: snapshot.data![i]["video_url"], caseID: snapshot.data![i]['case_id'])),
                            );
                          }
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
                                                    snapshot.data![i]['case_id'].toString(),
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
                                                    snapshot.data![i]['date'],
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
                                                    snapshot.data![i]['time'],
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
                                                    snapshot!.data![i]['location'],
                                                    style: Theme.of(context).textTheme.bodyText1
                                                ),
                                              ),
                                            ]
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
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

  }
}
