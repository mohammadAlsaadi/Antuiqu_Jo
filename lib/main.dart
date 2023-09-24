// ignore_for_file: unused_local_variable, non_constant_identifier_names, avoid_print, unnecessary_import

import 'package:antique_jo/screen/cusromer_home/customer_home_screen.dart';
import 'package:antique_jo/screen/owner_home/owner_home_screen.dart';
import 'package:antique_jo/screen/type_of_user/type_of_user_screen.dart';
import 'package:antique_jo/shared_prefrence_manager/shared_prefrence_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

FirebaseMessaging messaging = FirebaseMessaging.instance;

void _handleMessage(RemoteMessage message) {
  final notification = message.notification;
  if (notification != null) {
    final title = notification.title;
    final body = notification.body;

    // Display the notification using Flutter Local Notifications
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_ID',
      'channel name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    flutterLocalNotificationsPlugin.show(
      0, // Notification ID (change this for each notification)
      title,
      body,
      platformChannelSpecifics,
      payload: 'notification_data',
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _handleMessage(message);
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Fixed constructor

  Future<String?> getCurrentUID() async {
    Future<String?> currentUID =
        SharedPreferenceManager.getString(key: 'currentUID');

    return currentUID;
  }

  Future<String?> getCurrentType() async {
    String? currentType =
        await SharedPreferenceManager.getString(key: 'currentType');

    return currentType;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String?>(
        future: getCurrentUID(),
        builder: (context, uidSnapshot) {
          if (uidSnapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          String? currentUID = uidSnapshot.data;

          if (currentUID != "null") {
            return FutureBuilder<String?>(
              future: getCurrentType(),
              builder: (context, typeSnapshot) {
                if (typeSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                String? currentType = typeSnapshot.data;

                if (currentType == 'owner') {
                  return const OwnerHomePage(
                    isOwner: true,
                  );
                } else if (currentType == 'customer') {
                  return const CustomerHomePage(
                    isOwner: false,
                  );
                } else {
                  return const TypeOfUser();
                }
              },
            );
          } else {
            return const TypeOfUser();
          }
        },
      ),
    );
  }
}
