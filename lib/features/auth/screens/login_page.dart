import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kukbook/core/common/widgets/custom_text_button.dart';
import 'package:kukbook/core/common/widgets/custom_text_input.dart';
import 'package:kukbook/core/common/widgets/custom_text_widget.dart';
import 'package:kukbook/features/auth/screens/sign_up.dart';
import 'package:kukbook/features/auth/screens/splash_screen_2.dart';
import 'package:kukbook/theme/palette.dart';
import '../../../core/constants/image_constants.dart';
import '../../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: w * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            Images.loginImg1,
                            width: w * 0.55,
                          )),
                      Positioned(
                        bottom: w * 0.06,
                        child: SizedBox(
                            // color: Colors.blue,
                            width: w * 0.345,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: CircleAvatar(
                                    radius: w * 0.043,
                                    backgroundColor:
                                        Palette.primaryColor.withOpacity(0.65),
                                  ),
                                ),
                                const CustomTextWidget(
                                  text: "Welcome Back!",
                                  weight: FontWeight.w700,
                                  fontSizeMultiplier: 0.06,
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                  const CustomTextWidget(
                    text: "Enter here your login details to get you",
                    fontSizeMultiplier: 0.035,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: w * 0.05, bottom: w * 0.05),
                child: Column(
                  children: [
                    CustomTextInput(
                      controller: nameController,
                      hintText: "Name",
                      prefix: Padding(
                        padding: EdgeInsets.all(w * 0.04),
                        child: SvgPicture.asset(
                          Images.userOrange,
                          width: 1,
                          height: 0.1,
                        ),
                      ),
                      suffix: Padding(
                        padding: EdgeInsets.all(w * 0.05),
                        child: SvgPicture.asset(Images.tickOrange),
                      ),
                    ),
                    SizedBox(
                      height: w * 0.03,
                    ),
                    CustomTextInput(
                      hintText: "Password",
                      controller: passwordController,
                      prefix: Padding(
                        padding: EdgeInsets.all(w * 0.04),
                        child: SvgPicture.asset(
                          Images.lockGrey,
                          width: w * 0.005,
                        ),
                      ),
                      suffix: Padding(
                        padding: EdgeInsets.all(w * 0.05),
                        child: SvgPicture.asset(Images.eyeGrey),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: w * 0.01, bottom: w * 0.05),
                        child: const CustomTextWidget(
                          text: "Forgot Password?",
                          color: Palette.primaryColor,
                        ),
                      ),
                    ),
                    CustomTextButton(
                        text: "Login",
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SplashScreen2(),
                            ),
                          );
                        }),
                    SizedBox(
                      height: w * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomTextWidget(
                          text: "Don’t have an account?",
                          color: Palette.greyColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign up",
                            style: GoogleFonts.montserrat(
                              color: Palette.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: w * 0.036,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
