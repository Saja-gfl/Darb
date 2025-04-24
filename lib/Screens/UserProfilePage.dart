import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rem_s_appliceation9/services/UserProvider.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String selectedGender = ""; // Track the selected gender

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load the user data from UserProvider
  }

  // Load user data from UserProvider
  void _loadUserData() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      nameController.text = userProvider.userName ?? '';
      emailController.text = userProvider.email ?? '';
      addressController.text = userProvider.location ?? '';
      phoneController.text = userProvider.phoneNumber ?? '';
      selectedGender = userProvider.Gender ?? 'ذكر';
    });
  }

  //save user data
  Future<void> _saveUserData() async {
    // Save the user data to Firestore
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      showToast(message: "المستخدم غير مسجل الدخول");
      return;
    }

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        addressController.text.isEmpty ||
        phoneController.text.isEmpty ||
        selectedGender.isEmpty) {
      showToast(message: "يرجى ملء جميع الحقول");
      return;
    }

    try {
      // Update Firestore
      await FirebaseFirestore.instance
          .collection('userdata')
          .doc(user.uid)
          .update({
        'name': nameController.text,
        'email': emailController.text,
        'address': addressController.text,
        'phone': phoneController.text,
        'gender': selectedGender,
      });

      // Update UserProvider
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUserName(nameController.text);
      userProvider.setEmail(emailController.text);
      userProvider.setLocation(addressController.text);
      userProvider.setPhoneNumber(phoneController.text);

      showToast(message: "تم حفظ البيانات بنجاح");
    } catch (e) {
      print("خطأ في حفظ بيانات المستخدم: $e");
      showToast(message: "حدث خطأ أثناء حفظ البيانات");
    }
  }

  void showToast({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFFFFB300), // Set the color of the back arrow icon
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Profile Section
            _buildProfileSection(),
            const SizedBox(height: 24),

            // Full Name Field
            _buildInputField(
              label: "الاسم الكامل",
              hint: "أدخل اسمك الكامل",
              controller: nameController,
              validationMessage: "يجب ادخال الاسم بالكامل",
            ),
            const SizedBox(height: 16),

            // Email Field
            _buildInputField(
              label: "البريد الإلكتروني",
              hint: "example@example.com",
              controller: emailController,
              validationMessage: "قم بإدخال بريدك الإلكتروني",
            ),
            const SizedBox(height: 16),

            // Gender Selection
            _buildGenderSelection(),
            const SizedBox(height: 16),

            // Address Field
            _buildInputField(
              label: "العنوان",
              hint: "أدخل عنوانك",
              controller: addressController,
              validationMessage: "يجب ادخال العنوان",
            ),
            const SizedBox(height: 16),

            // Phone Number Field
            _buildInputField(
              label: "رقم الجوال",
              hint: "أدخل رقم جوالك",
              controller: phoneController,
              validationMessage: "يجب ادخال رقم الجوال",
            ),
            const SizedBox(height: 24),

            // Action Buttons
            _buildActionButtons(),
            const SizedBox(height: 24),

            // Account Details
          ],
        ),
      ),
    );
  }

  // Profile Section
  Widget _buildProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "أسم العميل",
          style: GoogleFonts.getFont(
            'Inter',
            color: const Color(0xFFFFB300),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.grey[200],
              child: Icon(
                Icons.person,
                size: 48,
                color: const Color.fromARGB(255, 255, 178, 25),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Input Field
  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String validationMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFFFFB300),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 14,
              fontFamily: 'Roboto',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xFFFFB300),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          validationMessage,
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 12,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    );
  }

  // Gender Selection
  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "الجنس",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildGenderButton("ذكر", selectedGender == "ذكر"),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildGenderButton("أنثى", selectedGender == "أنثى"),
            ),
            const SizedBox(width: 8),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "يرجى تحديد النوع",
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 12,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    );
  }

  // Gender Button
  Widget _buildGenderButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = text; // Update the selected gender
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color:
              isSelected ? Color(0xFFFFB300) : Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 14,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }

  // Action Buttons
  Widget _buildActionButtons() {
    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _saveUserData,
            // Save action
            //print("Selected Gender: $selectedGender");
            //_saveUserData,

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("حفظ"),
          ),
        ),
      ],
    );
  }

  // Detail Row
  Widget _buildDetailRow(String value, String label, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.orange,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.orange,
            fontSize: 14,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: Colors.orange,
            size: 20,
          ),
        ),
      ],
    );
  }
}
