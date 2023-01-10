import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/screens/navigation_bar.dart';

import '../../screens/dashboard.dart';
import '../../screens/home_screen.dart';
import './exceptions/signup_email_password_failure.dart';

class FireAuth extends GetxController {
  static FireAuth get instance => Get.find();

  // Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
    // super.onReady();
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const HomeScreen())
        : Get.offAll(() => NavigationPage(
            // user: user,
            ));
  }

  void phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credentials) async {
        await _auth.signInWithCredential(credentials);
      },
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

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      firebaseUser.value != null
          ? Get.offAll(() => NavigationPage())
          : Get.to(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION-${ex.message}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('FIREBASE AUTH EXCEPTION-${ex.message}');
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  Future<void> logout() async => await _auth.signOut();

  // // For registering a new user
  // static Future<User?> registerUsingEmailPassword({
  //   required String name,
  //   required String email,
  //   required String password,
  // }) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;

  //   try {
  //     UserCredential userCredential = await auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     user = userCredential.user;
  //     await user!.updateProfile(displayName: name);
  //     await user.reload();
  //     user = auth.currentUser;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }

  //   return user;
  // }

  // // For signing in an user (have already registered)
  // static Future<User?> signInUsingEmailPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;

  //   try {
  //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     user = userCredential.user;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided.');
  //     }
  //   }

  //   return user;
  // }

  // static Future<User?> refreshUser(User user) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;

  //   await user.reload();
  //   User? refreshedUser = auth.currentUser;

  //   return refreshedUser;
  // }
}
