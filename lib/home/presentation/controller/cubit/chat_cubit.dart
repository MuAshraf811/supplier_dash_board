import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board/home/model/chat_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../model/message_modl.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final ScrollController chatScrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  final chatTextFieldKey = GlobalKey<FormState>();
  List<MessageprodModel>? allChatMessages = [];
  late List<ChatModel> allChatsInDataBase;
  String? imagepath;
  void setUpScrollControllerConfigs() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (chatScrollController.hasClients) {
          chatScrollController
              .jumpTo(chatScrollController.position.maxScrollExtent);
        }
      },
    );
  }

  void getAllChats() async {
    try {
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: false,
      );

      emit(FetchingAllChatsState());

      // Step 1: Fetch all chat document IDs
      final QuerySnapshot chatSnapshots =
          await FirebaseFirestore.instance.collection('Chat').get();

      final List<String> chatIds = chatSnapshots.docs.map((e) => e.id).toList();
      log("Step 1 **************");

      log(chatIds.toString());
      // Step 2: Fetch user documents matching the chat IDs
      if (chatIds.isNotEmpty) {
        // final QuerySnapshot userSnapshots = await FirebaseFirestore.instance
        //     .collection("Users")
        //     .where(FieldPath.documentId.name, whereIn: chatIds)
        //     .get();
        final QuerySnapshot userSnapshot =
            await FirebaseFirestore.instance.collection("Users").get();
        for (var i in userSnapshot.docs) {
          log(i.id);
        }
        final List<QueryDocumentSnapshot> userSnapshots = userSnapshot.docs
            .where((element) => chatIds.contains(element.id))
            .toList(); // Check if element.id is in chatIds
        log("Step 2 **************");

        log(userSnapshots.toString());
        // Step 3: Map user documents to ChatModel
        allChatsInDataBase = userSnapshots
            .map((e) => ChatModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
        log("Step 3 **************");

        log(allChatsInDataBase.toString());
      } else {
        allChatsInDataBase = [];
      }

      emit(FetchingAllChatsSuccessState());
    } catch (e) {
      log("******************************************");
      log(e.toString());
      emit(FetchingAllChatsErrorState(error: e.toString()));
    }
  }

  // void getAllmessages() async {
  //   try {
  //     emit(FetchingMessagesState());
  //     final res = await FirebaseFirestore.instance
  //         .collection("chats")
  //         .doc(SharedPreferencesManager.getStringValue(
  //             key: StorageConstants.userId))
  //         .collection("messages")
  //         .orderBy("time", descending: false)
  //         .get();
  //     final List<QueryDocumentSnapshot<Map<String, dynamic>>> response =
  //         res.docs;
  //     final chats =
  //         response.map((e) => MessageprodModel.fromJson(e.data())).toList();

  //     allChatMessages?.addAll(chats);
  //     // chatScrollController
  //     //         .jumpTo(chatScrollController.position.maxScrollExtent);
  //     emit(FetchingMessagesSuccessState());
  //   } catch (e) {
  //     log(e.toString());
  //     emit(FetchingMessagesErrorState(error: e.toString()));
  //   }
  // }

  // void sendAMessage() async {
  //   try {
  //     MessageprodModel message = MessageprodModel(
  //       message: messageController.text,
  //       time:
  //           "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}",
  //       userId: "admin",
  //     );
  //     await FirebaseFirestore.instance
  //         .collection("chats")
  //         .doc(SharedPreferencesManager.getStringValue(
  //             key: StorageConstants.userId))
  //         .collection("messages")
  //         .add(
  //           message.toMap(),
  //         );
  //     getAllmessages();
  //   } catch (e) {
  //     log(e.toString());
  //     emit(FetchingMessagesErrorState(error: e.toString()));
  //   }
  // }

  // void sendMessage() {
  //   final message = messageController.text;
  //   AppConst.chatMessagesExamples.add(
  //     MessageModel(
  //       message: message,
  //       time: "${DateTime.now().hour}:${DateTime.now().minute}",
  //       isSender: true,
  //     ),
  //   );
  //   chatScrollController.jumpTo(chatScrollController.position.maxScrollExtent);

  //   emit(NewMessageState());
  // }

  void pickImage({required isFromCamera}) async {}

  @override
  Future<void> close() {
    messageController.dispose();
    chatScrollController.dispose();
    return super.close();
  }

  void ploadImages() {}
}
