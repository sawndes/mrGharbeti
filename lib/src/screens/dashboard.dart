import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/screens/all_listings.dart';
import 'package:mr_gharbeti/src/widgets/firestore/user_firestore.dart';
import '../controller/profile_controller.dart';
import '../widgets/authentication/fire_auth.dart';
import '../widgets/dashboard_widgets/appBar_ui.dart';
import '../widgets/dashboard_widgets/banner_ui.dart';
import '../widgets/dashboard_widgets/searchBar_ui.dart';
import '../widgets/dashboard_widgets/top_listings_ui.dart';

class DashBoard extends StatefulWidget {
  // String uid;
  const DashBoard({Key? key}) : super(key: key);
  static final user_data = UserRepository.instance.tryUpdateUI();

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String? mtoken = "";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    print('dashboard');
    // requestPermission();
    getToken();
    // initInfo();
    super.initState();
    // profileController.updateUserId(widget.uid);
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitialize);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payLoad) async {
      try {
        if (payLoad != null && payLoad.isNotEmpty) {
        } else {}
      } catch (e) {}
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('-----onmessage-------');
      print(
          "onMessage: ${message.notification?.title}/${message.notification?.body}");
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContent: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'mrGharbeti',
        'mrGharbeti',
        importance: Importance.max,
        styleInformation: bigTextStyleInformation,
        priority: Priority.max,
        playSound: false,
      );
      NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecifics,
          payload: message.data['body']);
    });
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print("My token is $mtoken");
      });
      saveToken(token!);
    });
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection("UserTokens")
        .doc(FireAuth.instance.user.uid)
        .set({'token': token});
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Explore Listings',
                    style: textTheme.headline2,
                  ),
                  TextButton(
                    // style: ButtonStyle(colo),
                    onPressed: () {
                      Get.to(() => AllListings(
                            textTheme: textTheme,
                          ));
                    },

                    child: Text(
                      'View All Listings',
                      // style: TextStyle(color: Colors.black),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )
                ],
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
