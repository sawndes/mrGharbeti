import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../screens/profile_screen.dart';
import '../authentication/fire_auth.dart';

class AppBarUI extends StatelessWidget implements PreferredSizeWidget {
  // const AppBarUI({Key? key}) : super(key: key);
  AppBarUI(this.Titletext, this.backButton);
  String Titletext;
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
          onPressed: () {
            // void closeModal() {
            //   Navigator.of(context).pop();
            // }

            // closeModal();
            Get.back();
          },
          icon: const Icon(
            LineAwesomeIcons.angle_left,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF00BF6D).withOpacity(0.9),
        // leading: Icon(
        //   Icons.menu,
        //   //For Dark Color
        //   color: isDark ? Colors.white : const Color(0xff000000),
        // ),
        title: Row(
          children: [
            Expanded(
              child: FittedBox(
                child: Text(
                  Titletext,
                  // style: TextStyle(color),
                  style: Theme.of(context).textTheme.headline2,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
          ],
        ),

        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //For Dark Color
              color: isDark
                  ? const Color(0xFF272727)
                  : Color(0xFF00BF6D).withOpacity(0.9),
            ),
            child: IconButton(
              onPressed: () {
                Get.to(() => ProfileScreen(uid: FireAuth.instance.user.uid));
                // FireAuth.instance.logout();
              },
              icon: Image(
                image: NetworkImage(FireAuth.instance.user.photoURL!),
              ),
            ),
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
        backgroundColor: Color(0xFF00BF6D).withOpacity(0.9),
        // leading: Icon(
        //   Icons.menu,
        //   //For Dark Color
        //   color: isDark ? Colors.white : const Color(0xff000000),
        // ),
        title: Text(
          Titletext,
          style: Theme.of(context).textTheme.headline2,
          overflow: TextOverflow.clip,
        ),

        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //For Dark Color
              color: isDark
                  ? const Color(0xFF272727)
                  : Color(0xFF00BF6D).withOpacity(0.9),
            ),
            child: IconButton(
              onPressed: () {
                Get.to(() => ProfileScreen(uid: FireAuth.instance.user.uid));

                // Get.to(() => const ProfileScreen());
                // FireAuth.instance.logout();
              },
              icon: Image(
                // image: AssetImage('assets/images/googlelogo.png'),
                image: NetworkImage(FireAuth.instance.user.photoURL!),
              ),
            ),
          )
        ],
      );
    }
  }
}
