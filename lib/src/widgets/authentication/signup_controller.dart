import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './fire_auth.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  // var FireAuth;

  void registerUser(String email, String password) {
    // print('object');
    FireAuth.instance.createUserWithEmailAndPassword(email, password);
    // final _auth = FirebaseAuth.instance;
    // final User? firebaseUser;
  }

  void phoneAuthentication(String phoneNo) {
    FireAuth.instance.phoneAuthentication(phoneNo);
  }
}
