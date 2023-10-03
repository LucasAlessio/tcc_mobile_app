import 'package:flutter/material.dart';

class Spacer extends StatelessWidget {
  final double? height;

  const Spacer({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height ?? 24);
  }
}
