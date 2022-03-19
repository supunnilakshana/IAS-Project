import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: IntrinsicHeight(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Text(
                    "sdddddddddsdsdsdsdjkjskdjkskdkssssssssdddddddqaowkqo qowqow qowkq oqowqwoqwoqwq"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
