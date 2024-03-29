import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mr_gharbeti/src/helper/sharedpref_helper.dart';
import 'package:mr_gharbeti/src/screens/FAQ.dart';
import 'package:mr_gharbeti/src/screens/dashboard.dart';
import 'package:mr_gharbeti/src/screens/info_page.dart';

import '../controller/profile_controller.dart';
import '../widgets/authentication/database_methods.dart';
import '../widgets/authentication/fire_auth.dart';
import './update_profile.dart';
import '../widgets/profile/profile_menu.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name = '', profilePic = '';
  getmyInfo() async {
    QuerySnapshot querySnapshot =
        await DatabaseMethods().getUserInfo(widget.uid);
    name = querySnapshot.docs[0]['name'];
    profilePic = querySnapshot.docs[0]['imgUrl'];
    setState(() {});
  }
  // late String myName, myProfilePic, myUserName, myEmail;
  // getMyInfoFromSharedPreference() async {
  //   myName = (await SharedPreferenceHelper().getDisplayName())!;

  //   myProfilePic = (await SharedPreferenceHelper().getUserProfileUrl())!;
  //   myUserName = (await SharedPreferenceHelper().getUserName())!;
  //   myEmail = (await SharedPreferenceHelper().getUserEmail())!;
  //   setState(() {});
  // }

  // final ProfileController profileController = Get.put(ProfileController());

  onScreenLoaded() async {
    await getmyInfo();
    // await getMyInfoFromSharedPreference();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // getmyInfo();
    // profileController.getmyInfo();
    onScreenLoaded();
    // // myName;
    // profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    // String name = DashBoard.user_data();
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    String? myName = name!.isEmpty ? '' : name;
    String? myprofilePic = profilePic!.isEmpty ? '' : profilePic;

    // return GetBuilder<ProfileController>(
    //     init: ProfileController(),
    //     builder: (controller) {
    // if (controller.user.isEmpty) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
    // if (name == null && profileController == null) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF00BF6D).withOpacity(0.9),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            LineAwesomeIcons.angle_left,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
          //       color: Colors.black,
          //     ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image(
                    image: NetworkImage(FireAuth.instance.user.photoURL!),

                    // image: NetworkImage(myprofilePic!),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Text(
                // '',
                // controller.user['name'],
                // controller.name!.value,
                myName!,
                // controller.user['fullName'] as String,
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                // controller.user['email'],
                FireAuth.instance.user.email!,
                // 'me1111friend@gmail.com',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(
                height: 20,
              ),

              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ProfileMenuWidget(
                title: 'Info',
                icon: LineAwesomeIcons.info,
                onPress: () {
                  Get.to(() => InfoPage());
                },
              ),
              ProfileMenuWidget(
                title: 'FAQ',
                icon: LineAwesomeIcons.question,
                onPress: () {
                  Get.to(() => FAQPage());
                },
              ),
              const Divider(),

              ProfileMenuWidget(
                title: 'Logout',
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Colors.red,
                onPress: () async {
                  continueCallBack() => {
                        FireAuth.instance.logout(),
                        Navigator.of(context).pop(),
                      };

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlurryDialog("Confirm",
                          "Are you sure you want to logout?", continueCallBack);
                    },
                  );
                },
              ),
              // ProfileMenuWidget(),
            ],
          ),
        ),
      ),
    );
    // });
  }
}

class BlurryDialog extends StatelessWidget {
  String title;
  String content;
  VoidCallback continueCallBack;

  BlurryDialog(this.title, this.content, this.continueCallBack, {super.key});
  TextStyle textStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            title,
            style: textStyle,
          ),
          content: Text(
            content,
            style: textStyle,
          ),
          actions: <Widget>[
            SizedBox(
              width: 100,
              child: ElevatedButton(
                child: const Text("Continue"),
                onPressed: () {
                  continueCallBack();
                },
              ),
            ),
            SizedBox(
              width: 70,
              child: OutlinedButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ));
  }
}
