import 'package:dash_board/dash_board.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCOE-Q2C8rwIRogWxRZgHBWhKAvt-a0N8o",
            authDomain: "supplier-a69d0.firebaseapp.com",
            databaseURL: "https://supplier-a69d0-default-rtdb.firebaseio.com",
            projectId: "supplier-a69d0",
            storageBucket: "supplier-a69d0.firebasestorage.app",
            messagingSenderId: "820970179759",
            appId: "1:820970179759:web:0a140986f890403db9185a",
            measurementId: "G-B9NBMBZ3ML"));
  } catch (e) {
    debugPrint('Firebase Initialization Error: $e');
  }

  runApp(const DashBoard());
}
