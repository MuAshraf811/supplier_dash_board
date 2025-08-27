import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class SupaBase {
  static init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

// Request permissions
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
  }
}
