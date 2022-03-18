import 'package:flutter/material.dart';
import 'package:smsapp/constans/constansts.dart';
import 'package:smsapp/screens/chat/singel_schat_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kbackgoundcolor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SingelChatScreen()));
        },
        label: Text("Start chat"),
        icon: Icon(Icons.chat),
        backgroundColor: kprimaryColor,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
                child: Card(
              child: ListTile(),
            ))
          ],
        ),
      ),
    );
  }
}
