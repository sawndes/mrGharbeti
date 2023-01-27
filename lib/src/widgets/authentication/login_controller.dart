import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/widgets/authentication/fire_auth.dart';

import '../../screens/navigation_bar.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  void loginUser(String email, String password) {
    // Get.offAll(() => NavigationPage());
    FireAuth.instance.loginWithEmailAndPassword(email, password);
  }
}
