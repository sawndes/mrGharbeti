import 'package:get/get.dart';

import '../../screens/dashboard.dart';
import './fire_auth.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await FireAuth.instance.verifyOTP(otp);
    isVerified ? Get.off(DashBoard()) : Get.back();
  }
}
