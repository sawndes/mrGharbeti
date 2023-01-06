import 'package:flutter/material.dart';
import '../widgets/authentication/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            // padding: const EdgeInsets.all(30),
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, right: 30, left: 30),
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}
