import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kukbook/core/common/widgets/custom_text_button.dart';
import 'package:kukbook/core/common/widgets/custom_text_widget.dart';
import 'package:kukbook/features/auth/screens/splash_screen_2.dart';
import 'package:kukbook/models/user_model.dart';
import 'package:kukbook/theme/palette.dart';
import '../../../core/common/widgets/custom_text_input.dart';
import '../../../core/constants/image_constants.dart';
import '../../../main.dart';
import 'login_page.dart';

class CreatePasswordPage extends StatefulWidget {
  final UserModel userModel;
  const CreatePasswordPage({super.key, required this.userModel});

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: w * 0.05),
          child: SingleChildScrollView(
            child: SizedBox(
              height: w * 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
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
                              width: w * 0.6,
                              // height: w*0.7,
                            ),
                          ),
                          Positioned(
                            bottom: w * 0.15,
                            child: SizedBox(
                              // color: Colors.blue,
                              width: w * 0.165,
                              height: w * 0.115,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    right: 5,
                                    child: CircleAvatar(
                                      radius: w * 0.05,
                                      backgroundColor: Palette.primaryColor
                                          .withOpacity(0.65),
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 7,
                                    child: CustomTextWidget(
                                      text: "Hi",
                                      weight: FontWeight.w700,
                                      fontSizeMultiplier: 0.07,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: w * 0.08,
                            child: const CustomTextWidget(
                              text: "Create a strong password be to seccured",
                              fontSizeMultiplier: 0.037,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(right: w * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: w * 0.03,
                          ),
                          CustomTextInput(
                            hintText: "create password",
                            hintTextColor: const Color(0xffc5c5c5),
                            controller: passwordController,
                            hintSize: 0.036,
                            prefix: Padding(
                              padding: EdgeInsets.only(right: w * 0.09),
                              child: SvgPicture.asset(
                                Images.unlockGrey,
                                width: w * 0.005,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: w * 0.03,
                          ),
                          CustomTextInput(
                            hintText: "re enter password",
                            hintTextColor: const Color(0xffc5c5c5),
                            controller: passwordController,
                            hintSize: 0.036,
                            prefix: Padding(
                              padding: EdgeInsets.only(right: w * 0.09),
                              child: SvgPicture.asset(
                                Images.lockGrey,
                                width: w * 0.005,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: w * 0.15,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: w * 0.05),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: w * 0.05,
                                ),
                                CustomTextButton(
                                    text: "Sign In",
                                    onPressed: () {
                                      if(passwordController.text.trim()==confirmPasswordController.text.trim()){

                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text("password doesn't match" )));
                                      }

                                    }),
                                SizedBox(
                                  height: w * 0.04,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CustomTextWidget(
                                      text: "Already have an account?",
                                      color: Palette.primaryColor,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Login",
                                        style: GoogleFonts.montserrat(
                                          color: Palette.primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: w * 0.036,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Palette.primaryColor,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
