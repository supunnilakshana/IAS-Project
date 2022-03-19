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
}
