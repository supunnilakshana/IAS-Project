import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smsapp/constans/constansts.dart';
import 'package:smsapp/models/msg_model.dart';
import 'package:smsapp/screens/home/home_screen.dart';
import 'package:smsapp/screens/welcome_screen/welcome_screen.dart';
import 'package:smsapp/service/database/localdb_handeler.dart';
import 'package:smsapp/service/notrification_service/notification_service.dart';
import 'package:smsapp/service/validation/date.dart';
import 'package:smsapp/test/smstest.dart';
import 'package:telephony/telephony.dart';
import 'package:vibration/vibration.dart';

backgrounMessageHandler(SmsMessage message) async {
  Vibration.vibrate(duration: 500);
  print("msg awaa");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
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
