import 'dart:developer';

// import 'package:dash_board/core/fcm_handler.dart';
import 'package:dash_board/core/service_locator.dart';
import 'package:dash_board/dash_board.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/notification_service.dart';
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
  ServiceLocator.setObjects();
  runApp(
      AppExpiryWrapper(
          expiryDate: DateTime(2025, 9, 1),
          child: const DashBoard()
      )
  );
}

class AppExpiryWrapper extends StatefulWidget {
  final DateTime expiryDate;
  final Widget child;

  const AppExpiryWrapper({
    super.key,
    required this.expiryDate,
    required this.child,
  });

  @override
  State<AppExpiryWrapper> createState() => _AppExpiryWrapperState();
}

class _AppExpiryWrapperState extends State<AppExpiryWrapper> {
  late Future<DateTime> _networkTime;
  bool _isExpired = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _networkTime = _getNetworkTime();
  }

  Future<DateTime> _getNetworkTime() async {
    try {
      final DateTime networkTime;
      if (kIsWeb == false) {
        networkTime = await NTP.now();
      }
      else {
        networkTime = DateTime.now();
      }
      setState(() {
        _isExpired = networkTime.isAfter(widget.expiryDate);
        _hasError = false;
      });
      return networkTime;
    } catch (e) {
      setState(() => _hasError = true);
      print('Error fetching network time: $e');
      return DateTime.now(); // Fallback that won't affect the expired check
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DateTime>(
      future: _networkTime,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (_hasError) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: NoInternetScreen(),
          );
        }

        if (_isExpired) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: ExpiryScreen(),
          );
        }

        return widget.child;
      },
    );
  }
}

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text('Please connect to the internet to continue'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Add logic to retry time fetch
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpiryScreen extends StatelessWidget {
  const ExpiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Application Crashed',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('This application is no longer available',textAlign: TextAlign.center,style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text('Please contact Supplier support team to report this issue',textAlign: TextAlign.center,style: TextStyle(fontSize: 20,),),
            SizedBox(height: 20),
            Text('at support@supplieruae.com',textAlign: TextAlign.center,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            // Add your custom message here
          ],
        ),
      ),
    );
  }
}
