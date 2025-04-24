import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';

class NotificationProvider with ChangeNotifier {
  // قائمة الإشعارات
  List<Map<String, String>> _notifications = [];

  List<Map<String, String>> get notifications => _notifications;

  void addNotification(Map<String, String> notification) {
    _notifications.add(notification);
    notifyListeners();
  }

  void clearNotifications() {
    _notifications.clear();
    notifyListeners();
  }

  // تحميل ملف Service Account JSON
  Future<Map<String, dynamic>> loadServiceAccount() async {
      try {
    final jsonString = await rootBundle.loadString('assets/service_account.json');
    return jsonDecode(jsonString);
  } catch (e) {
    throw Exception("❌ ملف service_account.json غير موجود في المسار المحدد.");
  }
  }

  // الحصول على Access Token
  Future<String> getAccessToken(Map<String, dynamic> serviceAccount) async {
    final accountCredentials =
        ServiceAccountCredentials.fromJson(serviceAccount);
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final authClient =
        await clientViaServiceAccount(accountCredentials, scopes);
    final accessToken = authClient.credentials.accessToken;
    return accessToken.data;
  }

  // إرسال الإشعار باستخدام Firebase Cloud Messaging API (V1)
  Future<void> sendNotificationV1({
    required String fcmToken,
    required String title,
    required String body,
  }) async {
    try {
      final serviceAccount = await loadServiceAccount();
      final url =
          'https://fcm.googleapis.com/v1/projects/${serviceAccount['project_id']}/messages:send';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await getAccessToken(serviceAccount)}',
        },
        body: jsonEncode({
          'message': {
            'token': fcmToken,
            'notification': {
              'title': title,
              'body': body,
            },
          },
        }),
      );

      if (response.statusCode == 200) {
        print('✅ Notification sent successfully');
        addNotification({'title': title, 'body': body});
      } else {
        print('❌ Failed to send notification: ${response.body}');
      }
    } catch (e) {
      print('❌ Error sending notification: $e');
    }
  }

  // واجهة سهلة الاستخدام لإرسال الإشعارات
  Future<void> sendFCMNotificationV1(
      String fcmToken, String title, String body) async {
    await sendNotificationV1(
      fcmToken: fcmToken,
      title: title,
      body: body,
    );
  }
}
