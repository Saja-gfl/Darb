import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverInfoPage extends StatefulWidget {
  const DriverInfoPage({super.key});

  @override
  _DriverInfoPageState createState() => _DriverInfoPageState();
}

class _DriverInfoPageState extends State<DriverInfoPage> {
  // Adding controllers for all text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String selectedGender = ""; // Track the selected gender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              hint: "ادخل اسمك الكامل",
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

            // Car Model Field
            _buildInputField(
              label: "نوع السيارة",
              hint: "أدخل نوع سيارتك",
              controller: carModelController,
              validationMessage: "يجب أدخال نوع سيارتك",
            ),
            const SizedBox(height: 16),

            // Plate Number Field
            _buildInputField(
              label: "رقم اللوحة",
              hint: "ادخل رقم لوحة سيارتك",
              controller: plateNumberController,
              validationMessage: "يجب ادخال رقم لوحة السيارة",
            ),
            const SizedBox(height: 16),

            // Phone Number Field
            _buildInputField(
              label: "رقم الجوال",
              hint: "ادخل رقم جوالك",
              controller: phoneController,
              validationMessage: "يجب ادخال رقم الجوال",
            ),
            const SizedBox(height: 24),

            // Action Buttons
            _buildActionButtons(),
            const SizedBox(height: 24),

            // Account Details
            _buildAccountDetails(),
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
          "السائق",
          style: GoogleFonts.getFont(
            'Inter',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "تحديث بيانات الحساب",
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 12,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 16),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.grey[300],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Updated Input Field with controller parameter
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
          "النوع",
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
            Expanded(
              child: _buildGenderButton(
                  "أفضل عدم الاجابة", selectedGender == "أفضل عدم الاجابة"),
            ),
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
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Cancel action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.orange,
              side: const BorderSide(color: Colors.orange),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("إلغاء"),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Save action
              print("Selected Gender: $selectedGender");
              print("Name: ${nameController.text}");
              print("Email: ${emailController.text}");
              print("Car Model: ${carModelController.text}");
              print("Plate Number: ${plateNumberController.text}");
              print("Phone: ${phoneController.text}");
            },
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

  // Account Details
  Widget _buildAccountDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "تفاصيل الحساب",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 16),
        _buildDetailRow("555-123-4567", "رقم الجوال", Icons.phone),
        const SizedBox(height: 16),
        _buildDetailRow(
            "example@example.com", "البريد الإلكتروني", Icons.email),
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