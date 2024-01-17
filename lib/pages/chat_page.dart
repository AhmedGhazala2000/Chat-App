import 'package:chat_app/constant.dart';
import 'package:chat_app/models/messages_model.dart';
import 'package:chat_app/widgets/bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  static const String id = 'ChatPage';
  final TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    CollectionReference messages =
        FirebaseFirestore.instance.collection('messages');
    var userId = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messagesList = [];
            List docsData = snapshot.data!.docs;
            for (var i = 0; i < docsData.length; i++) {
              messagesList.add(
                MessageModel.fromJson(docsData[i]),
              );
            }
            return Scaffold(
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: kPrimaryColor,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/scholar.png',
                        height: 55,
                      ),
                      const Text(
                        'Chat',
                        style: TextStyle(color: kSecondColor),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(color: kSecondColor,
                      icon: const Icon(Icons.logout),
                      onPressed: () async{
                        await FirebaseAuth.instance.signOut();
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                    ),
                  ]),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].id == userId
                              ? ChatBubble(
                                  message: messagesList[index],
                                )
                              : ChatBubbleForFriends(
                                  message: messagesList[index]);
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
                      controller: controller,
                      onSubmitted: (data) {
                        if (data.isNotEmpty) {
                          messages.add({
                            kMessage: data,
                            kCreatedAt: DateTime.now(),
                            kId: userId,
                          });
                          controller.clear();
                          _controller.animateTo(0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn);
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Text('there was an error, try later');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
