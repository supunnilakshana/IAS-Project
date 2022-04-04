import 'package:flutter/material.dart';
import 'package:smsapp/service/encryption/message_encrypt.dart';

class Test1 extends StatefulWidget {
  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            CryptoSMS cryptoSMS = CryptoSMS();
            String msg = 'heolow';
            String encrypt = cryptoSMS.ecryptText(msg);
            String dencrypt = cryptoSMS.decryptText(encrypt);
            print(encrypt + '----------');
            print(dencrypt + '++++++++++++++');
          },
          child: Icon(Icons.account_balance_sharp),
        ),
        appBar: AppBar(title: Text('Encryption')),
        body: Container());
  }
}
