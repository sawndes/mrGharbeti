import 'package:flutter/material.dart';
import 'package:mr_gharbeti/src/widgets/authentication/database_methods.dart';
import 'package:mr_gharbeti/src/widgets/chat/chat_screen_final.dart';
// import 'package:mr_gharbeti/src/screens/chat_message_screen.dart';
import '../screens/chat_message_screen.dart';
import '../models/chat_model.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream? usersStream, chatRoomsStream;

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  getChatRooms() async {
    // chatRoomsStream = await DatabaseMethods().getChatRooms();
    setState(() {});
  }

  onScreenLoaded() async {
    // await getMyInfoFromSharedPreference();
    getChatRooms();
  }

  @override
  void initState() {
    onScreenLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F6F1),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatsData.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  var chatRoomId = getChatRoomIdByUsernames(
                      'ETDoR1760nbGDZodGIvxLMQvprR2',
                      '6sXzuLh673UHiZOEpNXfUUgawV92');
                  Map<String, dynamic> chatRoomInfoMap = {
                    "users": [
                      'ETDoR1760nbGDZodGIvxLMQvprR2',
                      '6sXzuLh673UHiZOEpNXfUUgawV92'
                    ]
                  };
                  // Get.to(() => ChatMessageScreen(),
                  //     arguments: chatsData[index]);
                  DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
                  Get.to(() => FinalChatScreen(), arguments: [
                    'Sawndes',
                    '6sXzuLh673UHiZOEpNXfUUgawV92',
                    'https://lh3.googleusercontent.com/a/AEdFTp6gxx6_kIwOlyuMuHuLV3FmwI-b9wWH12x8eb_tFM4=s96-c',
                  ]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage(chatsData[index].image),
                          ),
                          if (chatsData[index].isActive)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                    color: Color(0xFF00BF6D),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    )),
                              ),
                            )
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chatsData[index].name,
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
                                  chatsData[index].lastMessage,
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
                        child: Text(chatsData[index].time),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
