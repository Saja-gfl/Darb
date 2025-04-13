import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rem_s_appliceation9/widgets/app_bar/custom_dropdown.dart';

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
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController passengerCountController = TextEditingController();
  //TextEditingController subscriptionTypeController = TextEditingController();
  String selectedGender = ""; // Track the selected gender

  String? selectedLocation; // الموقع الجغرافي
  String? selectedSubscriptionType; // نوع الاشتراك
  String? acceptedLocationsController;

  final List<String> locations = [
    'بريدة', 'الرس', 'عنيزة', 'البكيرية', 'المذنب', 'البدائع' // قائمة المحاظفات
  ];

  final List<String> subscriptionTypes = ['شهري', 'أسبوعي'];

  @override
  void initState() {
    super.initState();
    _loadDriverData(); // Load the user data
  }

  // لتحميل بيانات السائق من Firestore
  Future<void> _loadDriverData() async {
    // Load the driver data from Firestore
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Fetch driver data from Firestore
        DocumentSnapshot driverData = await FirebaseFirestore.instance
            .collection('driverdata') // تغيير المسار إلى driverdata
            .doc(user.uid)
            .get();

        if (driverData.exists) {
          // Update the text controllers with the driver data
          setState(() {
            nameController.text = driverData['name'] ?? '';
            emailController.text = driverData['email'] ?? '';
            plateNumberController.text =
                driverData['plateNumber'] ?? ''; // رقم اللوحة
            carModelController.text =
                driverData['carType'] ?? ''; // نوع السيارة
            phoneController.text = driverData['phone'] ?? '';
            priceController.text =
                driverData['price']?.toString() ?? ''; // السعر
            acceptedLocationsController =
                driverData['acceptedLocations']??''; // الأماكن المقبولة
            selectedGender = driverData['gender'] ?? ''; // تحديد الجنس
            selectedLocation = driverData['location'] ?? '';
            selectedSubscriptionType = driverData['subscriptionType'] ?? '';
            passengerCountController.text =
                driverData['passengerCount']?.toString() ?? '';
          });
        }
      } catch (e) {
        print("خطأ في تحميل بيانات السائق: $e");
      }
    }
  }

// لحفظ بيانات السائق إلى Firestore
  Future<void> _saveDriverData() async {
    // Save the driver data to Firestore
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      showToast(message: "المستخدم غير مسجل الدخول");
      return;
    }

    // التحقق من ملء جميع الحقول
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        plateNumberController.text.isEmpty ||
        carModelController.text.isEmpty ||
        phoneController.text.isEmpty ||
        priceController.text.isEmpty ||
        acceptedLocationsController == null ||
        selectedGender.isEmpty ||
        selectedLocation == null ||
        passengerCountController.text.isEmpty ||
        selectedSubscriptionType == null) {
      showToast(message: "يرجى ملء جميع الحقول");
      return;
    }

    try {
      // تحديث البيانات في Firestore
      await FirebaseFirestore.instance
          .collection('driverdata')
          .doc(user.uid)
          .update({
        'name': nameController.text,
        'email': emailController.text,
        'plateNumber': plateNumberController.text, // حفظ رقم اللوحة
        'carType': carModelController.text, // حفظ نوع السيارة
        'phone': phoneController.text,
        'price': double.tryParse(priceController.text) ?? 0.0, // حفظ السعر
        'acceptedLocations': acceptedLocationsController,
        'gender': selectedGender,
        'location': selectedLocation, // حفظ الموقع الجغرافي المحدد
        'subscriptionType': selectedSubscriptionType, // حفظ نوع الاشتراك
        'passengerCount':
            int.tryParse(passengerCountController.text) ?? 0, // حفظ عدد الركاب
      });
      showToast(message: "تم حفظ البيانات بنجاح");
    } catch (e) {
      print("خطأ في حفظ بيانات السائق: $e");
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
          color: Color(0xFFFFB300),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
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

            // Location Dropdown
            CustomDropdown(
              label: "الموقع الجغرافي",
              hint: "اختر موقعك من القائمة",
              value: selectedLocation,
              items: locations,
              onChanged: (value) {
                setState(() {
                  selectedLocation = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Accepted Locations Field
            CustomDropdown(
              label: "الأماكن التي تقبل الذهاب إليها",
              hint: "أدخل الأماكن التي يمكن أن تذهب إليها )",
              value: acceptedLocationsController,
              items: locations,
              onChanged: (value) {
                setState(() {
                  acceptedLocationsController = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Price Field
            _buildInputField(
              label: "نطاق السعر",
              hint: "أدخل سعر الرحلة",
              controller: priceController,
              validationMessage: "يجب إدخال السعر",
            ),
            const SizedBox(height: 16),

            // Passenger Count Field
            _buildInputField(
              label: "عدد الركاب",
              hint: "أدخل عدد الركاب المتاحين",
              controller: passengerCountController,
              validationMessage: "يجب إدخال عدد الركاب",
            ),
            const SizedBox(height: 16),

            // Subscription Type Dropdown
            CustomDropdown(
              label: "نوع الاشتراك",
              hint: "اختر نوع الاشتراك",
              value: selectedSubscriptionType,
              items: subscriptionTypes,
              onChanged: (value) {
                setState(() {
                  selectedSubscriptionType = value;
                });
              },
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
          "معلومات السائق",
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
              _saveDriverData();
              // Save action
              //print("Selected Gender: $selectedGender");
              //print("Name: ${nameController.text}");
              //print("Email: ${emailController.text}");
              //print("Car Model: ${carModelController.text}");
              //print("Plate Number: ${plateNumberController.text}");
              //print("Phone: ${phoneController.text}");
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
