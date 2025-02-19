import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kukbook/features/auth/repository/auth_repository.dart';
import 'package:kukbook/features/home/screens/bottombar.dart';
import 'package:kukbook/models/user_model.dart';

import '../screens/create_password.dart';
import '../screens/sign_up_otp.dart';
import '../screens/splash_screen_2.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authRepository: ref.watch(authRepositoryProvider), ref: ref));

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false);

  void googleSignIn({required BuildContext context}) async {
    final res = await _authRepository.signInWithGoogle();
    res.fold((l) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l.message)));
    }, (r) {
      if (r != null) {
        if (context.mounted) {
          _ref.read(userProvider.notifier).update((state) => r);
          print(r);
          print('------------------------');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavBar(),
            ),
            (route) => false,
          );
        }
      }
    });
  }

  Future<String> sendOtpToPhone({
    required String phone,
    required String name,
    required String email,
    required BuildContext context,
  }) async {
    String verID = '';
    final res = await _authRepository.sendOtpToPhone(phone: phone);
    res.fold((l) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l.message)));
    }, (r) {
      verID = r;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpOtpPage(
            name: name,
            email: email,
            phone: phone,
            verId: r,
          ),
        ),
      );
    });
    return verID;
  }

  Future<void> verifyPhone({
    required String verificationId,
    required String smsCode,
    required String name,
    required String email,
    required String phone,
    required BuildContext context,
  }) async {
    final res = await _authRepository.verifyPhone(
        verificationId: verificationId,
        smsCode: smsCode,
        name: name,
        email: email,
        phone: phone);
    res.fold((l) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l.message)));
    }, (r) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CreatePasswordPage(
            userModel: r,
          ),
        ),
      );
    });
  }

  void createUser(
      {required UserModel userModel, required BuildContext context}) async {
    final res = await _authRepository.createUser(userModel: userModel);
    res.fold((l) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('user created successfully')));
    }, (r) {
      _ref.read(userProvider.notifier).update((state) => r);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen2(),
        ),
      );
    });
  }
}
