import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // طلب الإذن للإشعارات (iOS فقط)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('تم السماح بالإشعارات!');
    } else {
      print('لم يتم السماح بالإشعارات.');
    }

    // الحصول على الـ FCM Token
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    // التعامل مع الإشعارات أثناء تشغيل التطبيق
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message: ${message.notification?.title}');
      // يمكنك هنا عرض الإشعار أو التعامل معه
    });

    // التعامل مع الإشعارات عند فتح التطبيق من الإشعار
   
  }
}