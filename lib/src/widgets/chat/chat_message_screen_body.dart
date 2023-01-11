import 'package:flutter/material.dart';
import 'package:mr_gharbeti/src/models/chat_message_model.dart';

import './chat_message_input_field.dart';

class chatMessageScreenBody extends StatelessWidget {
  const chatMessageScreenBody(
    this.argument, {
    Key? key,
  }) : super(key: key);
  final dynamic argument;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: demeChatMessages.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: demeChatMessages[index].isSender
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    if (!demeChatMessages[index].isSender) ...[
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: AssetImage(argument.image),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                    Container(
                      // margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        // color: Color.fromARGB(255, 249, 240, 202),
                        color: demeChatMessages[index].isSender
                            ? const Color(0xFF00BF6D).withOpacity(0.9)
                            : Colors.grey.withOpacity(0.3),

                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        demeChatMessages[index].text,
                        style: TextStyle(
                            color: demeChatMessages[index].isSender
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const ChatMessageInputField()
      ],
    );
  }
}
