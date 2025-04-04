import 'package:flutter/material.dart';

class MyIcon extends StatefulWidget {
  final String remarkAssign;

  MyIcon({required this.remarkAssign});

  @override
  _MyIconState createState() => _MyIconState();
}

class _MyIconState extends State<MyIcon> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.check_circle,
      color: (widget.remarkAssign != "") ? Colors.green : Colors.red,
      size: 28.0,
    );
  }
}
