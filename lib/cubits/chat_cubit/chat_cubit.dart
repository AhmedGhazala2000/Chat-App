import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/models/messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kCollectionMessages);
  List<MessageModel> messagesList = [];

  void sendMessage(String message) {
    try {
      messages.add({
        kMessage: message,
        kCreatedAt: DateTime.now(),
        kId: FirebaseAuth.instance.currentUser!.uid,
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(
          MessageModel.fromJson(doc),
        );
      }
      emit(ChatSuccess());
    });
  }
}
