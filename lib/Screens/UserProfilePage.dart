import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("تحديث بيانات الحساب"),
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
                    backgroundColor: Colors.grey.shade300,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.blue),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            buildTextField("الاسم الكامل", "أدخل اسمك الكامل", nameController),
            buildTextField("البريد الإلكتروني", "example@example.com", emailController),
            SizedBox(height: 10),
            Text("النوع", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                genderButton("ذكر"),
                genderButton("أنثى"),
                genderButton("أفضل عدم الإجابة"),
              ],
            ),
            buildTextField("العنوان", "أدخل عنوانك", addressController),
            buildTextField("رقم الجوال", "أدخل رقم جوالك", phoneController),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    child: Text("حفظ"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: Text("إلغاء"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            accountDetails(),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          TextField(
            controller: controller,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget genderButton(String gender) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => setState(() => selectedGender = gender),
        style: OutlinedButton.styleFrom(
          backgroundColor: selectedGender == gender ? Colors.orange : Colors.white,
        ),
        child: Text(gender, style: TextStyle(color: selectedGender == gender ? Colors.white : Colors.black)),
      ),
    );
  }

  Widget accountDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("تفاصيل الحساب", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text("555-123-4567"),
          subtitle: Text("رقم الجوال"),
        ),
        ListTile(
          leading: Icon(Icons.email),
          title: Text("example@example.com"),
          subtitle: Text("البريد الإلكتروني"),
        ),
      ],
    );
  }
}
