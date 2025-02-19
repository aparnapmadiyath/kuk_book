import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kukbook/core/common/widgets/custom_text_button.dart';
import 'package:kukbook/core/common/widgets/custom_text_widget.dart';
import 'package:kukbook/features/auth/controller/auth_controller.dart';
import 'package:kukbook/theme/palette.dart';
import 'package:pinput/pinput.dart';
import '../../../core/constants/image_constants.dart';
import '../../../main.dart';

class SignUpOtpPage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String verId;

  const SignUpOtpPage(
      {super.key,
      required this.name,
      required this.email,
      required this.phone,
      required this.verId});

  @override
  State<SignUpOtpPage> createState() => _SignUpOtpPageState();
}

class _SignUpOtpPageState extends State<SignUpOtpPage> {
  final otpController = TextEditingController();

  verifyOtp(
      {required WidgetRef ref,
      required String smsCode}) async {
    if (widget.verId.isNotEmpty) {
      await ref.watch(authControllerProvider.notifier).verifyPhone(
            verificationId: widget.verId,
            smsCode: smsCode,
            name: widget.name,
            email: widget.email,
            phone: widget.phone,
            context: context,
          );
    } else {
      print('something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: w * 0.05),
          child: SingleChildScrollView(
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
                            text: "Enter your OTP number send to ******86",
                            fontSizeMultiplier: 0.037,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: w * 0.04),
                        child: const CustomTextWidget(
                          text: "Enter OTP",
                          fontSizeMultiplier: 0.046,
                          weight: FontWeight.w600,
                        ),
                      ),
                      Center(
                        child: Pinput(
                          separatorBuilder: (index) {
                            return SizedBox(
                              width: w * 0.05,
                            );
                          },
                          controller: otpController,
                          closeKeyboardWhenCompleted: true,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          obscureText: true,
                          disabledPinTheme: PinTheme(
                            width: w * 0.01,
                            height: w * 0.01,
                            decoration:
                                const BoxDecoration(color: Color(0xffFFF0E5)),
                          ),
                          focusedPinTheme: PinTheme(
                            textStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: w * 0.05,
                                color: const Color(0xff464646)),
                            width: w * 0.115,
                            height: w * 0.13,
                            decoration: BoxDecoration(
                                color: const Color(0xffFFF0E5),
                                borderRadius: BorderRadius.circular(w * 0.03),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Palette.primaryColor,
                                    offset: Offset(0, 0.6),
                                    // spreadRadius: 0.05,
                                    // blurRadius: 0.2
                                  )
                                ]),
                          ),
                          defaultPinTheme: PinTheme(
                            textStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: w * 0.05,
                                color: const Color(0xff464646)),
                            width: w * 0.115,
                            height: w * 0.13,
                            decoration: BoxDecoration(
                              color: const Color(0xffFFF0E5),
                              borderRadius: BorderRadius.circular(w * 0.03),
                              // boxShadow: const [
                              //   BoxShadow(
                              //     color: Palette.primaryColor,
                              //     offset: Offset(0, 0.6),
                              //     // spreadRadius: 0.05,
                              //     // blurRadius: 0.2
                              //   )
                              // ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: w * 0.05),
                        child: CustomTextWidget(
                          text: "Resend OTP?",
                          color: Palette.primaryColor.withOpacity(0.78),
                          weight: FontWeight.w600,
                          fontSizeMultiplier: 0.036,
                        ),
                      ),
                      Text(
                        "Re enter number",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff090909).withOpacity(0.53),
                            fontSize: w * 0.033,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                const Color(0xff090909).withOpacity(0.53),
                            decorationThickness: 1.5),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: w * 0.05, bottom: w * 0.05),
                  child: Column(
                    children: [
                      SizedBox(
                        height: w * 0.05,
                      ),
                      Consumer(
                        builder: (context,ref,child) {
                          return CustomTextButton(
                              text: "Next",
                              onPressed: () {
                                verifyOtp(ref: ref, smsCode: otpController.text.trim());
                              });
                        }
                      ),
                      SizedBox(
                        height: w * 0.1,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const CustomTextWidget(
                      //       text: "Already have an account?",
                      //       color: Palette.primaryColor,
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         Navigator.pushReplacement(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => const LoginPage(),
                      //           ),
                      //         );
                      //       },
                      //       child: Text(
                      //         "Login",
                      //         style: GoogleFonts.montserrat(
                      //           color: Palette.primaryColor,
                      //           fontWeight: FontWeight.w600,
                      //           fontSize: w * 0.036,
                      //           decoration: TextDecoration.underline,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
