import 'package:flutter/material.dart';

enum ChatMessageType { text, audio, image, video }

enum MessageStatus { not_sent, not_view, viewed }

class ChatMessageModel {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessageModel({
    this.text = '',
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
  });
}

List demeChatMessages = [
  ChatMessageModel(
    text: "Hi Sajol,",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessageModel(
    text: "Hello, How are you?",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessageModel(
    text: "",
    messageType: ChatMessageType.audio,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessageModel(
    text: "Alright Alright Alright",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_sent,
    isSender: true,
  ),
  ChatMessageModel(
    text: "This looks great man!!",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessageModel(
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
  ),
  ChatMessageModel(
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: false,
  ),
];
