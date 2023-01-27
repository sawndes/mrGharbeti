import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mr_gharbeti/src/widgets/firestore/user_firestore.dart';
import '../controller/profile_controller.dart';
import '../widgets/authentication/fire_auth.dart';
import '../widgets/dashboard_widgets/appBar_ui.dart';
import '../widgets/dashboard_widgets/banner_ui.dart';
import '../widgets/dashboard_widgets/searchBar_ui.dart';
import '../widgets/dashboard_widgets/top_listings_ui.dart';

class DashBoard extends StatefulWidget {
  String uid;
  DashBoard({Key? key, required this.uid}) : super(key: key);
  static final user_data = UserRepository.instance.tryUpdateUI();

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  // final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    // profileController.updateUserId(widget.uid);
  }

  // getInfos() async {
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final _db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBarUI('Mr. Gharbeti', false),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Dashboard',
                style: textTheme.bodyText2,
              ),
              Text(
                'Explore Listings',
                style: textTheme.headline2,
              ),
              const SizedBox(
                height: 20,
              ),
              //Search Bar
              DashboardSearchbarUI(textTheme: textTheme),
              const SizedBox(
                height: 20,
              ),
              // DashBoardCategories(
              //   textTheme: textTheme,
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              //Banner
              DashboardBannerUI(textTheme: textTheme),
              const SizedBox(
                height: 10,
              ),
              DashboardTopListings(textTheme: textTheme),
            ],
          ),
        ),
      ),
    );
  }
}
