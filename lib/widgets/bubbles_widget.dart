import 'package:chat_app/constant.dart';
import 'package:chat_app/models/messages_model.dart';
import 'package:chat_app/utils/responsive_font_size.dart';
import 'package:flutter/material.dart';

class ChatBubbleForMe extends StatelessWidget {
  const ChatBubbleForMe({Key? key, required this.message}) : super(key: key);
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(24),
              topLeft: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            )),
        child: Text(
          message.message,
          style: TextStyle(
            color: kSecondColor,
            fontSize: getResponsiveFontSize(
              context,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForFriends extends StatelessWidget {
  const ChatBubbleForFriends({Key? key, required this.message})
      : super(key: key);
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: const BoxDecoration(
            color: Color(0xff016D86),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
              topRight: Radius.circular(24),
            )),
        child: Text(
          message.message,
          style: TextStyle(
            color: kSecondColor,
            fontSize: getResponsiveFontSize(
              context,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
