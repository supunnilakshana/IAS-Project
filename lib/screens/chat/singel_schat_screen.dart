import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smsapp/components/roundedtextFiled.dart';
import 'package:smsapp/constans/constansts.dart';
import 'package:smsapp/models/msg_model.dart';
import 'package:smsapp/service/database/localdb_handeler.dart';
import 'package:smsapp/service/sms_service/sms_service.dart';
import 'package:smsapp/service/validation/date.dart';
import 'package:smsapp/service/validation/validate_handeler.dart';
import 'package:telephony/telephony.dart';

class SingelChatScreen extends StatefulWidget {
  final bool isnew;
  final String mobile;

  const SingelChatScreen({Key? key, this.isnew = false, this.mobile = ""})
      : super(key: key);
  @override
  _SingelChatScreenState createState() => _SingelChatScreenState();
}

class _SingelChatScreenState extends State<SingelChatScreen> {
  String sends = "f";
  String mobileNo = "";
  String message = " ";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mobileNocon = TextEditingController();
  TextEditingController messegecon = TextEditingController();
  late bool isnewchat;

  @override
  void initState() {
    isnewchat = widget.isnew;
    mobileNo = widget.mobile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            List<MsgModel> data =
                await LocalDbHandeler.getallmsgs(mobileNocon.text);
            data.forEach((element) {
              print(element.id);
            });
          },
        ),
        backgroundColor: kbackgoundcolor,
        appBar: AppBar(
          title: Text(
            isnewchat ? "New conversation" : mobileNo,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.balsamiqSans(),
          ),
          backgroundColor: kbackgoundcolor,
          elevation: 1,
          bottom: PreferredSize(
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
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                  child: Align(
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
                            await SmsService.sendSMS(
                                mobileNocon.text, messegecon.text, listener);
                            MsgModel msgModel = MsgModel(
                                mobileno: mobileNocon.text,
                                message: messegecon.text,
                                status: "sent",
                                hash: "hash",
                                msgtype: 0,
                                datetime: Date.getMsgDate());
                            await LocalDbHandeler.addnewmsg(msgModel);
                          },
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
