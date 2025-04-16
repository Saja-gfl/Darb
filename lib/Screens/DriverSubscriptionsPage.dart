import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DriverSubscriptionsPage extends StatefulWidget {
  const DriverSubscriptionsPage({super.key});

  @override
  State<DriverSubscriptionsPage> createState() => _DriverSubscriptionsPageState();
}

class _DriverSubscriptionsPageState extends State<DriverSubscriptionsPage> {
  final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? "legJfO1wakMmTmUvGtQjNny7yGW2"; // 🔄 بدل testuser بـ uid الحقيقي

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("طلبات الاشتراك")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('subscriptionRequests')
            .where('driverId', isEqualTo: currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text('لا يوجد اشتراكات حالياً.'));

          final docs = snapshot.data!.docs;

          final pending = docs.where((doc) => doc['status'] == 'معلق').toList();
          final active = docs.where((doc) => doc['status'] == 'نشط').toList();

          return ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('طلبات معلقة:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ...pending.map((doc) => SubscriptionTile(doc: doc, isPending: true)).toList(),

              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('اشتراكات جارية:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ...active.map((doc) => SubscriptionTile(doc: doc, isPending: false)).toList(),
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

  const SubscriptionTile({super.key, required this.doc, required this.isPending});

  void acceptSubscription(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('subscriptionRequests')
          .doc(doc.id)
          .update({
        'sub_status': 'نشط',
        'driverId': FirebaseAuth.instance.currentUser?.uid ?? 'legJfO1wakMmTmUvGtQjNny7yGW2',
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم قبول الاشتراك.")));
    } catch (e) {
      print("خطأ أثناء القبول: $e");
    }
  }

  void rejectSubscription(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('subscriptionRequests')
          .doc(doc.id)
          .update({'sub_status': 'مرفوض'});

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم رفض الاشتراك.")));
    } catch (e) {
      print("خطأ أثناء الرفض: $e");
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
            Text("نوع الاشتراك: ${subscription['subscriptionType'] ?? 'غير محدد'}"),
            Text("من: ${subscription['fromLocation'] ?? '؟'} إلى: ${subscription['toLocation'] ?? '؟'}"),
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
