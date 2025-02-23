import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_board/home/model/chat_model.dart';
import 'package:dash_board/home/model/users_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/fcm_handler.dart';
import '../../../model/message_modl.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final ScrollController chatScrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  final chatTextFieldKey = GlobalKey<FormState>();
  List<MessageprodModel>? allChatMessages;
  late List<UsersModel> allUsers = [];
  late List<String> suppliersIds = [];
  late List<ChatModel> allChatsInDataBase;
  String? imagepath;
  String userChatId = "";
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

  StreamSubscription? messageSubscription;
  chechkChatIdExistance() {
    userChatId.isEmpty
        ? emit(FetchingMessagesState())
        : emit(FetchingMessagesSuccessState());
  }

  void fetchMessages(String id) {
    messageSubscription = getMessagesStream(id).listen(
      (messages) {
        log("Step 2 : $messages");
      },
      onError: (error) {
        emit(FetchingMessagesErrorState(error: error.toString()));
      },
    );
  }

  Stream<List<MessageprodModel>> getMessagesStream(String id) {
    return FirebaseFirestore.instance
        .collection("Chat")
        .doc(id)
        .collection("messages")
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) {
      log('Step 1 : $snapshot');
      return snapshot.docs
          .map((doc) => MessageprodModel.fromJson(doc.data()))
          .toList();
    });
  }

  void sendAMessage({required String id}) async {
    final QuerySnapshot a =
        await FirebaseFirestore.instance.collection("Chat").get();
    log("***@@@@@@@@@@@@*");
    log(a.docs.toString());
    try {
      log("Hi #################@@@@@@@@@@@@@@@@@");
      log(messageController.text);
      MessageprodModel message = MessageprodModel(
        message: messageController.text,
        time:
            "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}",
        userId: "1",
      );
      await FirebaseFirestore.instance
          .collection("Chat")
          .doc(id)
          .collection("messages")
          .add(
            message.toMap(),
          );

      // NotificationService.sendNotification(
      //     userToken:  res.data()?['fcmToken'],
      //     title: "You Have new messages",
      //     body:  "We would like to hear from you..",
      //     data: {
      //       "date": "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}"
      //     }
      // );


      messageController.clear();
    } catch (e) {
      log(e.toString());
      emit(FetchingMessagesErrorState(error: e.toString()));
    }
  }
  bool isSupplierChatmarker(String docId){
return true;
  }
  void getAllChats() async {
    try {
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: false,
      );

      emit(FetchingAllChatsState());

      // Step 1: Fetch all chat document IDs
      final instanceUsers = FirebaseFirestore.instance.collection("Users");
      final instanceSuppliers = FirebaseFirestore.instance.collection("Suppliers");


      final querySnapshotUsers = await instanceUsers.get();
      final querySnapshotSuppliers = await instanceSuppliers.get();
      print(querySnapshotSuppliers.docs.first.id);

      suppliersIds.addAll(querySnapshotSuppliers.docs.map((e) {
        return e.id;
      },).toList());

      allUsers = [];
      allUsers = querySnapshotUsers.docs
          .map((e) => UsersModel.fromMap({
                ...e.data(), // Spread the existing data
                'docId': e.id, // Add docId to the data map
                'isSupplier': false, // Add isSupplier to the data map
              }))
          .toList();

      allUsers.addAll(
          querySnapshotSuppliers.docs
              .map((e) => UsersModel.fromMap({
            ...e.data(), // Spread the existing data
            'docId': e.id, // Add docId to the data map
            'isSupplier': true, // Add isSupplier to the data map
          }))
              .toList()
      );
      //   final List<QueryDocumentSnapshot> userSnapshots = userSnapshot.docs
      //       .where((element) => chatIds.contains(element.id))
      //       .toList(); // Check if element.id is in chatIds
      //   log("Step 2 **************");

      //   log(userSnapshots.toString());
      //   // Step 3: Map user documents to ChatModel
      //   allChatsInDataBase = userSnapshots
      //       .map((e) => ChatModel.fromMap(e.data() as Map<String, dynamic>))
      //       .toList();
      //   log("Step 3 **************");

      //   log(allChatsInDataBase.toString());
      // } else {
      //   allChatsInDataBase = [];
      // }

      emit(FetchingAllChatsSuccessState());
    } catch (e) {
      log("******************************************");
      log(e.toString());
      emit(FetchingAllChatsErrorState(error: e.toString()));
    }
  }

  void getAllmessages({required String id}) async {
    try {
      emit(FetchingMessagesState());

      final res = await FirebaseFirestore.instance
          .collection("Chat")
          .doc(id)
          .collection("messages")
          .get();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> response =
          res.docs;

      log("###########################");
      log(response.toString());
      allChatMessages =
          response.map((e) => MessageprodModel.fromJson(e.data())).toList();

      // chatScrollController
      //         .jumpTo(chatScrollController.position.maxScrollExtent);
      emit(FetchingMessagesSuccessState());
    } catch (e) {
      log(e.toString());
      emit(FetchingMessagesErrorState(error: e.toString()));
    }
  }

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
