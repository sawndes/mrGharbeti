import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/user_model.dart';
import '../../widgets/firestore/user_firestore.dart';
import '../../screens/otp_screen.dart';
import './fire_auth.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  // var FireAuth;

  final userRepo = Get.put(UserRepository());

  void registerUser(String email, String password) {
    // print('object');
    FireAuth.instance.createUserWithEmailAndPassword(email, password);
    // final _auth = FirebaseAuth.instance;
    // final User? firebaseUser;
  }

  void phoneAuthentication(String phoneNo) {
    FireAuth.instance.phoneAuthentication(phoneNo);
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    phoneAuthentication(user.phoneNo);
    Get.to(() => const OTPScreen());
  }
}
