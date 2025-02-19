import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kukbook/core/constants/firebase_constants.dart';
import 'package:kukbook/core/providers/firebase_providers.dart';
import 'package:kukbook/models/user_model.dart';

import '../../../core/failure.dart';
import '../../../core/typedef.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    firestore: ref.watch(firebaseProvider),
    auth: ref.watch(authProvider),
    googleSignIn: ref.watch(googleSignInProvider)));

class AuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth auth,
      required GoogleSignIn googleSignIn})
      : _firebaseFirestore = firestore,
        _firebaseAuth = auth,
        _googleSignIn = googleSignIn;

  CollectionReference get _user =>
      _firebaseFirestore.collection(FirebaseConstants.users);

  Future<Either<dynamic, String>> sendOtpToPhone({required String phone}) async {
    print(1);
    print(phone);
    try {
      print(2);
      final Completer<String> completer = Completer();
      print(3);

      QuerySnapshot<Object?> users = await _user
          .where('phone', isEqualTo: phone)
          .where('delete', isEqualTo: false)
          .get();
      print(4);

      if (users.docs.isNotEmpty) {
        print(5);
        return left(Failure('User exists'));
      }

      print(6);
      _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print(7);
          await _firebaseAuth.signInWithCredential(credential);
          print(8);
        },
        verificationFailed: (error) {
          print(9);
          if (!completer.isCompleted) {
            completer.completeError(Failure('Verification failed: ${error.message}'));
          }
          print(10);
        },
        codeSent: (verificationId, forceResendingToken) {
          print(11);
          if (!completer.isCompleted) {
            completer.complete(verificationId);
          }
          print(12);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          print(13);
          if (!completer.isCompleted) {
            completer.completeError(Failure('Verification timed out'));
          }
          print(14);
        },
      );

      print(15);
      final verId = await completer.future.timeout(
        const Duration(seconds: 60), // Set timeout
        onTimeout: () => throw Failure('OTP request timed out'),
      );
      return right(verId);
    } on FirebaseException catch (e) {
      print(16);
      print(e.message);
      return left(Failure(e.message ?? 'Firebase error occurred'));
    } catch (e) {
      print(17);
      print(e.toString());
      return left(Failure(e.toString()));
    }
  }


  Future<Either<dynamic, UserModel>> verifyPhone({
    required String verificationId,
    required String smsCode,
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      UserModel userModel;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user == null) {
        throw 'sign in failed';
      } else {
        DocumentReference ref = _user.doc(user.uid);
        userModel = UserModel(
          name: name,
          email: email,
          phone: phone,
          address: [],
          id: user.uid,
          createdDate: DateTime.now(),
          delete: false,
          search: [name, phone, email, user.uid],
          profilePic: '',
          bio: [],
          followers: [],
          watchLater: [],
          downloads: [],
          myRecipes: [],
          reference: ref,
          password: '',
        );
      }

      return right(userModel);
    } on FirebaseException catch (e) {
      throw '${e.message}';
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      final googleUser = await googleAccount?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleUser?.accessToken, idToken: googleUser?.idToken);
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      UserModel userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        print(1);
        DocumentReference ref = _user.doc(userCredential.user?.uid);
        userModel = UserModel(
          name: userCredential.user?.displayName ?? "",
          email: userCredential.user!.email ?? "",
          phone: "",
          address: [],
          id: userCredential.user!.uid,
          createdDate: DateTime.now(),
          delete: false,
          search: [],
          profilePic: userCredential.user!.photoURL ?? "",
          bio: [],
          followers: [],
          watchLater: [],
          downloads: [],
          myRecipes: [],
          reference: ref,
          password: '',
        );
        print(2);
      await  ref.set(userModel.toJson());
        print(3); 
      } else {
        print(4);
        userModel = await getUserFromId(id: userCredential.user!.uid);
        print(5);
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      throw "${e.message}";
    } catch (e) {
      print(e.toString());
      return left(Failure(e.toString()));
    }
  }

  Future<Either<dynamic, UserModel>> createUser(
      {required UserModel userModel}) async {
    try {
      await _user.doc(userModel.id).set(userModel.toJson());
      return right(userModel);
    } on FirebaseException catch (e) {
      throw '${e.message}';
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<UserModel> getUserFromId({required String id}) async {
    return await _user.doc(id).get().then(
        (value) => UserModel.fromJson(value.data() as Map<String, dynamic>));
  }
}
