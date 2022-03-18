import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smsapp/constans/constansts.dart';
import 'package:smsapp/screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure SMS',
      theme: ThemeData(
        primaryColor: kprimaryColor,
        backgroundColor: kbackgoundcolor,
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.balsamiqSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
