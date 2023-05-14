import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:mr_gharbeti/src/widgets/dashboard_widgets/appBar_ui.dart';
import 'package:random_string/random_string.dart';

import '../widgets/authentication/database_methods.dart';
import '../widgets/authentication/fire_auth.dart';

class NotifyUser extends StatefulWidget {
  final String rentUid;
  const NotifyUser({super.key, required this.rentUid});

  @override
  State<NotifyUser> createState() => _NotifyUserState();
}

class _NotifyUserState extends State<NotifyUser> {
  String? mtoken = "";
  String messageId = '';
  // String tenantID = this.tenantID;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  TextEditingController username = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  String thisUser = FireAuth.instance.user.uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
    // getToken();
    initInfo();
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
        .doc("User1")
        .set({'token': token});
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAONKJDgE:APA91bF5uFDCGvOZ1vP6qo5iQ_fC8se3u_9hVI-C99ZBdkUjTyFPpY_FV7XXqCYbXApdmEWq4UX-dQikV0FgR64-4ucT2F4KdQSaXbN_4CTxgrVlU7vo46IlRDoc3vTKcZ5vb0XR5lMe'
          },
          body: jsonEncode(
            <String, dynamic>{
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'status': 'done',
                'body': body,
                'title': title,
              },
              "notification": <String, dynamic>{
                "title": title,
                "body": body,
                "android_channel_id": "mrGharbeti",
              },
              "to": token,
            },
          ));

      var notificationId = thisUser + '_' + widget.rentUid;
      Map<String, dynamic> chatRoomInfoMap = {
        "users": [thisUser, widget.rentUid]
      };
      DatabaseMethods().createNotificationRoom(notificationId, chatRoomInfoMap);
      Map<String, dynamic> messageInfoMap = {
        "title": title,
        "body": body,
        "from": thisUser,
        "to": widget.rentUid
      };
      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }
      DatabaseMethods()
          .addNotification(notificationId, messageId, messageInfoMap);
      messageId = "";
    } catch (e) {
      print(e);
      // if (kDebugMode) {
      //   print('error push notification');
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUI('Send Notification', true),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 200,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: title,
                        decoration: InputDecoration(
                          label: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Notification Title',
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                    text: ' *',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                          prefixIcon: Icon(Icons.title),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        controller: body,
                        decoration: InputDecoration(
                          label: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Notification Body',
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                    text: ' *',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                          prefixIcon: Icon(Icons.title),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          String name = title.text.trim();
                          String titleText = title.text;
                          String bodyText = body.text;

                          if (name != "") {
                            DocumentSnapshot snap = await FirebaseFirestore
                                .instance
                                .collection("UserTokens")
                                .doc(widget.rentUid)
                                .get();
                            String token = snap['token'];
                            print(token);
                            title.clear();
                            body.clear();
                            sendPushMessage(token, titleText, bodyText);
                          }
                          // DocumentSnapshot snap = await FirebaseFirestore
                          //     .instance
                          //     .collection("UserTokens")
                          //     .doc(widget.rentUid)
                          //     .get();
                          // print(snap['token']);
                          // print(thisUser);
                          // print(widget.rentUid);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.redAccent.withOpacity(0.5),
                                )
                              ]),
                          child: const Center(
                            child: Text(
                              'Send Notifications',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
