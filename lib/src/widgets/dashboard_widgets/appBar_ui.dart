import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../screens/profile_screen.dart';
import '../authentication/fire_auth.dart';

class AppBarUI extends StatelessWidget implements PreferredSizeWidget {
  // const AppBarUI({Key? key}) : super(key: key);
  AppBarUI(this.backButton);
  bool backButton;

  @override
  Size get preferredSize => const Size.fromHeight(55);
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;
    if (backButton == true) {
      return AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            LineAwesomeIcons.angle_left,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        // leading: Icon(
        //   Icons.menu,
        //   //For Dark Color
        //   color: isDark ? Colors.white : const Color(0xff000000),
        // ),
        title:
            Text('Mr. Gharbeti', style: Theme.of(context).textTheme.headline2),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //For Dark Color
              color: isDark ? const Color(0xFF272727) : const Color(0xFFF7F6F1),
            ),
            child: IconButton(
                onPressed: () {
                  Get.to(() => const ProfileScreen());
                  // FireAuth.instance.logout();
                },
                icon: const Image(
                    image: AssetImage('assets/images/googlelogo.png'))),
          )
        ],
      );
    } else {
      return AppBar(
        // leading: IconButton(
        //   onPressed: () => Get.back(),
        //   icon: const Icon(
        //     LineAwesomeIcons.angle_left,
        //     color: Colors.black,
        //   ),
        // ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        // leading: Icon(
        //   Icons.menu,
        //   //For Dark Color
        //   color: isDark ? Colors.white : const Color(0xff000000),
        // ),
        title:
            Text('Mr. Gharbeti', style: Theme.of(context).textTheme.headline2),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //For Dark Color
              color: isDark ? const Color(0xFF272727) : const Color(0xFFF7F6F1),
            ),
            child: IconButton(
                onPressed: () {
                  Get.to(() => const ProfileScreen());
                  // FireAuth.instance.logout();
                },
                icon: const Image(
                    image: AssetImage('assets/images/googlelogo.png'))),
          )
        ],
      );
    }
  }
}
