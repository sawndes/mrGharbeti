import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mr_gharbeti/src/widgets/authentication/database_methods.dart';
import 'package:mr_gharbeti/src/widgets/chat/chat_screen_final.dart';

import '../models/chat_model.dart';
import 'package:get/get.dart';

import '../widgets/authentication/fire_auth.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? usersStream, chatRoomsStream;
  // Stream<QuerySnapshot> chatRooms =
  //     DatabaseMethods().getChatRooms(FireAuth.instance.user.uid)
  //         as Stream<QuerySnapshot<Object?>>;
  Stream<QuerySnapshot<Map<String, dynamic>>>? chatsStream;
  String thisUser = FireAuth.instance.user.uid;

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getChatRooms(
      String uid) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: FireAuth.instance.user.uid)
        .snapshots();
  }

  // Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getChat(
  //     String uid) async {
  //   // String? myUsername = await SharedPreferenceHelper().getUserName();
  //   return FirebaseFirestore.instance
  //       .collection("chatrooms")
  //       // .orderBy("lastMessageSendTs", descending: true)
  //       // .where("users", arrayContains: uid)
  //       .snapshots();
  // }

  getChats() async {
    chatRoomsStream = await getChatRooms(thisUser);

    setState(() {});
  }

  onScreenLoaded() async {
    // await getMyInfoFromSharedPreference();
    await getChats();
  }

  @override
  void initState() {
    onScreenLoaded();
    print('chatRoomsList();');
    super.initState();
  }

  Widget chatRoomsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text('You don\'t have any messages yet'));
        }
        List<DocumentSnapshot> chatRoomDocs = snapshot.data!.docs;

        return ListView.builder(
            itemCount: chatRoomDocs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];

              var data = snapshot.data!.docs[index];

              return ChatRoomListTile(data["lastMessage"], data.id, thisUser,
                  data['lastMessageSendTs']);
            });

        // : const Center(child: Text('You don\'t have any messages yet'));
      },
    );
  }
  // Widget chatRoomsList() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: chatRoomsStream,
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData || !snapshot.hasData) {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //       List<DocumentSnapshot> chatRoomDocs = snapshot.data!.docs;
  //       return ListView.builder(
  //           itemCount: chatRoomDocs.length,
  //           shrinkWrap: true,
  //           itemBuilder: (context, index) {
  //             var data = snapshot.data!.docs[index];
  //             return ChatRoomListTile(
  //                 data["lastMessage"], data['id'], thisUser);
  //           });
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    String thisUser = FireAuth.instance.user.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F6F1),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        title: const Text(
          'Chats',
          style: TextStyle(
            color: Colors.black,
            fontSize: 23,
          ),
          // style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: chatRoomsList(),
      // body: Column(
      //   children: [
      //     Expanded(
      //       child: ListView.builder(
      //         itemCount: chatsData.length,
      //         itemBuilder: (context, index) => InkWell(
      //           onTap: () {
      //             var chatRoomId = getChatRoomIdByUsernames(
      //               thisUser,
      //               '21GJW3e0UpUkQdOx5H6iWaDdyLt1',
      //               // '6sXzuLh673UHiZOEpNXfUUgawV92',
      //             );
      //             Map<String, dynamic> chatRoomInfoMap = {
      //               "users": [
      //                 thisUser,
      //                 // '6sXzuLh673UHiZOEpNXfUUgawV92',
      //                 '21GJW3e0UpUkQdOx5H6iWaDdyLt1',
      //               ]
      //             };
      //             // Get.to(() => ChatMessageScreen(),
      //             //     arguments: chatsData[index]);
      //             DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
      //             Get.to(() => const FinalChatScreen(), arguments: [
      //               'Sawndes',
      //               '21GJW3e0UpUkQdOx5H6iWaDdyLt1',

      //               //                       '6sXzuLh673UHiZOEpNXfUUgawV92',
      //               // '6sXzuLh673UHiZOEpNXfUUgawV92',
      //               'https://lh3.googleusercontent.com/a/AEdFTp6gxx6_kIwOlyuMuHuLV3FmwI-b9wWH12x8eb_tFM4=s96-c',
      //             ]);
      //           },
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(
      //               horizontal: 20,
      //               vertical: 15,
      //             ),
      //             child: Row(
      //               children: [
      //                 Stack(
      //                   children: [
      //                     CircleAvatar(
      //                       radius: 24,
      //                       backgroundImage: AssetImage(chatsData[index].image),
      //                     ),
      //                     if (chatsData[index].isActive)
      //                       Positioned(
      //                         right: 0,
      //                         bottom: 0,
      //                         child: Container(
      //                           height: 16,
      //                           width: 16,
      //                           decoration: BoxDecoration(
      //                               color: const Color(0xFF00BF6D),
      //                               shape: BoxShape.circle,
      //                               border: Border.all(
      //                                 color: Colors.white,
      //                                 width: 3,
      //                               )),
      //                         ),
      //                       )
      //                   ],
      //                 ),

      //                   child: Padding(
      //                     padding: const EdgeInsets.symmetric(horizontal: 20),
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text(
      //                           chatsData[index].name,
      //                           style: const TextStyle(
      //                             fontSize: 16,
      //                             fontWeight: FontWeight.w500,
      //                           ),
      //                         ),
      //                         const SizedBox(
      //                           height: 8,
      //                         ),
      //                         Opacity(
      //                           opacity: 0.64,
      //                           child: Text(
      //                             chatsData[index].lastMessage,
      //                             maxLines: 1,
      //                             overflow: TextOverflow.ellipsis,
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //                 Opacity(
      //                   opacity: 0.64,
      //                   child: Text(
      //                     chatsData[index].time,
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String lastMessage, chatRoomId, myUsername;
  final Timestamp timestamp;
  const ChatRoomListTile(
      this.lastMessage, this.chatRoomId, this.myUsername, this.timestamp,
      {super.key});

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  // print('Difference: $difference');
  String profilePicUrl = "", name = "", username = "";

  getThisUserInfo() async {
    username =
        widget.chatRoomId.replaceAll(widget.myUsername, "").replaceAll("_", "");
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserInfo(username);
    print(
        "something bla bla ${querySnapshot.docs[0].id} ${querySnapshot.docs[0]["name"]}  ${querySnapshot.docs[0]["imgUrl"]}");
    name = "${querySnapshot.docs[0]["name"]}";
    profilePicUrl = "${querySnapshot.docs[0]["imgUrl"]}";

    setState(() {});
  }

  String getTimeDifference(Timestamp timestamp) {
    //  var timestamp = Timestamp(seconds: 1675421403, nanoseconds: 233000000);
    var dateTime = DateTime.fromMillisecondsSinceEpoch(
        (timestamp.seconds * 1000) + (timestamp.nanoseconds ~/ 1000000));
    var now = DateTime.now();
    var difference = now.difference(dateTime);
    // var difference = start.difference(end);
    if (difference.inSeconds < 59) {
      if (difference.inSeconds == 0) {
        return '1 seconds';
      } else {
        return '${difference.inSeconds} seconds';
      }
    } else if (difference.inMinutes < 59) {
      return '${difference.inMinutes} minutes';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours';
    } else {
      return '${difference.inDays} days';
    }
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    print('object');
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var difference = getTimeDifference(widget.timestamp);

    return InkWell(
      onTap: () {
        var chatRoomId = getChatRoomIdByUsernames(
          widget.myUsername,
          username,
        );
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [widget.myUsername, username]
        };
        // // Get.to(() => ChatMessageScreen(),
        // //     arguments: chatsData[index]);
        DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);

        Get.to(() => FinalChatScreen(),
            arguments: [profilePicUrl, name, username, chatRoomId]);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ChatScreen(username, name)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(profilePicUrl),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        widget.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.64,
              child: Text('$difference ago'),
            ),
          ],
        ),
      ),
    );
  }
}
