import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/screens/navigation_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../helper/sharedpref_helper.dart';
import '../../models/user_model.dart';
import '../../screens/dashboard.dart';
import '../../screens/home_screen.dart';
import '../../screens/otp_screen.dart';
import '../firestore/user_firestore.dart';
import './exceptions/signup_email_password_failure.dart';
import 'database_methods.dart';

class FireAuth extends GetxController {
  static FireAuth get instance => Get.find();
  final userRepo = Get.put(UserRepository());

  // Variables
  final _auth = FirebaseAuth.instance;
  Rx<User?>? firebaseUser;
  var verificationId = ''.obs;
  User get user => firebaseUser!.value!;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser!.bindStream(_auth.userChanges());
    ever(firebaseUser!, _setInitialScreen);
    // super.onReady();
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const HomeScreen())
        : Get.offAll(() => NavigationPage(
            // user: user,
            ));
  }

  signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);

    UserCredential result = await _auth.signInWithCredential(credential);

    User? userDetails = result.user;

    if (result != null) {
      SharedPreferenceHelper().saveUserEmail(userDetails?.email);
      SharedPreferenceHelper().saveUserId(userDetails?.uid);
      SharedPreferenceHelper().saveUserName(userDetails?.uid);
      SharedPreferenceHelper().saveDisplayName(userDetails?.displayName);
      SharedPreferenceHelper().saveUserProfileUrl(userDetails?.photoURL);

      Map<String, dynamic> userInfoMap = {
        "email": userDetails!.email,
        "username": userDetails.uid,
        "name": userDetails.displayName,
        "imgUrl": userDetails.photoURL
      };

      DatabaseMethods()
          .addUserInfoToDB(userDetails.uid, userInfoMap)
          .then((value) {
        Get.offAll(() => NavigationPage());
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => NavigationPage()));
      });
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, UserModel user) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(firebaseUser!.value);
      createUser(user);
      firebaseUser!.value != null
          ? Get.offAll(() => NavigationPage())
          : Get.to(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION-${ex.message}');
      Get.snackbar('Error', 'FIREBASE AUTH EXCEPTION-${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('FIREBASE AUTH EXCEPTION-${ex.message}');
      Get.snackbar('Error', 'FIREBASE AUTH EXCEPTION-${ex.message}');
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(firebaseUser!.value!.uid);
      print('asdasdasd');
      firebaseUser!.value != null
          ? Get.offAll(() => NavigationPage())
          : Get.to(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  void phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credentials) async {
        await _auth.signInWithCredential(credentials);
      },
      // verificationCompleted: (phoneAuthCredential) {
      //   Get.snackbar('Completed', 'Login');
      //   Get.offAll(() => const HomeScreen());
      // },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided number is not valid');
        } else {
          Get.snackbar('Error', 'Something went wrong!! Try again!');
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: this.verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  void check(String otp) async {
    var isVerified = await FireAuth.instance.verifyOTP(otp);
    isVerified ? Get.off(NavigationPage()) : Get.back();
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    // phoneAuthentication(user.phoneNo);
    // Get.to(() => const OTPScreen());
  }

  Future<void> logout() async {
    // await GoogleSignIn().disconnect();
    await _auth.signOut();
  }
}
