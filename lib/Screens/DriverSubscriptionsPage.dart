import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/NotifProvider .dart';
import '../services/UserProvider.dart';
import '../services/ChatService.dart';
import '../services/Firestore.dart';

class DriverSubscriptionsPage extends StatelessWidget {
  const DriverSubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = Provider.of<UserProvider>(context, listen: false).uid;

    return Scaffold(
      appBar: AppBar(title: const Text("طلبات الاشتراك")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('rideRequests')
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
                child: Text(
                  'طلبات معلقة:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
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
                      return const SizedBox();
                    }
                    if (!userSnapshot.hasData ||
                        userSnapshot.data!.docs.isEmpty) {
                      return const SizedBox();
                    }
                    return Column(
                      children: userSnapshot.data!.docs.map((userDoc) {
                        return SubscriptionTile(
                          doc: doc,
                          userDoc: userDoc,
                          isPending: true,
                          driverId: currentUserId ?? '',
                        );
                      }).toList(),
                    );
                  },
                );
              }).toList(),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'اشتراكات جارية:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
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
                      return const SizedBox();
                    }
                    if (!userSnapshot.hasData ||
                        userSnapshot.data!.docs.isEmpty) {
                      return const SizedBox();
                    }
                    return Column(
                      children: userSnapshot.data!.docs.map((userDoc) {
                        return SubscriptionTile(
                          doc: doc,
                          userDoc: userDoc,
                          isPending: false,
                          driverId: currentUserId ?? '',
                        );
                      }).toList(),
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
  final QueryDocumentSnapshot userDoc;
  final bool isPending;
  final String driverId;

  const SubscriptionTile({
    super.key,
    required this.doc,
    required this.userDoc,
    required this.isPending,
    required this.driverId,
  });

  void acceptSubscription(BuildContext context) async {
    try {
      final tripId = doc.id;
      final passengerId = userDoc.id;

      await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .update({'status': 'نشط', 'driverId': driverId});

      await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .collection('users')
          .doc(passengerId)
          .update({'sub_status': 'نشط'});

      final chatService = ChatService();
      await chatService.createChatRoom(tripId, driverId, passengerId);

      await FirestoreService.addTripIdToUser(passengerId, tripId);

      final passengerDoc = await FirebaseFirestore.instance
          .collection('userdata')
          .doc(passengerId)
          .get();

      final fcmToken = passengerDoc['fcmToken'];

      if (fcmToken != null) {
        final notificationProvider =
            Provider.of<NotificationProvider>(context, listen: false);
        await notificationProvider.sendFCMNotificationV1(
          fcmToken,
          'تم قبول الاشتراك',
          'تم إضافتك للرحلة من قبل السائق.',
        );
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("تم قبول الاشتراك.")));
    } catch (e) {
      print("خطأ أثناء القبول: $e");
    }
  }

  void rejectSubscription(BuildContext context) async {
    try {
      final tripId = doc.id;
      final passengerId = userDoc.id;

      await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .collection('users')
          .doc(passengerId)
          .update({'sub_status': 'مرفوض'});

      final passengerDoc = await FirebaseFirestore.instance
          .collection('userdata')
          .doc(passengerId)
          .get();

      final fcmToken = passengerDoc['fcmToken'];

      if (fcmToken != null) {
        final notificationProvider =
            Provider.of<NotificationProvider>(context, listen: false);
        await notificationProvider.sendFCMNotificationV1(
          fcmToken,
          'تم رفض الاشتراك',
          'تم رفض طلبك من قبل السائق.',
        );
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("تم رفض الاشتراك.")));
    } catch (e) {
      print("خطأ أثناء الرفض: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = userDoc.data() as Map<String, dynamic>;
    final subscription = data['subscriptionData'] ?? {};

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الراكب: ${data['userId']}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isPending
                    ? Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check_circle,
                                color: Colors.green),
                            onPressed: () => acceptSubscription(context),
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () => rejectSubscription(context),
                          ),
                        ],
                      )
                    : const Icon(Icons.check, color: Colors.green),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "نوع الاشتراك: ${subscription['subscriptionType'] ?? 'غير محدد'}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              "من: ${subscription['fromLocation'] ?? '؟'} إلى: ${subscription['toLocation'] ?? '؟'}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              "السعر: ${subscription['price'] ?? '؟'}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              "عدد الأيام: ${subscription['days']?.length ?? 0} يوم",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
