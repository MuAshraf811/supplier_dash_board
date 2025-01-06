import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';

class FCMHandler {
  static Future<void> sendNotification(
      String fcmToken, String title, String body) async {
    try {
      final HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('sendNotification');
      final response = await callable.call({
        'fcmToken': fcmToken,
        'title': title,
        'body': body,
      });

      if (response.data['success']) {
        log("Notification sent: ${response.data['response']}");
      } else {
        log("Failed to send notification: ${response.data['error']}");
      }
    } catch (e) {
      log("Error sending notification: $e");
    }
  }
}
