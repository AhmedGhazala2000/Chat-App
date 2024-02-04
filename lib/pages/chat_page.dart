import 'dart:developer';

import 'package:chat_app/constant.dart';
import 'package:chat_app/models/messages_model.dart';
import 'package:chat_app/widgets/chat_page_body.dart';
import 'package:chat_app/widgets/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  static const String id = 'ChatPage';
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kCollectionMessages);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messagesList = [];
            for (var doc in snapshot.data!.docs) {
              messagesList.add(
                MessageModel.fromJson(doc),
              );
            }
            return Scaffold(
              appBar: customAppBar(context),
              body:
                  ChatPageBody(messagesList: messagesList, messages: messages),
            );
          } else if (snapshot.hasError) {
            log(snapshot.error.toString());
            return const Text('There was an error, Please try later !');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
