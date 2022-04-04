import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smsapp/constans/constansts.dart';
import 'package:smsapp/screens/home/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  initScreen(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("Starting..");
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: kbackgoundcolor),
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.35),
          Image.asset(
            "assets/icons/welcomeicon.png",
            width: size.width * 0.6,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.05),
                child: Text(
                  "Secure SMS Service ",
                  style: GoogleFonts.balsamiqSans(
                      fontWeight: FontWeight.w500,
                      fontSize: size.width * 0.04,
                      color: kdefualtfontcolor.withOpacity(0.8)),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
