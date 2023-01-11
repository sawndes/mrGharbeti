import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../widgets/chat/chat_message_screen_body.dart';

class ChatMessageScreen extends StatelessWidget {
  const ChatMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            LineAwesomeIcons.angle_left,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFF7F6F1),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(arguments.image),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  arguments.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Active ${arguments.time}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: chatMessageScreenBody(arguments),
    );
  }
}
