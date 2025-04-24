import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rem_s_appliceation9/services/FireStore.dart';

import '../services/ChatService.dart';
import '../services/NotifProvider .dart';
import '../services/UserProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DriverSubscriptionsPage extends StatefulWidget {
  const DriverSubscriptionsPage({super.key});

  @override
  State<DriverSubscriptionsPage> createState() =>
      _DriverSubscriptionsPageState();
}
// انتباه هذي الصفحة مخصصة فقط للاختبار
//!! احذفو الصفحة فقط بعد تنفيد الكومنت اللي في درايفر هوم !!

class _DriverSubscriptionsPageState extends State<DriverSubscriptionsPage> {
  final currentUserId = FirebaseAuth.instance.currentUser?.uid ??
      "legJfO1wakMmTmUvGtQjNny7yGW2"; // 🔄 بدل testuser بـ uid الحقيقي

  @override
  Widget build(BuildContext context) {
    final driverId =
        Provider.of<UserProvider>(context, listen: false).uid ?? 'غير معروف';

    return Scaffold(
      appBar: AppBar(title: const Text("طلبات الاشتراك")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('rideRequests') //('subscriptionRequests')
            .where('driverId', isEqualTo: currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('لا يوجد اشتراكات حالياً.'));
          }

          final docs = snapshot.data!.docs;

          return ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('طلبات معلقة:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ...docs.map((doc) {
                return FutureBuilder<QuerySnapshot>(
                  future: doc.reference
                      .collection('users')
                      .where('sub_status', isEqualTo: 'معلق')
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const SizedBox(); // عرض عنصر فارغ أثناء التحميل
                    }
                    if (!userSnapshot.hasData ||
                        userSnapshot.data!.docs.isEmpty) {
                      return const SizedBox(); // لا يوجد طلبات معلقة
                    }
                    return SubscriptionTile(
                      doc: doc,
                      isPending: true,
                      driverId: driverId,
                    );
                  },
                );
              }).toList(),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('اشتراكات جارية:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ...docs.map((doc) {
                return FutureBuilder<QuerySnapshot>(
                  future: doc.reference
                      .collection('users')
                      .where('sub_status', isEqualTo: 'نشط')
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const SizedBox(); // عرض عنصر فارغ أثناء التحميل
                    }
                    if (!userSnapshot.hasData ||
                        userSnapshot.data!.docs.isEmpty) {
                      return const SizedBox(); // لا يوجد اشتراكات جارية
                    }
                    return SubscriptionTile(
                      doc: doc,
                      isPending: false,
                      driverId: driverId,
                    );
                  },
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}

class SubscriptionTile extends StatelessWidget {
  final QueryDocumentSnapshot doc;
  final bool isPending;
  final String driverId;

  const SubscriptionTile({
    super.key,
    required this.doc,
    required this.isPending,
    required this.driverId,
  });

