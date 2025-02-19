import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kukbook/core/common/widgets/custom_text_button.dart';
import 'package:kukbook/core/common/widgets/custom_text_widget.dart';
import 'package:kukbook/features/home/screens/bottombar.dart';
import 'package:kukbook/theme/palette.dart';

import '../../../core/constants/image_constants.dart';
import '../../../main.dart';
import 'grid_return_container.dart';

class Diet2 extends StatefulWidget {
  const Diet2({super.key});

  @override
  State<Diet2> createState() => _Diet2State();
}

class _Diet2State extends State<Diet2> {
  List<Map> gridElements = [
    {"image": Images.getInspired, "text": "Get Inspired"},
    {"image": Images.eatHealthy, "text": "Eat Healthy"},
    {"image": Images.piggy, "text": "Budget Friendly"},
    {"image": Images.plan, "text": "Plan Better"},
    {"image": Images.learn, "text": "Learn to Cook"},
    {"image": Images.quick, "text": "Quick & Easy"},
    {"image": Images.minute, "text": "One minute"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.whiteColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(vertical: w*0.07),
              child: SizedBox(
                height: w*0.2,
                child:  DashedCircularProgressBar.aspectRatio(
                  aspectRatio: 1,
                  progress: 34,
                  startAngle: 0,
                  sweepAngle: 360,
                  circleCenterAlignment: Alignment.center,
                  foregroundColor: Palette.primaryColor,
                  backgroundColor: const Color(0xffe8e8e8),
                  foregroundStrokeWidth: w*0.025,
                  backgroundStrokeWidth: w*0.025,
                  backgroundGapSize: 2,
                  backgroundDashSize: 1,
                  seekColor: Colors.yellow,
                  seekSize: 0,
                  animation: true,
                  child: const Center(child: CustomTextWidget(text: "You",color: Color(0xff858585),)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: w * 0.03),
              child: const CustomTextWidget(
                text: "Any allergies or diets?",
                color: Color(0xff121212),
                fontSizeMultiplier: 0.05,
                weight: FontWeight.w700,
              ),
            ),
            const CustomTextWidget(
              text: "We’ll show you recipes for your health",
              color: Palette.blackColor,
              fontSizeMultiplier: 0.033,
            ),
            SizedBox(height: w*0.05,),

            Container(
              width: w,
              color: const Color(0xffFFF7F2),
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical:w*0.03,horizontal: w*0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: w*0.03,
                      backgroundColor: Palette.primaryColor,
                      child: const CustomTextWidget(text: "1",color: Palette.whiteColor,),

                    ),
                    const CustomTextWidget(text: "Diets",fontSizeMultiplier: 0.036,),
                    SvgPicture.asset(Images.arrowDownOrange)
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all( w * 0.05),
                itemCount: 3,
                // gridElements.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: w * 0.05,
                    mainAxisSpacing: w * 0.07,
                    childAspectRatio: 0.95,
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return GridContainer(
                    elements: gridElements[index],
                  );
                },
              ),
            ),

            Container(
              width: w,
              color: const Color(0xffFFF7F2),
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical:w*0.03,horizontal: w*0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: w*0.03,
                      backgroundColor: Palette.primaryColor,
                      child: const CustomTextWidget(text: "1",color: Palette.whiteColor,),

                    ),
                    const CustomTextWidget(text: "Diets",fontSizeMultiplier: 0.036,),
                    SvgPicture.asset(Images.arrowDownOrange)
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all( w * 0.05),
                itemCount: 3,
                // gridElements.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: w * 0.05,
                    mainAxisSpacing: w * 0.07,
                    childAspectRatio: 0.95,
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return GridContainer(
                    elements: gridElements[index],
                  );
                },
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: w*0.05),
              child: CustomTextButton(text: "Set Up", onPressed: () {
                Navigator.push(context,CupertinoPageRoute(builder: (context) => BottomNavBar(),));
              }),
            ),
            Text(
              "Skip",
              style: GoogleFonts.montserrat(
                  fontSize: w * 0.04,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff121212).withOpacity(0.78)),
            ),
            SizedBox(height: w*0.03,)
          ],
        ),
      ),
    );
  }
}
