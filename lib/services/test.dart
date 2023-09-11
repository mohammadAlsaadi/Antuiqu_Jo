// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("  background message data : ${message.data}");
  print("background message title: ${message.notification?.title}");
  print(" background message body : ${message.notification?.body}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Initialize notification channels
Future<void> initializePushNotification() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

// Handle incoming notifications without needing the 'channel' argument
void handleForegroundNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel', // Use the channel ID directly
          'High Importance Notifications',
          icon: android.smallIcon,
        ),
      ),
    );
  }
}

class FirebaseMessagingPushNotification {
  Future<void> initNotifications() async {
    final firebaseMessaging = FirebaseMessaging.instance;

    await firebaseMessaging.requestPermission();
    final fCMToken = await firebaseMessaging.getToken();
    print("Token _________:::::     $fCMToken}}");

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    initializePushNotification();
  }
}
