import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSoundPlayer {
  static final NotificationSoundPlayer _instance = NotificationSoundPlayer._internal();
  late AudioPlayer _player;
  bool _isInitialized = false;

  bool soundEnabled=  false;

  factory NotificationSoundPlayer() {
    return _instance;
  }

  NotificationSoundPlayer._internal() {
    _init();
  }

  Future<void> _init() async {
    _player = AudioPlayer();
    _isInitialized = true;
  }

  Future<void> playNotificationSound() async {
    if (!_isInitialized) {
      await _init();
    }

    try {
      // Play the sound from assets
      if (soundEnabled) {
        await _player.play(AssetSource('notification.mp3'));
      }
    } catch (e) {
      print('Error playing notification sound: $e');
    }
  }

  enableSound() {
    soundEnabled = true;
  }

  void disableSound() {
    soundEnabled=false;
  }
}


// Dialog to show on first load
class NotificationPermissionDialog extends StatelessWidget {
  const NotificationPermissionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enable Notification Sounds?'),
      content: const Text(
        'Would you like to enable sounds for notifications in this app?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            NotificationSoundPlayer().disableSound();
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
        ElevatedButton(
          onPressed: () async {
            await NotificationSoundPlayer().enableSound();
            // NotificationSoundPlayer().playNotificationSound();
            Navigator.of(context).pop();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}

// Helper function to show the dialog on first load
Future<void> showNotificationPermissionDialog(BuildContext context) async {
  // Check if we've shown this dialog before
  // final prefs = await SharedPreferences.getInstance();
  // final hasShownDialog = prefs.getBool('has_shown_notification_dialog') ?? false;

  // if (!hasShownDialog) {
    // Set flag to not show again
    // await prefs.setBool('has_shown_notification_dialog', true);

    // Show dialog after frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false, // User must make a choice
        builder: (context) => const NotificationPermissionDialog(),
      );
    });
  // }
}