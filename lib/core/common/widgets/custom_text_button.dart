import 'package:flutter/material.dart';
import 'package:kukbook/core/common/widgets/custom_text_widget.dart';
import 'package:kukbook/theme/palette.dart';

import '../../../main.dart';

class CustomTextButton extends StatefulWidget {
  final String text;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final Function onPressed;

  const CustomTextButton(
      {super.key,
      required this.text,
      this.color = Palette.primaryColor,
      this.borderColor = Palette.primaryColor,
      required this.onPressed,
      this.textColor = Palette.whiteColor});

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: w*0.02),
      child: SizedBox(
        width: w,
        height: w*0.12,
        child: ElevatedButton(
          onPressed: () {
            widget.onPressed();
          },

          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(w*0.1),
              side: BorderSide(
                color: widget.borderColor
              )
            ),
            backgroundColor: widget.color,
                    elevation: 0,
            side: BorderSide(
              color: widget.borderColor
            )
          ),
          child: CustomTextWidget(
            text: widget.text,
            color: widget.textColor,
            fontSizeMultiplier: 0.045,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
