import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rem_s_appliceation9/Screens/subpage.dart'; // Import for SubPage


class ActiveSubscriptionsPage extends StatefulWidget {
  @override
  _ActiveSubscriptionsPageState createState() => _ActiveSubscriptionsPageState();
}

class _ActiveSubscriptionsPageState extends State<ActiveSubscriptionsPage> {
  String? selectedType;
  String? selectedFrom;
  String? selectedTo;
  double? maxPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' قائمة اشتراكات جارية')),
      body: Column(
        children: [
          buildFilters(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('rideRequests')
                  .where('status', isEqualTo: 'معلق')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                final filteredDocs = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return (selectedType == null || data['type'] == selectedType) &&
                      (selectedFrom == null || data['fromLocation'] == selectedFrom) &&
                      (selectedTo == null || data['toLocation'] == selectedTo) &&
                      (maxPrice == null || data['price'] <= maxPrice);
                }).toList();

if (filteredDocs.isEmpty) {
  Future.microtask(() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateSubscriptionPage()),
    );
  });
  return Center(child: Text('لا توجد اشتراكات مطابقة'));
}


                return ListView.builder(
                  itemCount: filteredDocs.length,
                  itemBuilder: (context, index) {
                    final data = filteredDocs[index].data() as Map<String, dynamic>;
                    final tripId = data['tripId'];
                    return Card(
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('نوع الاشتراك: ${data['type']}', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('من: ${data['fromLocation']}'),
                            Text('إلى: ${data['toLocation']}'),
                            Text('الموقع الوظيفي: ${data['workLocation']}'),
                            Text('السعر: ${data['price']} ريال'),
                            Text('الجدول: ${data['schedule']}'),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => joinRequest(tripId),
                              child: Text('انضمام'),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilters() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: buildDropdown<String>('نوع الاشتراك', ['يومي', 'أسبوعي'], selectedType, (val) => setState(() => selectedType = val))),
              SizedBox(width: 8),
              Expanded(child: buildDropdown<String>('من', ['الرياض', 'جدة', 'مكة'], selectedFrom, (val) => setState(() => selectedFrom = val))),
              SizedBox(width: 8),
              Expanded(child: buildDropdown<String>('إلى', ['الجامعة', 'العمل'], selectedTo, (val) => setState(() => selectedTo = val))),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: 'الحد الأقصى للسعر', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  onChanged: (val) => setState(() => maxPrice = double.tryParse(val)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildDropdown<T>(String label, List<T> items, T? selected, void Function(T?) onChanged) {
    return DropdownButtonFormField<T>(
      value: selected,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text(e.toString()))).toList(),
      onChanged: onChanged,
    );
  }

  Future<void> joinRequest(String tripId) async {
    // هنا تحط منطق الانضمام بناء على tripId
    // مثلاً إضافة المستخدم الحالي إلى rideRequests/{tripId}/users

    // افتراضياً معرف المستخدم موجود في مكان آخر
    final userId = 'user_id_from_provider_or_auth';
    final userName = 'user_name_from_provider';
    final userPhone = 'user_phone_from_provider';

    await FirebaseFirestore.instance
        .collection('rideRequests')
        .doc(tripId)
        .collection('users')
        .doc(userId)
        .set({
      'userId': userId,
      'userName': userName,
      'userphone': userPhone,
      'sub_status': 'معلق',
      'createdAt': Timestamp.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم إرسال طلب الانضمام')));
  }
} 