  void acceptSubscription(BuildContext context) async {
    try {
      final tripId = doc.id;

      // جلب بيانات المستخدم من المجموعة الفرعية "users"
      final userSnapshot = await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .collection('users')
          .where('sub_status', isEqualTo: 'معلق') // التأكد من الحالة
          .limit(1)
          .get();

      if (userSnapshot.docs.isEmpty) {
        throw Exception("لا يوجد مستخدمين في هذه المجموعة الفرعية.");
      }

      final userDoc = userSnapshot.docs.first;

      if (!userDoc.data().containsKey('userId')) {
        throw Exception("الحقل 'userId' غير موجود في الوثيقة.");
      }

      final passengerId = userDoc['userId'] as String;

      // جلب بيانات الرحلة
      final tripData = await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .get();

      if (!tripData.data()!.containsKey('status')) {
        throw Exception("الحقل 'status' غير موجود في بيانات الرحلة.");
      }

      final tripStatus = tripData['status'];

      // تحديث حالة الرحلة إلى "نشط" إذا لم تكن بالفعل "نشط"
      if (tripStatus != 'نشط') {
        await FirebaseFirestore.instance
            .collection('rideRequests')
            .doc(tripId)
            .update({
          'status': 'نشط',
          'driverId': driverId,
        });
      }

      // تحديث حالة اشتراك المستخدم
      await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .collection('users')
          .doc(passengerId)
          .update({
        'sub_status': 'نشط',
      });
      // notification
      /*  await FirebaseFirestore.instance
    .collection('userdata')
    .doc(passengerId)
    .collection('notifications')
    .add({
  'title': 'تم قبول الاشتراك',
  'message': '${tripData['driverData']['name']}  فاير بيس تم إضافتك للرحلة مع السائق',
  'timestamp': FieldValue.serverTimestamp(),
});*/

      // إنشاء غرفة دردشة جديدة
      final chatService = ChatService();
      await chatService.createChatRoom(tripId, driverId, passengerId);

      // إضافة tripId إلى بيانات المستخدم
      await FirestoreService.addTripIdToUser(passengerId, tripId);

      // جلب fcmToken الخاص بالراكب
      final passengerDoc = await FirebaseFirestore.instance
          .collection('userdata')
          .doc(passengerId)
          .get();

      final fcmToken = passengerDoc['fcmToken'];

      if (fcmToken != null) {
        // إرسال الإشعار باستخدام NotificationProvider
        final notificationProvider =
            Provider.of<NotificationProvider>(context, listen: false);
        await notificationProvider.sendFCMNotificationV1(
          fcmToken,
          'تم قبول الاشتراك',
          '${tripData['driverData']['name']} تم اضافتك للرحله من قبل السائق ',
        );

        notificationProvider.addNotification({
          'title': 'تم قبول الاشتراك',
          'body':
              '${tripData['driverData']['name']} تم اضافتك للرحله من قبل السائق ',
          'time': DateTime.now().toString(),
        });
      } else {
        print("❌ لا يوجد fcmToken لهذا الراكب.");
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("تم قبول الاشتراك.")));
    } catch (e) {
      print("خطأ أثناء القبول: $e");
      print('tripId: ${doc.id}');
    }
  }

  void rejectSubscription(BuildContext context) async {
    try {
      final tripId = doc.id;

      // جلب بيانات الرحلة
      final tripData = await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .get();

      // جلب بيانات المستخدم
      final userSnapshot = await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .collection('users')
          .where('sub_status', isEqualTo: 'معلق') // التأكد من الحالة
          .limit(1)
          .get();

      if (userSnapshot.docs.isEmpty) {
        throw Exception(
            "لم يتم العثور على المستخدم داخل المجموعة الفرعية users");
      }

      final userDoc = userSnapshot.docs.first;

      if (!userDoc.data().containsKey('userId')) {
        throw Exception("الحقل 'userId' غير موجود في الوثيقة.");
      }

      final passengerId = userDoc['userId'] as String;

      // تحديث حالة اشتراك المستخدم إلى "مرفوض"
      await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .collection('users')
          .doc(passengerId)
          .update({
        'sub_status': 'مرفوض',
      });

      // إرسال الإشعار الفوري
      final notificationProvider =
          Provider.of<NotificationProvider>(context, listen: false);
      await notificationProvider.sendFCMNotificationV1(
        passengerId,
        'تم رفض الاشتراك',
        '${tripData['driverData']['name']} تم رفض اشتراكك من قبل السائق ',
      );

      /*//notification to user
      await FirebaseFirestore.instance
          .collection('userdata')
          .doc(passengerId)
          .collection('notifications')
          .add({
        'title': 'تم رفض الاشتراك',
        'message': '${tripData['driverData']['name']} تم رفض اشتراكك من قبل السائق',
        'timestamp': FieldValue.serverTimestamp(),
      });

    // notification
    final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
        notificationProvider.addNotification({
       'title': 'تم رفض الاشتراك',
        'body':  '${tripData['driverData']['name']} تم رفض اشتراكك من قبل السائق ',
        'time': DateTime.now().toString(),
        });*/
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("تم رفض الاشتراك.")));
    } catch (e) {
      print("خطأ أثناء الرفض: $e");
      print('tripId: ${doc.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = doc.data() as Map<String, dynamic>;
    final subscription = data['subscriptionData'] ?? {};

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text("الراكب: ${data['userId']}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "نوع الاشتراك: ${subscription['subscriptionType'] ?? 'غير محدد'}"),
            Text(
                "من: ${subscription['fromLocation'] ?? '؟'} إلى: ${subscription['toLocation'] ?? '؟'}"),
            Text("السعر: ${subscription['price'] ?? '؟'}"),
            Text("عدد الأيام: ${subscription['days']?.length ?? 0} يوم"),
          ],
        ),
        trailing: isPending
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check_circle, color: Colors.green),
                    onPressed: () => acceptSubscription(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    onPressed: () => rejectSubscription(context),
                  ),
                ],
              )
            : const Icon(Icons.check, color: Colors.green),
      ),
    );
  }
}
