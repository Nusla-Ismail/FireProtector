import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindrate/login.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/login_back.png"),
          fit: BoxFit.fill,
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(
              color: Colors.white,
            ),
            SizedBox(
              width: 600,
            ),
            Expanded(
              child: Container(
                color: Color(0xff2E4450),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Center(child: Image.asset("assets/logo.png", width: 300)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Signup with",
                            style: GoogleFonts.ubuntu(
                                color: Color(0xffDBDBE1),
                                fontSize: 30,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA4A6B3),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.person_outline,
                                      color: Color(0xffA4A6B3)),
                                ),
                                hintText: "Enter your Name",
                                hintStyle: GoogleFonts.poppins(
                                    color: Color(0xffA4A6B3),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff00C0FF), width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff696D77)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA4A6B3),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.email_outlined,
                                      color: Color(0xffA4A6B3)),
                                ),
                                hintText: "Enter your Email",
                                hintStyle: GoogleFonts.poppins(
                                    color: Color(0xffA4A6B3),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff00C0FF), width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff696D77)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA4A6B3),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              obscureText: true,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.visibility_outlined,
                                      color: Color(0xffA4A6B3)),
                                ),
                                hintText: "Enter your Password",
                                hintStyle: GoogleFonts.poppins(
                                    color: Color(0xffA4A6B3),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff00C0FF), width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff696D77)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA4A6B3),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              obscureText: true,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.visibility_outlined,
                                      color: Color(0xffA4A6B3)),
                                ),
                                hintText: "Re-enter Password",
                                hintStyle: GoogleFonts.poppins(
                                    color: Color(0xffA4A6B3),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff00C0FF), width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff696D77)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )),
                          SizedBox(
                            height: 80,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffAAA3E9)),
                            child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Signup",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => Navigator.push(context,
                                  CupertinoPageRoute(builder: (_) => Login())),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Do you have an account?  ',
                                    style: GoogleFonts.outfit(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Login',
                                        style: GoogleFonts.outfit(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff00C0FF),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
