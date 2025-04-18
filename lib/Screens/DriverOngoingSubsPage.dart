// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class DriverOngoingSubsPage extends StatefulWidget {
//   const DriverOngoingSubsPage({Key? key}) : super(key: key);

//   @override
//   _DriverOngoingSubsPageState createState() => _DriverOngoingSubsPageState();
// }


// //احذفوا الصفحة


// class _DriverOngoingSubsPageState extends State<DriverOngoingSubsPage> {
//   late final String driverId;

//   @override
//   void initState() {
//     super.initState();
//     driverId = FirebaseAuth.instance.currentUser?.uid ?? "legJfO1wakMmTmUvGtQjNny7yGW2"; // ✅ يفضل تتحقق من تسجيل الدخول
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("طلبات الاشتراك والرحلات"),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('subscriptionRequests')
//             .where('driverId', isEqualTo: driverId)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) return Text("حدث خطأ: ${snapshot.error}");
//           if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());

//           final docs = snapshot.data!.docs;

//           final pendingSubs = docs.where((doc) => doc['status'] == 'معلق').toList();
//           final activeSubs = docs.where((doc) => doc['status'] == 'نشط').toList();

//           return SingleChildScrollView(
//             child: Column(
//               children: [
//                 Text("الطلبات المعلقة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 ...pendingSubs.map((doc) => ListTile(
//                       title: Text("طلب من ${doc['userId']}"),
//                       subtitle: Text("رقم الرحلة: ${doc.id}"),
//                       trailing: ElevatedButton(
//                         child: Text("قبول"),
//                         onPressed: () => _acceptSubscription(doc.id),
//                       ),
//                     )),
//                 Divider(),
//                 Text("الرحلات الجارية", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 ...activeSubs.map((doc) => ListTile(
//                       title: Text("رحلة: ${doc.id}"),
//                       subtitle: Text("ركاب: ${(doc['passengers'] ?? []).join(', ')}"),
//                     )),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<void> _acceptSubscription(String tripId) async {
//     try {
//       final docRef = FirebaseFirestore.instance.collection('subscriptionRequests').doc(tripId);

//       await docRef.update({
//         'status': 'نشط',
//         'driverId': driverId,
//         'vehicle': 'كامري 2020', // ← هنا تحط بيانات السائق حسب المتوفر
//         'capacity': 4,
//       });

//       print("تم قبول الاشتراك.");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("تم قبول الراكب.")),
//       );
//     } catch (e) {
//       print("خطأ أثناء قبول الاشتراك: $e");
//     }
//   }
// }
