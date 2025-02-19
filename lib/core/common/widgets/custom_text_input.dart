import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kukbook/theme/palette.dart';

import '../../../main.dart';

class CustomTextInput extends StatefulWidget {
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final TextEditingController controller;
  final Function? onChanged;
  final Function? onTap;
  final Widget? prefix;
  final Widget? suffix;
  final String? hintText;
  final String? labelText;
  final double? hintSize;
  final double? textSize;
  final FontWeight? hintWeight;
  final FontWeight? textWeight;
  final Color? hintTextColor;
  final Color? textColor;

  const CustomTextInput({
    super.key,
    this.focusedBorderColor = Palette.primaryColor,
    this.enabledBorderColor = Palette.greyColor,
    required this.controller,
    this.onChanged,
    this.onTap,
    this.prefix,
    this.suffix,
    this.hintText,
    this.labelText,
    this.hintSize=0.036,
    this.hintWeight=FontWeight.w500,
    this.hintTextColor=Palette.greyColor,
    this.textColor=Palette.blackColor,
    this.textSize=0.038,
    this.textWeight=FontWeight.w600,
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w,
      child: TextFormField(
        style: GoogleFonts.montserrat(
          fontSize: w*widget.textSize,
          fontWeight: widget.textWeight,
          color: widget.textColor,
        ),
        controller: widget.controller,
        onTap: () {
          // widget.onTap!();
        },
        onChanged: (value) {
          // widget.onChanged();
        },
        cursorColor: Palette.greyColor,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.montserrat(
            fontSize: w*widget.hintSize,
            fontWeight: widget.hintWeight,
            color: widget.hintTextColor,
          ),
          labelText: widget.labelText,
          prefixIcon: widget.prefix,
          suffixIcon: widget.suffix,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: widget.focusedBorderColor)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: widget.enabledBorderColor)),
        ),
      ),
    );
  }
}
