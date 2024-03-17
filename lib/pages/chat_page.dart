import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/chat_page_body.dart';
import 'package:chat_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);
  static const String id = 'ChatPage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset:
            MediaQuery.sizeOf(context).height < 400 ? false : true,
        appBar: customAppBar(context),
        body: const ChatPageBody(),
      ),
    );
  }
}
