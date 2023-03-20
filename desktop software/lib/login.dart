import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindrate/signup.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email');
      } else if (e.code == 'wrong-password') {
        print('Incorrect Password');
      } else if (e.code == 'invalid-email') {
        print('Email is invalid');
      }
    }

    Navigator.pop(context);
  }

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
                  mainAxisSize: MainAxisSize.max,
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
                            "Login with",
                            style: GoogleFonts.ubuntu(
                                color: Color(0xffDBDBE1),
                                fontSize: 30,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Email",
                            style: GoogleFonts.poppins(
                                color: Color(0xffB6B8C2),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                              controller: emailController,
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
                            height: 30,
                          ),
                          Text(
                            "Password",
                            style: GoogleFonts.poppins(
                                color: Color(0xffB6B8C2),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                              controller: passwordController,
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
                            height: 15,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (value) async {},
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Remember me",
                                style: GoogleFonts.poppins(
                                    color: Color(0xffB6B8C2),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Text(
                                      "Forgot Password?",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xff00C0FF),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              signIn(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffAAA3E9)),
                            child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (_) => SignUp()))
                              },
                              child: RichText(
                                text: TextSpan(
                                    text: 'Don\'t have an account?  ',
                                    style: GoogleFonts.outfit(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Signup',
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
