import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smsapp/constans/constansts.dart';
import 'package:smsapp/screens/home/home_screen.dart';
import 'package:smsapp/screens/welcome_screen/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure SMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kprimaryColor,
        backgroundColor: kbackgoundcolor,
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.balsamiqSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}
