import 'package:flutter/material.dart';
import 'package:smsapp/components/roundedtextFiled.dart';
import 'package:smsapp/constans/constansts.dart';
import 'package:smsapp/service/validation/validate_handeler.dart';

class SingelChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kbackgoundcolor,
      appBar: AppBar(
        title: Text("New conversation"),
        backgroundColor: kbackgoundcolor,
        elevation: 0,
      ),
      body: Form(
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.05, right: size.width * 0.05),
                child: Row(
                  children: [
                    Container(
                      width: size.width * 0.15,
                      child: Text(
                        "To  ",
                        style: TextStyle(
                            color: kdefualtfontcolor.withOpacity(0.75),
                            fontWeight: FontWeight.w400,
                            fontSize: size.width * 0.056),
                      ),
                    ),
                    Container(
                      width: size.width * 0.75,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            color: kdefualtfontcolor.withOpacity(0.89),
                            fontWeight: FontWeight.w400,
                            fontSize: size.width * 0.056),
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: kdefualtfontcolor.withOpacity(0.7),
                                fontWeight: FontWeight.w400,
                                fontSize: size.width * 0.05),
                            border: InputBorder.none,
                            hintText: "Enter mobile number"),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      RoundedInput(
                          icon: Icons.chat_rounded,
                          onchange: (text) {},
                          valid: (text) {
                            return null;
                          },
                          save: (text) {}),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.02,
                            bottom: size.height * 0.0283),
                        child: IconButton(
                          color: Colors.lightBlueAccent.shade700,
                          icon: Icon(
                            Icons.send_rounded,
                            size: size.width * 0.12,
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
