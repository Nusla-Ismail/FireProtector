

import 'package:fireprotector/constants.dart';
import 'package:fireprotector/widgets/tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';






class PreviousFires extends StatelessWidget {
  PreviousFires({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Previous Fires", style: Theme.of(context).textTheme.headline1),
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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('fire_cases').snapshots(),
                builder: (context,snapshot) {
                  List<Row>tiles=[];
                  if (snapshot.hasData)
                  {
                    final Clients = snapshot.data?.docs.reversed.toList(); 
                    for(var Client in Clients! )
                    {
                      final tile= Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Client['date']),
                          Text(Client['location']),
                        

                        ],
                      );
                      tiles.add(tile);

                    }
                  }

                  return Expanded(
                    child:ListView(
                      children: tiles ,
                    )
                  );
                  /*
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  List<DocumentSnapshot> fireCases = snapshot.data!.docs;

                  return Tile(
                    data: fireCases,
                  );*/
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
