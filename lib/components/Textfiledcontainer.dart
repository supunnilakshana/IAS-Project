import 'package:flutter/material.dart';

import '../constans/constansts.dart';

class Textfiledcontainer extends StatelessWidget {
  final Widget child;
  const Textfiledcontainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
          color: kprimarylightcolor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(28)),
      child: child,
    );
  }
}
