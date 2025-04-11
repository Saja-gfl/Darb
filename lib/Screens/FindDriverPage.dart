import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rem_s_appliceation9/Screens/DriverSelectionPage.dart';

class FindDriverPage extends StatefulWidget {
  @override
  _FindDriverPageState createState() => _FindDriverPageState();
}

class _FindDriverPageState extends State<FindDriverPage> {
  String subscriptionType = "شهري";
  DateTime? selectedDate;
  String fromLocation = "";
  String toLocation = "";
  String workLocation = "";
  List<String> selectedDays = [];
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  double priceRange = 50;
  String driverNotes = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("البحث عن سائق")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("نوع الاشتراك", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                ChoiceChip(
                  label: Text("شهري"),
                  selected: subscriptionType == "شهري",
                  onSelected: (selected) {
                    setState(() {
                      subscriptionType = "شهري";
                    });
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text("أسبوعي"),
                  selected: subscriptionType == "أسبوعي",
                  onSelected: (selected) {
                    setState(() {
                      subscriptionType = "أسبوعي";
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Text("حدد تاريخ البدء"),
            TextButton(
              onPressed: () => _selectDate(context),
              child: Text(selectedDate == null ? "اختر تاريخ" : DateFormat.yMMMMd().format(selectedDate!)),
            ),
            SizedBox(height: 10),
            Text("من"),
            TextField(
              onChanged: (value) => fromLocation = value,
              decoration: InputDecoration(border: OutlineInputBorder(), hintText: "ادخل الموقع"),
            ),
            SizedBox(height: 10),
            Text("إلى"),
            TextField(
              onChanged: (value) => toLocation = value,
              decoration: InputDecoration(border: OutlineInputBorder(), hintText: "ادخل الموقع"),
            ),
            SizedBox(height: 10),
            Text("موقع العمل"),
            TextField(
              onChanged: (value) => workLocation = value,
              decoration: InputDecoration(border: OutlineInputBorder(), hintText: "ادخل موقع العمل"),
            ),
            SizedBox(height: 10),
            Text("أيام التوصيل"),
            Wrap(
              spacing: 8,
              children: ["الأحد", "الاثنين", "الثلاثاء", "الأربعاء", "الخميس"].map((day) {
                return ChoiceChip(
                  label: Text(day),
                  selected: selectedDays.contains(day),
                  onSelected: (selected) {
                    setState(() {
                      selected ? selectedDays.add(day) : selectedDays.remove(day);
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text("الوقت"),
            Row(
              children: [
                TextButton(
                  onPressed: () => _selectTime(context, true),
                  child: Text(startTime == null ? "من" : startTime!.format(context)),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () => _selectTime(context, false),
                  child: Text(endTime == null ? "إلى" : endTime!.format(context)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text("السعر"),
            Slider(
              value: priceRange,
              min: 0,
              max: 100,
              divisions: 10,
              label: "\$${priceRange.round()}",
              onChanged: (value) {
                setState(() {
                  priceRange = value;
                });
              },
            ),
            SizedBox(height: 10),
            Text("ملاحظات السائق"),
            TextField(
              onChanged: (value) => driverNotes = value,
              decoration: InputDecoration(border: OutlineInputBorder(), hintText: "اكتب ملاحظات"),
            ),
            SizedBox(height: 20),
           ElevatedButton(
  onPressed: () {
    // لا تفعل شيء هنا
  },
  child: Text("رفع الطلب"),
),



          ],
        ),
      ),
    );
  }
}
