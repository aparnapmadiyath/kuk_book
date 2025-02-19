import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kukbook/core/constants/image_constants.dart';
import '../../../main.dart';
import '../../../theme/palette.dart';
import '../../home/screens/diet1.dart';

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Diet1(),),);
      },
      child: Scaffold(
        body: Padding(
          padding:  EdgeInsets.all(w*0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Images.chef),
              SizedBox(height: w*0.15,),
              Text(
                "KUKBUK",
                style: GoogleFonts.readexPro(
                    fontWeight: FontWeight.w700,
                    fontSize: w * 0.08,
                    height: 2,
                    color: Palette.primaryColor // Adjust fontSize as needed
                    ),
              ),
              Text(
                "Now you can cook your dish as  you wish within minutes  ",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: w * 0.036,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400),
                // Adjust fontSizeMultiplier as needed
              ),
            ],
          ),
        ),
      ),
    );
  }
}
