import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../widgets/authentication/fire_auth.dart';
import './update_profile.dart';
import '../widgets/profile/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
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
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: AssetImage('assets/images/googlelogo.png'),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: const Icon(
                          LineAwesomeIcons.alternate_pencil,
                          color: Colors.black,
                          size: 20,
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Sandesh Sitaula',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                'me1111friend@gmail.com',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => UpdateProfileScreen());
                  },
                  child: Text(
                    'Edit Profile',
                  ),
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ProfileMenuWidget(
                title: 'Settings',
                icon: LineAwesomeIcons.cog,
                onPress: () {},
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ProfileMenuWidget(
                title: 'Info',
                icon: LineAwesomeIcons.info,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: 'FAQ',
                icon: LineAwesomeIcons.question,
                onPress: () {},
              ),
              ProfileMenuWidget(
                title: 'Logout',
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Colors.red,
                onPress: () {
                  FireAuth.instance.logout();
                },
              ),
              // ProfileMenuWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
