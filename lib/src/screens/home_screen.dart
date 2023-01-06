import 'package:flutter/material.dart';
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
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        },
                        child: const Text("LOGIN"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                        },
                        child: const Text("SIGNUP"),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
