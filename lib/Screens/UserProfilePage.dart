import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:google_fonts/google_fonts.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

=======

class UserProfilePage extends StatefulWidget {
>>>>>>> Stashed changes
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
<<<<<<< Updated upstream
  String selectedGender = ""; // Track the selected gender
=======
  String? selectedGender;
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< Updated upstream
      backgroundColor: Colors.white,
=======
>>>>>>> Stashed changes
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
<<<<<<< Updated upstream
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
            _buildAccountDetails(),
=======
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
>>>>>>> Stashed changes
          ],
        ),
      ),
    );
  }

<<<<<<< Updated upstream
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
=======
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
>>>>>>> Stashed changes
      ),
    );
  }

<<<<<<< Updated upstream
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
=======
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
>>>>>>> Stashed changes
        ),
      ],
    );
  }
}
