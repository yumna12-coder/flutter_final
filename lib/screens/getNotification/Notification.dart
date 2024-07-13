import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleMessaging(RemoteMessage message) async {
  print('Title ${message.notification?.title}');
}

class FirebaseMessagingToProject {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    print("Token: $token");

    FirebaseMessaging.onBackgroundMessage(handleMessaging);
  }
}
