import 'package:flutter/material.dart';
import 'package:smsapp/components/roundedtextFiled.dart';
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
        decoration: BoxDecoration(
          color: kbackgoundcolor,
        ),
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.04,
              ),
              child: RoundedInput(
                onchange: (text) {},
                valid: (value) {
                  return null;
                },
                save: (text) {},
                icon: Icons.search_rounded,
                hintText: "Search here... ",
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0,
                        shadowColor: kbackgoundcolor,
                        color: kbackgoundcolor,
                        child: ListTile(
                          leading: Image.asset("assets/icons/user3.png"),
                          title: Text(
                            "070 412 6017",
                            style: TextStyle(
                                fontSize: size.width * 0.05,
                                color: kdefualtfontcolor.withOpacity(0.9)),
                          ),
                          subtitle: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "This msg is erer  we",
                                  style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      color:
                                          kdefualtfontcolor.withOpacity(0.8)),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
