import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../main.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSizeMultiplier;
  final Color color;
  final FontWeight weight;
  final double height;

  const CustomTextWidget(
      {super.key,
      required this.text,
      this.fontSizeMultiplier = 0.033,
      this.color = Colors.black,
      this.weight = FontWeight.w500,
      this.height = 0});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
          color: color,
          fontSize: w * fontSizeMultiplier,
          fontWeight: weight,
          height: w * height),
    );
  }
}
