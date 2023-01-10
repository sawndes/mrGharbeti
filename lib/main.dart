import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/firebase_options.dart';
import 'package:mr_gharbeti/src/controller/bookmark_clicked_controller.dart';

import './src/widgets/authentication/fire_auth.dart';
import './src/themes/themes.dart';
import './src/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(FireAuth()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  BookmarkClickedController bookmarkClickedController =
      Get.put(BookmarkClickedController());

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
