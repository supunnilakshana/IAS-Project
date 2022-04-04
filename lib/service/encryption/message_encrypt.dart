import 'dart:math';
import 'package:encrypt/encrypt.dart';
import 'package:smsapp/constans/constansts.dart';

class CryptoSMS {
  var random = new Random();

  //decrypt
  String decryptText(String text) {
    if (isencrypt(text)) {
      int keycode = int.parse(text[1]);
      String keytext = _keylist[keycode];

      String filtText = text.substring(2);
      final key = Key.fromUtf8(keytext);
      final iv = IV.fromLength(16);

      final encrypter = Encrypter(AES(key));

      final decryptedText = encrypter.decrypt64(filtText, iv: iv);
      print(decryptedText);
      return decryptedText;
    } else {
      return text;
    }
  }

//encrypt
  String ecryptText(String text) {
    int keycode = random.nextInt(9);
    String keytext = _keylist[keycode];
    final key = Key.fromUtf8(keytext);
    final iv = IV.fromLength(16);
    // print(iv.base64);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(text, iv: iv);

    print(encrypted.base64);

    String encryptedText = initensymbol + keycode.toString() + encrypted.base64;

    return encryptedText;
  }

  List<String> _keylist = [
    '0yxpFFscMMaBPbmWAiWImVd8LdfQmDjg',
    'HgLeG9JSRVhA76JVzlWiATgrOVqaMCch',
    'mvdXHc8Iw67H4Hxi0sznIucFaLm51kPL',
    'z9vFXFGBgxGvR74dQ4trNe35ox3PwYBv',
    'O6Oiy8lKtPOoZLxihGQPoKezHi5w7Bcp',
    'YuzSaz6Ktxl4kt6pxRp2i9heQxf39ydC',
    'Y6I6GaM3VvUwLMIwp926966uLZRqNHLe',
    'Lrf5PIDE3s2eSLjRcj0GSgUXbJi35mMo',
    'cZjt2T6zb4LTkgJqQlcDixqDnZoRJ04D',
    'vVouCni6WC6HfoJIIGm7Y0ZAAqA4hxnu'
  ];

  bool isencrypt(String text) {
    bool isen = false;
    if (text[0] == initensymbol) {
      isen = true;
    } else {
      isen = false;
    }
    print(isen);
    return isen;
  }
}
