import 'package:chat_app/constant.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/models/messages_model.dart';
import 'package:chat_app/utils/responsive_font_size.dart';
import 'package:chat_app/widgets/bubbles_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageBody extends StatefulWidget {
  const ChatPageBody({
    super.key,
  });

  @override
  State<ChatPageBody> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBody> {
  final TextEditingController textController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).getMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              List<MessageModel> messagesList =
                  BlocProvider.of<ChatCubit>(context).messagesList;
              return ListView.builder(
                reverse: true,
                controller: scrollController,
                itemCount: messagesList.length,
                itemBuilder: (context, index) {
                  return messagesList[index].id ==
                          FirebaseAuth.instance.currentUser!.uid
                      ? ChatBubbleForMe(
                          message: messagesList[index],
                        )
                      : ChatBubbleForFriends(message: messagesList[index]);
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Send Message',
              hintStyle: TextStyle(
                fontSize: getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
              ),
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
                BlocProvider.of<ChatCubit>(context).sendMessage(data);
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
