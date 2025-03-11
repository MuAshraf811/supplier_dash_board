import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/notifications_model.dart';
import '../../data/models/user_data_model.dart';
import 'notification_states.dart';

class NotificationsCubit extends Cubit<NotificationStates> {
  NotificationsCubit() : super(NotificationInitial());
  static NotificationsCubit get(context) => BlocProvider.of(context);

  static List<NotificationModel> userNotifications = [];

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
          userNotifications = [NotificationModel.fromJson(jsonData)];
        } else if (jsonData is List) {
          // If it's a list of notifications
          userNotifications = jsonData
              .map((item) =>
                  NotificationModel.fromJson(item as Map<String, dynamic>))
              .toList();
        }
      } else {
        userNotifications = [];
      }
    }

    // add new notification to the list
    userNotifications.add(notification);

    // convert list back to json encodded string
    final List<Map<String, dynamic>> notificationsJson =
        userNotifications.map((notification) => notification.toJson()).toList();

    print('target id: $targetDataId');
    // update the notificationHistory in the firestore for the required user or supplier
    await instance
        .doc(targetDataId)
        .update({'notificationHistory': jsonEncode(convertNotificationsForJson(userNotifications))});
  }
  static List<Map<String, dynamic>> convertNotificationsForJson(List<NotificationModel> notifications) {
    return notifications.map((notification) {
      Map<String, dynamic> notificationMap = notification.toJson(); // Convert to basic map

      // Handle Timestamp specifically
      if (notificationMap['data'] != null && notificationMap['data']['date'] is Timestamp) {
        notificationMap['data']['date'] = notificationMap['data']['date'].toDate().toString();
      }

      return notificationMap;
    }).toList();
  }

}
