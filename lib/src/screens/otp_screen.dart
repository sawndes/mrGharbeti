import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/authentication/fire_auth.dart';
import '../widgets/authentication/otp_controller.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var otp;
    var repo = OTPController();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CO\nDE',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 80.0,
              ),
            ),
            Text(
              'VERIFICATION',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Enter the verification code sent at support@mrgharbeti.com',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            OtpTextField(
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code) {
                otp = code;
                FireAuth.instance.check(otp);

                // OTPController.instace.verifyOTP(otp);
              },
              // keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // OTPController.instance.verifyOTP(otp);
                  FireAuth.instance.check(otp);
                  // print(otp);
                },
                child: Text('Next'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
