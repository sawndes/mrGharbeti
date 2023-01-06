import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screens/otp_screen.dart';
import './signup_controller.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.put(SignUpController());
    // SignUpController();
    // final email = TextEditingController();
    // final password = TextEditingController();
    // final fullName = TextEditingController();
    // final phoneNo = TextEditingController();
    // final _formKey = GlobalKey<FormState>();
    GlobalKey<FormState> _formKey = GlobalKey();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/login_ui.png',
          height: size.height * 0.20,
        ),
        Text(
          "Register your Account,",
          style: Theme.of(context).textTheme.headline1,
        ),
        const Text(
          "Mr Gharbeti",
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.fullName,
                  decoration: const InputDecoration(
                    label: Text('Full Name'),
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                TextFormField(
                  controller: controller.email,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                TextFormField(
                  controller: controller.phoneNo,
                  decoration: const InputDecoration(
                    label: Text('Phone Number.'),
                    prefixIcon: Icon(Icons.numbers),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                TextFormField(
                  controller: controller.password,
                  decoration: const InputDecoration(
                    label: Text('Password'),
                    prefixIcon: Icon(Icons.fingerprint),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // SignUpController.instance.registerUser(
                        //   controller.email.text.trim(),
                        //   controller.password.text.trim(),
                        // );
                        SignUpController.instance.phoneAuthentication(
                            controller.phoneNo.text.trim());
                        Get.to(() => const OTPScreen());
                      }
                    },
                    child: const Text('SIGNUP'),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Center(child: const Text('OR')),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: const Image(
                      image: AssetImage('assets/images/googlelogo.png'),
                      width: 40,
                    ),
                    onPressed: () {},
                    label: const Text('Sign-In with Google'),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text.rich(
                    TextSpan(
                      text: 'Don\'t have an Account? ',
                      style: Theme.of(context).textTheme.bodyText1,
                      children: const [
                        TextSpan(
                          text: 'Signup',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
