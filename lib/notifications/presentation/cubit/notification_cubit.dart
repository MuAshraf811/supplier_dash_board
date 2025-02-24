import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/notifications_model.dart';
import '../../data/models/user_data_model.dart';
import 'notification_states.dart';

class NotificationsCubit extends Cubit<NotificationStates> {
  NotificationsCubit() : super(NotificationInitial());
  static NotificationsCubit get(context) => BlocProvider.of(context);

  static List<NotificationModel> allNotifications = [];

  // TODO will have a list of notifi model and proccess it below
  static Future<void> addToNotificationHistory(
      {required NotificationModel notification,
      required String targetDataId,
      required bool isSupplier}) async {
    String collectionName = isSupplier ? 'Suppliers' : 'Users';
    final instance = FirebaseFirestore.instance.collection(collectionName);

    // get past history
    final targetDetails = await instance.doc(targetDataId).get();

    // convert history into a list
    if (targetDetails.data() != null) {
      String currentUserNotifications =
          UserDataModel.fromJson(targetDetails.data()!).notificationHistory;
      if (currentUserNotifications.isNotEmpty) {
        final dynamic jsonData = jsonDecode(currentUserNotifications);
        // print(jsonData.toString());
        // Handle single notification case
        if (jsonData is Map<String, dynamic>) {
          // If it's a single notification
          allNotifications = [NotificationModel.fromJson(jsonData)];
        } else if (jsonData is List) {
          // If it's a list of notifications
          allNotifications = jsonData
              .map((item) =>
                  NotificationModel.fromJson(item as Map<String, dynamic>))
              .toList();
        }
      } else {
        allNotifications = [];
      }
    }

    // add new notification to the list
    allNotifications.add(notification);

    // convert list back to json encodded string
    final List<Map<String, dynamic>> notificationsJson =
        allNotifications.map((notification) => notification.toJson()).toList();

    // update the notificationHistory in the firestore for the required user or supplier
    await instance
        .doc(targetDataId)
        .update({'notificationHistory': jsonEncode(notificationsJson)});
  }
}
