import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kukbook/core/common/widgets/custom_text_button.dart';
import 'package:kukbook/core/common/widgets/custom_text_widget.dart';
import 'package:kukbook/features/auth/controller/auth_controller.dart';
import 'package:kukbook/features/auth/screens/login_page.dart';
import 'package:kukbook/features/auth/screens/sign_up.dart';
import '../../../main.dart';
import '../../../theme/palette.dart';

class LoginOrSignUp extends StatefulWidget {
  const LoginOrSignUp({super.key});

  @override
  State<LoginOrSignUp> createState() => _LoginOrSignUpState();
}

class _LoginOrSignUpState extends State<LoginOrSignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: w,
          color: Palette.whiteColor,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding:  EdgeInsets.all(w*0.07),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "KUKBUK",
                    style: GoogleFonts.readexPro(
                      fontWeight: FontWeight.w700,
                      fontSize: w * 0.08,
                      height:2,
                      color:Palette.primaryColor// Adjust fontSize as needed
                    ),
                  ),
                  SizedBox(
                    width: w*0.7,
                    child: const CustomTextWidget(
                      text: "Book of authentic recipes from best cookes",
                      weight: FontWeight.w500,
                      fontSizeMultiplier: 0.036,
                      // Adjust fontSizeMultiplier as needed
                    ),
                  ),
                  SizedBox(height: w*0.05,),
                  CustomTextButton(text: "Log in", onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),),);
                  }),
                  const Center(child: CustomTextWidget(text: "Or",weight: FontWeight.w500,)),
                  // SizedBox(height: w*0.05,),
                  CustomTextButton(text: "Sign up", onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage(),),);

                  },textColor: Palette.primaryColor,
                  borderColor: Palette.primaryColor,color: Palette.whiteColor,),
                  const Center(child: CustomTextWidget(text: "Or",weight: FontWeight.w500,)),
                  // SizedBox(height: w*0.05,),
                  Consumer(
                    builder: (context,ref,child) {
                      return CustomTextButton(text: "Sign up with Google", onPressed: (){
                        ref.watch(authControllerProvider.notifier).googleSignIn(context: context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage(),),);

                      },textColor: Palette.primaryColor,
                      borderColor: Palette.primaryColor,color: Palette.whiteColor,);
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
