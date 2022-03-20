import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smsapp/components/roundedtextFiled.dart';
import 'package:smsapp/constans/constansts.dart';
import 'package:smsapp/models/chat_model.dart';
import 'package:smsapp/screens/chat/singel_schat_screen.dart';
import 'package:smsapp/service/database/localdb_handeler.dart';
import 'package:smsapp/service/notrification_service/notification_service.dart';
import 'package:smsapp/service/sms_service/sms_service.dart';
import 'package:smsapp/service/validation/date.dart';
import 'package:telephony/telephony.dart';

onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called");

  SmsService.listnSMS(message);
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ChatModel>> futureData;
  final telephony = Telephony.instance;
  String _message = "";
  @override
  void initState() {
    loaddata();
    initPlatformState();
    super.initState();
  }

  onMessage(SmsMessage message) async {
    await SmsService.listnSMS(message);
    loaddata();
    setState(() {});
  }

  onSendStatus(SendStatus status) {
    setState(() {
      _message = status == SendStatus.SENT ? "sent" : "delivered";
    });
  }

  Future<void> initPlatformState() async {
    final bool? result = await telephony.requestPhoneAndSmsPermissions;

    if (result != null && result) {
      telephony.listenIncomingSms(
          onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage);
    }
    loaddata();
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kbackgoundcolor,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SingelChatScreen()))
                .then((val) => val ? loaddata() : null);
          },
          label: Text(
            "Start chat",
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.w700),
          ),
          icon: Icon(
            Icons.chat,
            color: Colors.black.withOpacity(0.7),
          ),
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
                  child: FutureBuilder(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ChatModel> data = snapshot.data as List<ChatModel>;
                    print(data.length);

                    if (data.isNotEmpty) {
                      return ListView.builder(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            String imgurl = "assets/icons/user3.png";
                            if (data[index].imgurl == null ||
                                data[index].imgurl == "") {
                              imgurl = "assets/icons/user3.png";
                            } else {
                              imgurl = data[index].imgurl!;
                            }
                            String subtitel = "your message";
                            bool isread = true;

                            if (data[index].newmsgcount == 0) {
                              isread = true;
                            } else {
                              isread = false;
                            }
                            print(data[index].newmsgcount);
                            return GestureDetector(
                              onTap: () async {
                                ChatModel chatModel = data[index];
                                chatModel.newmsgcount = 0;
                                await LocalDbHandeler.updatechat(chatModel);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingelChatScreen(
                                              isnew: false,
                                              mobile: data[index].mobileno,
                                              chatModel: data[index],
                                            ))).then(
                                    (val) => val ? loaddata() : null);
                              },
                              child: Card(
                                elevation: 0,
                                shadowColor: kbackgoundcolor,
                                color: kbackgoundcolor,
                                child: ListTile(
                                  leading: Image.asset(imgurl),
                                  title: Text(data[index].mobileno,
                                      style: isread
                                          ? TextStyle(
                                              fontSize: size.width * 0.05,
                                              color: kdefualtfontcolor
                                                  .withOpacity(0.9))
                                          : TextStyle(
                                              fontSize: size.width * 0.05,
                                              color: kdefualtfontcolor,
                                              fontWeight: FontWeight.w600)),
                                  subtitle: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data[index].lastmessage != null
                                              ? data[index].lastmessage!
                                              : "Draft message",
                                          style: isread
                                              ? TextStyle(
                                                  fontSize: size.width * 0.04,
                                                  color: kdefualtfontcolor
                                                      .withOpacity(0.8))
                                              : TextStyle(
                                                  fontSize: size.width * 0.04,
                                                  color: kdefualtfontcolor,
                                                  fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Visibility(
                                    visible: isread == false,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: size.width * 0.04),
                                      child: Icon(
                                        Icons.circle,
                                        color: kprimaryColordark,
                                        size: size.width * 0.04,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Container(
                        width: size.width,
                        height: size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset("assets/animations/chatanimation.json",
                                width: size.width * 0.6),
                            Text(
                              "Chat with more securely. . .",
                              style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  color: kdefualtfontcolor.withOpacity(0.75)),
                            ),
                            SizedBox(
                              height: size.height * 0.15,
                            )
                          ],
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default show a loading spinner.
                  return Center(child: CircularProgressIndicator.adaptive());
                },
              ))
            ],
          ),
        ),
      ),
    );
  }

  loaddata() {
    setState(() {
      futureData = LocalDbHandeler.getallchat();
    });
  }
}
