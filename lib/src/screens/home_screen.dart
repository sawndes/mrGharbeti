import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/Forgot_pw_widgets/forgot_password_modal_bottom_widget.dart';
import '../widgets/sign_in_bottom_wid.dart';
import './login_screen.dart';
import './signup_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode ? Color(0xFF272727) : Colors.white,
        body: Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/login_ui.png',
                  height: height * 0.6,
                ),
                Column(
                  children: [
                    Text(
                      'Mr Gharbeti',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      'Welcome',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  // height: 80,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(30),
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    // style: ButtonStyle(padding: EdgeInsets.all(10)),
                    // style: Theme.of,
                    onPressed: () {
                      SignInBottomWidget.buildShowModalBottomSheet(context);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => SignupScreen()));
                    },
                    child: const Text(
                      "Get Started",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: OutlinedButton(
                //         onPressed: () {
                //           Navigator.of(context).push(MaterialPageRoute(
                //               builder: (context) => LoginScreen()));
                //         },
                //         child: const Text("LOGIN"),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     Expanded(
                //       child: ElevatedButton(
                //         onPressed: () {
                //           Navigator.of(context).push(MaterialPageRoute(
                //               builder: (context) => SignupScreen()));
                //         },
                //         child: const Text("SIGNUP"),
                //       ),
                //     )
                //   ],
                // )
              ],
            )),
      ),
    );
  }
}
