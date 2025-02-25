import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kukbook/features/auth/controller/auth_controller.dart';
import 'package:kukbook/features/home/screens/bottombar.dart';
import 'package:kukbook/features/home/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/image_constants.dart';
import '../../../main.dart';
import '../../../models/user_model.dart';
import 'login_or_signup.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  keepLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    bool idExists = prefs.containsKey('id');
    if (id != null && idExists) {
      UserModel userModel = await ref
          .watch(authControllerProvider.notifier)
          .getUserFromId(id: id);
      Future.delayed(const Duration(seconds: 2)).then(
        (value) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ),
        ),
      );
    } else {
      Future.delayed(const Duration(seconds: 2)).then(
        (value) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginOrSignUp(),
          ),
        ),
      );
    }
  }

  void navigationFunction() async {
    await Future.delayed(const Duration(milliseconds: 100))
        .then((value) => (value) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginOrSignUp(),
                  ),
                  (route) => false);
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
