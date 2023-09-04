import 'dart:convert';
import 'package:http/http.dart' as http;

class FirebaseMessageApi {
  static Future<void> sendFCMNotification({
    required String titleMessage,
    required String bodyMessage,
  }) async {
    String serverKey =
        'AAAATIlq1vA:APA91bEKi-mpIaXfAjVWLEgFAfXm15vvSesPwBHe6XbVx6mLRfXJ-sfVAfrOa9AMd63RvbXHC69vB43LMztam7S0XeiW4J4PFbB2HnAFG8v_MSNc0Unr9nMKwWclNC_CKThloGI2StWG';

    String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

    Map<String, dynamic> notificationData = {
      'to':
          'cai4uIc9SJa1XEEo_LG9ND:APA91bECaSV9a3cFzzVVo_BY1dSUmWp7OmnoE6xtVJPiaMexgGbyp9XwlEQBPCfreX6k7msc5z9ryUzThld_wqEZLKgTS3245WMRiNiQ9YbmFYrpH91SKsWJrBbB1ewYa3LV5cTU2TBs',
      'notification': {
        'title': titleMessage,
        'body': bodyMessage,
      },
      'data': {},
    };

    // Convert the payload to JSON
    String notificationJson = jsonEncode(notificationData);

    // Set up the HTTP headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    // Send the HTTP POST request to FCM
    final response = await http.post(Uri.parse(fcmUrl),
        headers: headers, body: notificationJson);

    // Check the response status code
    if (response.statusCode == 200) {
      print('FCM notification sent successfully');
    } else {
      print('Failed to send FCM notification');
      print('Response: ${response.body}');
    }
  }
}
