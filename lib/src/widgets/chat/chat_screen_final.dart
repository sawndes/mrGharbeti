import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mr_gharbeti/src/helper/sharedpref_helper.dart';
import 'package:mr_gharbeti/src/widgets/chat/chat_message_input_field.dart';
import 'package:random_string/random_string.dart';

import '../authentication/database_methods.dart';

class FinalChatScreen extends StatefulWidget {
  // final String chatwithUsername, chatwithName;
  const FinalChatScreen({
    super.key,
    // required this.chatwithUsername,
    // required this.chatwithName,
  });

  @override
  State<FinalChatScreen> createState() => _FinalChatScreenState();
}

class _FinalChatScreenState extends State<FinalChatScreen> {
  String? chatRoomId, messageId;
  Stream<QuerySnapshot>? messageStream;
  String? myName, myProfilePic, myUserName, myEmail;
  TextEditingController messageTextEditingController = TextEditingController();

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      "$a\_$b";
    }
  }

  getMyInfoFromSharedPreferences() {
    //   myName = await SharedPreferenceHelper().getDisplayName();
    //   myUserName = await SharedPreferenceHelper().getUserId();
    //   // myProfilePic = await
    chatRoomId = getChatRoomIdByUsernames(
      'ETDoR1760nbGDZodGIvxLMQvprR2',
      '6sXzuLh673UHiZOEpNXfUUgawV92',
    );
  }

  getAndSetMessages() async {
    messageStream = await DatabaseMethods().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  addMessage(bool sendClicked) {
    if (messageTextEditingController.text != "") {
      String message = messageTextEditingController.text;

      var lastMessageTs = DateTime.now();

      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": 'ETDoR1760nbGDZodGIvxLMQvprR2',
        "ts": lastMessageTs,
        "imgUrl":
            'https://lh3.googleusercontent.com/a/AEdFTp6gxx6_kIwOlyuMuHuLV3FmwI-b9wWH12x8eb_tFM4=s96-c'
      };

      // print("sdasdasd" + chatRoomId.toString());

      //messageId
      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }

      DatabaseMethods()
          .addMessage(
              chatRoomId.toString(), messageId.toString(), messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy": 'ETDoR1760nbGDZodGIvxLMQvprR2'
        };

        DatabaseMethods()
            .updateLastMessageSend(chatRoomId!, lastMessageInfoMap);

        if (sendClicked) {
          // remove the text in the message input field
          messageTextEditingController.text = "";
          // make message id blank to get regenerated on next message send
          messageId = "";
        }
      });
    }
  }

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomRight:
                      sendByMe ? Radius.circular(0) : Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft:
                      sendByMe ? Radius.circular(24) : Radius.circular(0),
                ),
                color: sendByMe
                    ? const Color(0xFF00BF6D).withOpacity(0.9)
                    : Colors.grey.withOpacity(0.3),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                message,
                style: TextStyle(
                  color: sendByMe ? Colors.white : Colors.black,
                ),
              )),
        ),
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: messageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 70, top: 16),
                itemCount: snapshot.data!.docs.length,
                // itemCount: snapshot.data,
                reverse: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return chatMessageTile(ds["message"],
                      'ETDoR1760nbGDZodGIvxLMQvprR2' == ds["sendBy"]);
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  doThisOnLaunch() async {
    getMyInfoFromSharedPreferences();
    getAndSetMessages();
  }

  @override
  void initState() {
    doThisOnLaunch();
    // TODO: implement initState
    super.initState();
  }

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
        backgroundColor: const Color(0xFFF7F6F1),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(arguments[2]),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  arguments[0],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                // Text(
                //   'Active ${arguments[0]}',
                //   style: const TextStyle(
                //     color: Colors.black,
                //     fontSize: 12,
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                // color: Colors.black.withOpacity(0.8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: Color(0xFFF7F6F1), boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 32,
                    color: const Color(0xFF087949).withOpacity(0.08),
                  )
                ]),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Type message',
                          border: InputBorder.none,
                        ),
                        controller: messageTextEditingController,
                        onChanged: (value) {
                          // addMessage(false);
                        },
                        // style: TextStyle(color: Colors.white),
                        // decoration: InputDecoration(
                        //     border: InputBorder.none,
                        //     hintText: "type a message",
                        //     hintStyle: TextStyle(
                        //         color: Colors.white.withOpacity(0.6))),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        addMessage(true);
                      },
                      child: Icon(
                        Icons.send,
                        // color: Colors.white,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
