import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/models/user_model.dart';
import 'package:mr_gharbeti/src/widgets/authentication/login_controller.dart';
import 'package:mr_gharbeti/src/widgets/firestore/user_firestore.dart';
import './Forgot_pw_widgets/forgot_password_modal_bottom_widget.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.put(LoginController());
    GlobalKey<FormState> _formKey = GlobalKey();
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/login_ui.png',
              height: size.height * 0.2,
            ),
            Text(
              "Welcome Back,",
              style: Theme.of(context).textTheme.headline1,
            ),
            const Text(
              "Mr Gharbeti",
            ),
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: "E-mail",
                hintText: "E-mail",
                // border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: controller.password,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: "Password",
                hintText: "Password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.remove_red_eye_sharp),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    ForgotPasswordModal.buildShowModalBottomSheet(context);
                  },
                  child: const Text('Forgot Password?')),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    LoginController.instance.loginUser(
                      controller.email.text.trim(),
                      controller.password.text.trim(),
                    );
                  }
                },
                child: const Text("LOGIN"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('OR'),
                const SizedBox(
                  height: 10,
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
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    // UserModel user = UserModel(
                    //     fullName: 'fullName',
                    //     email: 'email',
                    //     phoneNo: 'phoneNo',
                    //     password: 'password');
                    // UserRepository.instance.tryUpdateUI(user);
                  },
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
            )
          ],
        ),
      ),
    );
  }
}
