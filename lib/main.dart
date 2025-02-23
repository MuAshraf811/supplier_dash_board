import 'dart:developer';

import 'package:dash_board/core/fcm_handler.dart';
import 'package:dash_board/dash_board.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// Required for registering the service worker on web.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://sedhaaxpmhjbkhnddiaz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNlZGhhYXhwbWhqYmtobmRkaWF6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzU2NjAzNjYsImV4cCI6MjA1MTIzNjM2Nn0.kHrMYTSyAHPriWvRcy6YFggxh8FSA0bswZBzcOLqx1M', // Replace with your Supabase Anon Key
  );
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBheZpG2QCtBrBspDi0ns_OWWAGWkSNMYw",
      authDomain: "supply-20735.firebaseapp.com",
      projectId: "supply-20735",
      storageBucket: "supply-20735.firebasestorage.app",
      messagingSenderId: "583335541663",
      appId: "1:583335541663:web:21bd55f2728bdb97219baa",
    ),
  );
  runApp(const DashBoard());
}
