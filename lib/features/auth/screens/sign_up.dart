import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kukbook/core/common/widgets/custom_text_button.dart';
import 'package:kukbook/core/common/widgets/custom_text_input.dart';
import 'package:kukbook/core/common/widgets/custom_text_widget.dart';
import 'package:kukbook/features/auth/controller/auth_controller.dart';
import 'package:kukbook/features/auth/screens/login_page.dart';
import 'package:kukbook/features/auth/screens/sign_up_otp.dart';
import 'package:kukbook/theme/palette.dart';
import '../../../core/constants/image_constants.dart';
import '../../../main.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  String verID = '';

  sendOtp({
    required WidgetRef ref,
    required String phone,
    required String name,
    required String email,
  }) async {
    verID = await ref.watch(authControllerProvider.notifier).sendOtpToPhone(
        phone: phone, context: context, name: name, email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: w * 0.05),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                                  width: w * 0.6,
                                  // height: w*0.7,
                                ),
                              ),
                              Positioned(
                                bottom: w * 0.10,
                                child: SizedBox(
                                  // color: Colors.blue,
                                  width: w * 0.411,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: CircleAvatar(
                                          radius: w * 0.055,
                                          backgroundColor:
                                              Palette.primaryColor.withOpacity(0.65),
                                        ),
                                      ),
                                      const CustomTextWidget(
                                        text: "Welcome",
                                        weight: FontWeight.w700,
                                        fontSizeMultiplier: 0.07,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: SizedBox(
                                  width: w * 0.7,
                                  child: const CustomTextWidget(
                                    text:
                                        "Enter your details to join with us for conformation",
                                    fontSizeMultiplier: 0.035,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: w*0.4,),
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
                              hintText: "Phone Number",
                              controller: phoneController,
                              prefix: Padding(
                                padding: EdgeInsets.all(w * 0.045),
                                child: SvgPicture.asset(
                                  Images.phoneGrey,
                                  width: w * 0.005,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: w * 0.03,
                            ),
                            CustomTextInput(
                              hintText: "Email",
                              controller: emailController,
                              prefix: Padding(
                                padding: EdgeInsets.all(w * 0.04),
                                child: SvgPicture.asset(
                                  Images.emailGrey,
                                  width: w * 0.005,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: w * 0.05,
                            ),
                             ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
               Consumer(builder: (context, ref, child) {
                              return Padding(
                                padding:  EdgeInsets.only(right: w * 0.05),
                                child: CustomTextButton(
                                    text: "Next",
                                    onPressed: () {
                                      sendOtp(
                                          ref: ref,
                                          phone: phoneController.text.trim(),
                                          name: nameController.text.trim(),
                                          email: emailController.text.trim());
                                    }),
                              );
                            }),
                            
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: w * 0.1),
                              child: Row(
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
                                          builder: (context) => const LoginPage(),
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
                                      ),
                                    ),
                                  ),
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
