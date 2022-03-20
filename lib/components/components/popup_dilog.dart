import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:smsapp/constans/constansts.dart';

class PopupDialog {
  static showPopupDilog(BuildContext context, Function actionFun) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: "Complete profile",
      desc: "Please complete your profile and get more shopping experience",
      btnCancelText: "Not now",
      btnOkText: "Complete now",
      btnCancelOnPress: () {},
      btnOkOnPress: actionFun,
    )..show();
  }

  static showPopupdelete(
      BuildContext context, String titel, Function actionFun) {
    AwesomeDialog(
        body: Text(
          titel,
          style: TextStyle(color: kdefualtfontcolor),
        ),
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        btnCancelText: "No",
        btnOkText: "Yes",
        btnOkColor: Colors.redAccent,
        btnCancelColor: Colors.blueGrey,
        btnCancelOnPress: () {},
        btnOkOnPress: actionFun,
        dialogBackgroundColor: kprimarylightcolor.withOpacity(0.1))
      ..show();
  }

  static showPopupErorr(
    BuildContext context,
    String titel,
    String description,
  ) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: titel,
      desc: description,
      btnOkText: "Ok",
      btnCancel: null,
      btnOkOnPress: () {},
    )..show();
  }
}

























/*static Future<void> showMyDialog(BuildContext context, String titel,
      String description, Function actionFun) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titel),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes , did'),
              onPressed: () {
                /// actionFun();
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.INFO,
                  animType: AnimType.LEFTSLIDE,
                  title: 'Dialog Title',
                  desc: 'Dialog description here.............',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                )..show();
              },
            ),
            TextButton(
              child: const Text('Not yet'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } */