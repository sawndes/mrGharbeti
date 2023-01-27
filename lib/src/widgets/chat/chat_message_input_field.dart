import 'package:flutter/material.dart';

class ChatMessageInputField extends StatelessWidget {
  const ChatMessageInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(color: Color(0xFFF7F6F1), boxShadow: [
        BoxShadow(
          offset: const Offset(0, 4),
          blurRadius: 32,
          color: const Color(0xFF087949).withOpacity(0.08),
        )
      ]),
      child: SafeArea(
        child: Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            // height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(40),
            ),

            child: Row(
              children: const [
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.sentiment_satisfied_alt_outlined,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type message',
                    border: InputBorder.none,
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
