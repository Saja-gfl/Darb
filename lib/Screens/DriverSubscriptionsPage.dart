import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/UserProvider.dart';

class DriverSubscriptionsPage extends StatefulWidget {
  const DriverSubscriptionsPage({super.key});

  @override
  State<DriverSubscriptionsPage> createState() =>
      _DriverSubscriptionsPageState();
}


class _DriverSubscriptionsPageState extends State<DriverSubscriptionsPage> {

@override
Widget build(BuildContext context) {
  final currentUserId =
      Provider.of<UserProvider>(context, listen: false).uid;

  return Scaffold(
    appBar: AppBar(title: const Text("طلبات الاشتراك")),
    body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('rideRequests')
          .where('driverId', isEqualTo: currentUserId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: CircularProgressIndicator());
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
          return const Center(child: Text('لا يوجد اشتراكات حالياً.'));

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
                    return const SizedBox();
                  }
                  if (!userSnapshot.hasData ||
                      userSnapshot.data!.docs.isEmpty) {
                    return const SizedBox();
                  }
                  return SubscriptionTile(doc: doc, isPending: true);
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
                    return const SizedBox();
                  }
                  if (!userSnapshot.hasData ||
                      userSnapshot.data!.docs.isEmpty) {
                    return const SizedBox();
                  }
                  return SubscriptionTile(doc: doc, isPending: false);
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

  const SubscriptionTile(
      {super.key, required this.doc, required this.isPending});

  void acceptSubscription(BuildContext context) async {
    try {
      final tripId = doc.id;

      // جلب بيانات الراكب
      // جلب بيانات المستخدم من المجموعة الفرعية "users"
      final userSnapshot = await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .collection('users')
          .where('sub_status', isEqualTo: 'معلق') // التأكد من الحالة
          .limit(1)
          .get();

      if (userSnapshot.docs.isEmpty) {
        print("لا يوجد مستخدمين في هذه المجموعة الفرعية.");
      }

      final userDoc = userSnapshot.docs.first;
      // جلب بيانات الرحلة
      final tripData = await FirebaseFirestore.instance
          .collection('rideRequests')
          .doc(tripId)
          .get();
      final tripStatus = tripData['status'];

      // تحديث حالة الرحلة إلى "نشط" إذا لم تكن بالفعل "نشط"
      if (tripStatus != 'نشط') {
        await FirebaseFirestore.instance
            .collection('rideRequests')
            .doc(tripId)
            .update({
          'status': 'نشط',
          'driverId': Provider.of<UserProvider>(context, listen: false).uid ??
              'غير معروف',
        });
      }

      await FirebaseFirestore.instance
          .collection('rideRequests') //('subscriptionRequests')
          .doc(tripId)
          .collection('users')
          .doc(userDoc['userId']) // استخدام userId بدلاً من tripId
          .update({
        'sub_status': 'نشط',
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("تم قبول الاشتراك.")));
    } catch (e) {
      print("خطأ أثناء القبول: $e");
      print('tripId: ${doc.id}');
      print('userId: ${doc['userId']}'); //
    }
  }

  void rejectSubscription(BuildContext context) async {
    try {
      final tripId = doc.id;

    // جلب بيانات الراكب
    final userSnapshot = await FirebaseFirestore.instance
        .collection('rideRequests')
        .doc(tripId)
        .collection('users')
        .where('sub_status', isEqualTo: 'معلق') // التأكد من الحالة
        .limit(1)
        .get();

    if (userSnapshot.docs.isEmpty) {
      throw Exception('لم يتم العثور على المستخدم داخل المجموعة الفرعية users');
    }
        final userDoc = userSnapshot.docs.first;

      //تحديث حالة اشتراك اليوزر إلى "مرفوض"
      await FirebaseFirestore.instance
          .collection('rideRequests') //('subscriptionRequests')
          .doc(tripId)
          .collection('users')
          .doc(userDoc['userId']) // استخدام userId بدلاً من tripId
          .update({
        'sub_status': 'مرفوض',
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("تم رفض الاشتراك.")));
    } catch (e) {
      print("خطأ أثناء الرفض: $e");
      print('tripId: ${doc.id}'); // طباعة tripId للمساعدة في تصحيح الأخطاء
      print(
          'doc: ${doc.data()}'); // طباعة بيانات الوثيقة للمساعدة في تصحيح الأخطاء
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = doc.data() as Map<String, dynamic>;
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
              style: GoogleFonts.tajawal(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            isPending
                ? Row(
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
