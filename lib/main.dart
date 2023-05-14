import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:mr_gharbeti/firebase_options.dart';
import 'package:mr_gharbeti/src/controller/all_listings_bookmark_controller.dart';
import 'package:mr_gharbeti/src/controller/bookmark_clicked_controller.dart';

import './src/widgets/authentication/fire_auth.dart';
import './src/themes/themes.dart';
import './src/screens/home_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(FireAuth()));
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  BookmarkClickedController bookmarkClickedController =
      Get.put(BookmarkClickedController());
  AllListingsBookmarkController allListingsBookmarkController =
      Get.put(AllListingsBookmarkController());
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: 'test_public_key_f74e348bcac5490eb6a350addff264b5',
        enabledDebugging: true,
        builder: (context, navKey) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            home: const HomeScreen(),
            navigatorKey: navKey,
            localizationsDelegates: const [KhaltiLocalizations.delegate],
          );
        });
  }
}
