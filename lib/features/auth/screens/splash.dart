import 'package:flutter/material.dart';
import '../../../core/constants/image_constants.dart';
import '../../../main.dart';
import 'login_or_signup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void navigationFunction()async{
   await Future.delayed(const Duration(milliseconds: 100)).then((value) => (value) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginOrSignUp(),), (route) => false);
    });
  }
@override
  void initState() {
  navigationFunction();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: w * 0.2, vertical: w * 0.1),
            child: Image.asset(Images.onBoarding),
          ),
        ),
      ),
    );
  }
}
