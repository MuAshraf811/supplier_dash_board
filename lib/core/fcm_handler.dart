import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import 'package:cloud_functions/cloud_functions.dart';

class NotificationService {

  static const String functionUrl = 'https://sendnotification-3nimspdhaq-uc.a.run.app';  // You'll get this after deploying

  static Future<void> sendNotification({
    required String userToken,
    required String title,
    required String body,
    Map<String, String>? data,
  }) async {
    try {
      // Prepare the request body
      final payload = {
        'token': userToken,
        'title': title,
        'body': body,
        if (data != null) 'data': data,
      };

      print('Sending payload: ${jsonEncode(payload)}');

      final response = await http.post(
        Uri.parse(functionUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully: ${response.body}');
      } else {
        throw Exception('Failed to send notification: ${response.body}');
      }
    } catch (e) {
      print('Error sending notification: $e');
      rethrow;
    }
  }

  Future<String?> getFCMToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      print('FCM Token: $token');
      return token;
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }
}