

import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const MyText(
      {super.key,
        required this.title,
        this.color,
        this.fontSize,
        this.fontWeight,
        this.textAlign
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
      TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
      textAlign: textAlign,
    );
  }
}
