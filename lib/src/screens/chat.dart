import 'package:flutter/material.dart';
// import 'package:mr_gharbeti/src/screens/chat_message_screen.dart';
import '../screens/chat_message_screen.dart';
import '../models/chat_model.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

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
                  Get.to(ChatMessageScreen(), arguments: chatsData[index]);
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
