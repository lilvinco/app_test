import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IGrooveTextSpace extends StatefulWidget {
  IGrooveTextSpace({this.multiplier = 1.00});

  // Multiplier
  double multiplier;

  @override
  _IGrooveTextSpaceState createState() => _IGrooveTextSpaceState();
}

class _IGrooveTextSpaceState extends State<IGrooveTextSpace> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 30 * widget.multiplier);
  }
}
