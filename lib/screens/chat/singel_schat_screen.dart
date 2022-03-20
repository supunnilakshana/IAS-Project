import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:smsapp/components/roundedtextFiled.dart';
import 'package:smsapp/constans/constansts.dart';
import 'package:smsapp/models/chat_model.dart';
import 'package:smsapp/models/msg_model.dart';
import 'package:smsapp/service/database/localdb_handeler.dart';
import 'package:smsapp/service/notrification_service/notification_service.dart';
import 'package:smsapp/service/sms_service/sms_service.dart';
import 'package:smsapp/service/validation/date.dart';
import 'package:smsapp/service/validation/validate_handeler.dart';
import 'package:telephony/telephony.dart';

class SingelChatScreen extends StatefulWidget {
  final bool isnew;
  final String mobile;

  const SingelChatScreen({Key? key, this.isnew = true, this.mobile = ""})
      : super(key: key);
  @override
  _SingelChatScreenState createState() => _SingelChatScreenState();
}

class _SingelChatScreenState extends State<SingelChatScreen> {
  bool isfirsttap = true;
  String sends = "f";
  String mobileNo = "";
  String message = " ";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mobileNocon = TextEditingController();
  TextEditingController messegecon = TextEditingController();
  late bool isnewchat;
  late Future<List<MsgModel>> futureData;
  Random random = new Random();

  @override
  void initState() {
    isnewchat = widget.isnew;
    mobileNo = widget.mobile;
    setState(() {});
    late Timer _timer;
    if (!isnewchat) {
      loaddata();
      _timer = Timer.periodic(Duration(seconds: 5), (timer) => loaddata());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        print('Pressed Back button');
        Navigator.pop(context, true);
        return Future<bool>.value(false);
      },
      child: Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerTop,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                NotificationService.shownotication(
                    10000, "0763080158", "Thismsg for u");
                // List<MsgModel> data =
                //     await LocalDbHandeler.getallmsgs(mobileNocon.text);
                // data.forEach((element) {
                //   print(element.message);
                // });
              },
            ),
            backgroundColor: kbackgoundcolor,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  )),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      isnewchat ? "New conversation" : mobileNo,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.balsamiqSans(),
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    right: size.width * 0.06,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      final telephony = Telephony.instance;
                      await telephony.openDialer(mobileNo);
                    },
                    child: LineIcon.phone(
                      size: size.width * 0.07,
                      color: kdefualtfontcolor.withOpacity(0.9),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: size.width * 0.06,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: LineIcon.alternateTrash(
                      size: size.width * 0.07,
                      color: kdefualtfontcolor.withOpacity(0.9),
                    ),
                  ),
                )
              ],
              backgroundColor: kbackgoundcolor,
              elevation: 1,
              bottom: isnewchat
                  ? PreferredSize(
                      preferredSize: Size.fromHeight(size.height * 0.06),
                      child: Padding(
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
                                controller: mobileNocon,
                                validator: (value) {
                                  return Validater.genaralvalid(value!);
                                },
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                    color: kdefualtfontcolor.withOpacity(0.89),
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.width * 0.056),
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color:
                                            kdefualtfontcolor.withOpacity(0.7),
                                        fontWeight: FontWeight.w400,
                                        fontSize: size.width * 0.05),
                                    border: InputBorder.none,
                                    hintText: "Enter mobile number"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : PreferredSize(
                      child: SizedBox(
                        height: 0,
                      ),
                      preferredSize: Size.fromHeight(0)),
            ),
            body: Container(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    child: isnewchat
                        ? SizedBox(
                            height: 0,
                          )
                        : FutureBuilder(
                            future: futureData,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<MsgModel> data =
                                    snapshot.data as List<MsgModel>;
                                print(data.length);
                                return ListView.builder(
                                    keyboardDismissBehavior:
                                        ScrollViewKeyboardDismissBehavior
                                            .onDrag,
                                    itemCount: data.length,
                                    itemBuilder: (context, indext) {
                                      if (data[indext].msgtype == 0) {
                                        return Card(
                                          color: kbackgoundcolor,
                                          elevation: 0,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.1,
                                                right: size.width * 0.05),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors
                                                          .lightBlueAccent
                                                          .shade700,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      data[indext].message,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 100,
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.8),
                                                        fontSize:
                                                            size.width * 0.04,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        size.height * 0.005),
                                                Text(
                                                  data[indext].datetime,
                                                  style: TextStyle(
                                                    color: kdefualtfontcolor
                                                        .withOpacity(0.75),
                                                    fontSize:
                                                        size.width * 0.025,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Card(
                                          color: kbackgoundcolor,
                                          elevation: 0,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.05,
                                                right: size.width * 0.1),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: kprimarylightcolor
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      data[indext].message,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 100,
                                                      style: TextStyle(
                                                        color: kdefualtfontcolor
                                                            .withOpacity(0.9),
                                                        fontSize:
                                                            size.width * 0.04,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        size.height * 0.005),
                                                Text(
                                                  data[indext].datetime,
                                                  style: TextStyle(
                                                    color: kdefualtfontcolor
                                                        .withOpacity(0.75),
                                                    fontSize:
                                                        size.width * 0.025,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    });
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              // By default show a loading spinner.
                              return Center(
                                  child: CircularProgressIndicator.adaptive());
                            },
                          ),
                  )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          RoundedInputWithControll(
                              controller: messegecon,
                              icon: Icons.chat_rounded,
                              onchange: (text) {
                                message = text;
                              },
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
                              onPressed: () async {
                                SmsSendStatusListener listener =
                                    (SendStatus status) {
                                  setState(() {
                                    sends = status == SendStatus.SENT
                                        ? "send"
                                        : "error";
                                  });
                                };
                                if (_formKey.currentState!.validate()) {
                                  message = messegecon.text;
                                  if (isnewchat && isfirsttap) {
                                    mobileNo = mobileNocon.text;
                                    int res =
                                        await LocalDbHandeler.checkchatstaus(
                                            mobileNo);
                                    print("-------------------------------" +
                                        res.toString());
                                    if (res == 0) {
                                      int scno = random.nextInt(3);
                                      String imgurl;
                                      if (scno == 0) {
                                        imgurl = "assets/icons/user1.png";
                                      } else if (scno == 1) {
                                        imgurl = "assets/icons/user2.png";
                                      } else {
                                        imgurl = "assets/icons/user3.png";
                                      }
                                      ChatModel chatModel = ChatModel(
                                          mobileno: mobileNo,
                                          newmsgcount: 0,
                                          imgurl: imgurl);
                                      int chatres =
                                          await LocalDbHandeler.createnewchat(
                                              chatModel);
                                      if (chatres == 0) {
                                        print("chat is created");
                                      }
                                    }
                                    isnewchat = false;
                                  } else {
                                    mobileNo = widget.mobile;
                                  }

                                  await SmsService.sendSMS(
                                      mobileNo, messegecon.text, listener);
                                  MsgModel msgModel = MsgModel(
                                      mobileno: mobileNo,
                                      message:
                                          messegecon.text, // messegecon.text,
                                      status: "sent",
                                      hash: "hash",
                                      msgtype: 0,
                                      datetime: Date.getMsgDate());
                                  await LocalDbHandeler.addnewmsg(msgModel);
                                  messegecon.clear();
                                  loaddata();
                                  setState(() {
                                    isnewchat = false;
                                  });
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loaddata() {
    setState(() {
      futureData = LocalDbHandeler.getallmsgs(mobileNo);
    });
  }
}
