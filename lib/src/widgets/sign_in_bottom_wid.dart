import 'package:flutter/material.dart';
import 'package:mr_gharbeti/src/widgets/auth_sign_in_btn_widget.dart';
import 'package:mr_gharbeti/src/widgets/authentication/fire_auth.dart';

import '../screens/forgot_password_mail.dart';
import 'Forgot_pw_widgets/forgot_pw_btn_widget.dart';

// import '../../screens/login_screen.dart';

class SignInBottomWidget {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Make Selection',
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              style: Theme.of(context).textTheme.bodyText1,
              'Select one of the options given below to sign in or sign up',
            ),
            const SizedBox(
              height: 10,
            ),
            SignInAllButtons(
              btnIcon: Icons.mail_outline_rounded,
              title: 'Google',
              subtitle: 'Login/Sign Up with Google',
              onTap: () {
                // print('dsasd');
                FireAuth().signInWithGoogle();
                // Navigator.of(context).pop();
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => ForgotPasswordMailScreen()));
              },
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            // SignInAllButtons(
            //   btnIcon: Icons.facebook,
            //   title: 'Facebook',
            //   subtitle: 'Login/Sign Up with Facebook',
            //   onTap: () {},
            // ),
          ],
        ),
      ),
    );
  }
}
