import 'dart:math';
import 'package:smsapp/models/chat_model.dart';
import 'package:smsapp/models/msg_model.dart';
import 'package:smsapp/service/database/localdb_handeler.dart';
import 'package:smsapp/service/notrification_service/notification_service.dart';
import 'package:smsapp/service/validation/date.dart';
import 'package:telephony/telephony.dart';

class SmsService {
  static final Telephony telephony = Telephony.instance;

  static sendSMS(String mobileNo, String messageContext,
      SmsSendStatusListener listener) async {
    try {
      await telephony.sendSms(
          to: mobileNo, message: messageContext, statusListener: listener);
    } on Exception catch (e) {
      print(e);
    }
  }

  static listnSMS(SmsMessage message) async {
    String adress = message.address!;
    String mobileNo = adress.replaceAll('+94', '0');

    NotificationService.shownotication(
        Date.getTimeId(), mobileNo, message.body!);
    print(message.body);
    print(message.address);
    print(mobileNo + "-----------------------------------");

    Random random = new Random();
    int res = await LocalDbHandeler.checkchatstaus(mobileNo);
    print("-------------------------------" + res.toString());
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
          newmsgcount: 1,
          imgurl: imgurl,
          lastmessage: message.body);
      int chatres = await LocalDbHandeler.createnewchat(chatModel);
      if (chatres == 0) {
        print("chat is created");
      }
    } else {
      ChatModel? chatModel = await LocalDbHandeler.getsingelchat(mobileNo);
      chatModel!.newmsgcount = 1;
      chatModel.lastmessage = message.body;
      int chatres = await LocalDbHandeler.updatechat(chatModel);

      if (chatres == 0) {
        print("chat is updated");
      }
    }

    MsgModel msgModel = MsgModel(
        mobileno: mobileNo,
        message: message.body!, // messegecon.text,
        status: "recived",
        hash: "hash",
        msgtype: 1,
        datetime: Date.getMsgDate());
    await LocalDbHandeler.addnewmsg(msgModel);
  }
}
