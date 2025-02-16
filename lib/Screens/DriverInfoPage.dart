import 'package:flutter/material.dart';

class DriverInfoPage extends StatefulWidget {
  @override
  _DriverInfoPageState createState() => _DriverInfoPageState();
}

class _DriverInfoPageState extends State<DriverInfoPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();

  String selectedGender = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تحديث بيانات السائق"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.blue),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            buildTextField("الاسم الكامل", "أدخل اسمك الكامل", fullNameController),
            buildTextField("البريد الإلكتروني", "example@example.com", emailController),
            Text("النوع", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildGenderButton("ذكر"),
                buildGenderButton("أنثى"),
                buildGenderButton("أفضل عدم الإجابة"),
              ],
            ),
            buildTextField("العنوان", "أدخل عنوانك", addressController),
            buildTextField("رقم الجوال", "أدخل رقم الجوال", phoneController),
            buildTextField("موديل السيارة", "أدخل موديل السيارة", carModelController),
            buildTextField("رقم اللوحة", "أدخل رقم اللوحة", plateNumberController),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text("إلغاء", style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    child: Text("حفظ", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGenderButton(String gender) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedGender = gender;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedGender == gender ? Colors.orange : Colors.grey[300],
        ),
        child: Text(gender, style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
