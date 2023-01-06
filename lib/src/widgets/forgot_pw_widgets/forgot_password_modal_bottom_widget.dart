import 'package:flutter/material.dart';
import '../../screens/forgot_password_mail.dart';
// import '../../screens/login_screen.dart';
import './forgot_pw_btn_widget.dart';

class ForgotPasswordModal {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Make Selection',
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              style: Theme.of(context).textTheme.bodyText2,
              'Select one of the options given below to reset your password.',
            ),
            const SizedBox(
              height: 30,
            ),
            ForgotPasswordBtnWidget(
              btnIcon: Icons.mail_outline_rounded,
              title: 'Email',
              subtitle: 'Reset via Email verification',
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForgotPasswordMailScreen()));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ForgotPasswordBtnWidget(
              btnIcon: Icons.mobile_friendly_rounded,
              title: 'Phone No.',
              subtitle: 'Reset via Phone verification',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
