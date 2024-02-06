import 'package:chat_app/constant.dart';
import 'package:chat_app/models/messages_model.dart';
import 'package:chat_app/widgets/bubbles_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPageBody extends StatelessWidget {
  ChatPageBody({
    super.key,
    required this.messagesList,
    required this.messages,
  });

  final List<MessageModel> messagesList;
  final CollectionReference<Object?> messages;
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              reverse: true,
              controller: scrollController,
              itemCount: messagesList.length,
              itemBuilder: (context, index) {
                return messagesList[index].id == userId
                    ? ChatBubbleForMe(
                        message: messagesList[index],
                      )
                    : ChatBubbleForFriends(message: messagesList[index]);
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Send Message',
              suffixIcon: const Icon(
                Icons.send,
                color: kPrimaryColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            controller: textController,
            onSubmitted: (data) {
              if (data.isNotEmpty) {
                messages.add({
                  kMessage: data,
                  kCreatedAt: DateTime.now(),
                  kId: userId,
                });
                textController.clear();
                scrollController.animateTo(0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn);
              }
            },
          ),
        ),
      ],
    );
  }
}
