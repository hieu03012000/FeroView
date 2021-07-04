import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  // final FirebaseMessaging _fm = FirebaseMessaging();

  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

  // Future init() async {
  //   if (Platform.isIOS) {
  //     _fm.requestNotificationPermissions(IosNotificationSettings());
  //   }

  //   _fm.configure(
  //     //call when app in foreground
  //     onMessage: (Map<String, dynamic> mess) async {
  //       print('onMessage: $mess');
  //     },
  //     //call when app close
  //     onLaunch: (Map<String, dynamic> mess) async {
  //       print('onLaunch: $mess');
  //     },
  //     //call when app in background
  //     onResume: (Map<String, dynamic> mess) async {
  //       print('onResume: $mess');
  //     },
  //   );
  // }
}
