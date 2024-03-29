import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mr_gharbeti/src/controller/bottom_navigation_controller.dart';
import 'package:mr_gharbeti/src/screens/add_listings.dart';
import 'package:mr_gharbeti/src/screens/bookmark_listings.dart';
import 'package:mr_gharbeti/src/screens/chat.dart';
import 'package:mr_gharbeti/src/screens/dashboard.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../controller/all_listings_bookmark_controller.dart';

class NavigationPage extends StatelessWidget {
  // NavigationPage({super.key});
  BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());
  AllListingsBookmarkController allListingsBookmarkController = Get.find();

  NavigationPage({Key? key}) : super(key: key);

  final screens = [
    // DashBoard(uid: FireAuth.instance.user.uid),
    DashBoard(),
    ChatPage(),
    AddListingsPage(),
    BookmarkListings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: bottomNavigationController.selectedIndex.value,
          children: screens,
        ),
      ),
      bottomNavigationBar: Obx(
        () => GNav(
          backgroundColor: Colors.white,
          iconSize: 22,
          gap: 30,
          color: Colors.grey.shade500,
          rippleColor: Colors.black,
          haptic: true,
          tabBorderRadius: 20,
          textSize: 5,

          activeColor: Colors.black,
          tabBackgroundColor: Colors.grey.shade500,
          selectedIndex: bottomNavigationController.selectedIndex.value,
          // tabBackgroundColor:
          //     Colors.purple.withOpacity(0.1), // selected tab background color
          onTabChange: (index) {
            // print('object');
            // allListingsBookmarkController.updateAll();
            bottomNavigationController.changeIndex(index);
          },
          tabs: const [
            GButton(
              icon: LineIcons.home,
              // text: 'Home',
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            GButton(
              icon: LineIcons.sms,
              // text: 'Chat',
            ),
            GButton(
              icon: LineIcons.plus,
              // text: 'Add Listings',
            ),
            GButton(
              icon: LineIcons.bookmark,
              // text: 'Favorites',
            )
          ],
        ),
      ),
    );
  }
}
