import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rem_s_appliceation9/Screens/DriverSelectionPage.dart';
import 'package:rem_s_appliceation9/Screens/number_sub.dart';
import 'package:geolocator/geolocator.dart';

class CreateSubscriptionPage extends StatefulWidget {
  const CreateSubscriptionPage({super.key});

  @override
  _CreateSubscriptionPageState createState() => _CreateSubscriptionPageState();
}

class _CreateSubscriptionPageState extends State<CreateSubscriptionPage> {
  String selectedSubscriptionType = "شهري";
  DateTime? subscriptionStartDate;
  String? fromLocation;
  String? toLocation;
  String? homeLocation;
  String? workLocation;
  List<Map<String, dynamic>> scheduleDays = [];
  double price = 0;
  String driverNotes = "";
  TextEditingController priceController = TextEditingController();

  // Design constants
  final Color primaryColor = Color(0xFFFFB300);
  final Color secondaryColor = Color(0xFF76CB54);
  final Color backgroundColor = Colors.white;
  final Color textColor = Colors.black;
  final Color hintColor = Colors.grey;
  final double borderRadius = 12.0;
  final double padding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NumberSubPage()),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
              ),
              child: Text(
                'لدي رقم الرحلة',
                style: GoogleFonts.tajawal(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'إنشاء اشتراك جديد',
          style: GoogleFonts.tajawal(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Subscription Type
            _buildSectionTitle("نوع الاشتراك"),
            _buildSubscriptionTypeSelection(),
            SizedBox(height: padding),

            // Start Date
            _buildSectionTitle("تاريخ بدء الاشتراك"),
            _buildDateSelection(),
            SizedBox(height: padding),

            // From Location
            _buildSectionTitle("موقع المغادرة"),
            _buildLocationSelection(
              locations: [
                "عيون الجوا",
                "البكيرية",
                "البدايع",
                "المذنب",
                "الرس",
                "مليداء",
                "عنيزة",
                "بريدة"
              ],
              onSelected: (location) => setState(() => fromLocation = location),
              selectedLocation: fromLocation,
            ),
            SizedBox(height: padding),

            // To Location
            _buildSectionTitle("موقع الوصول"),
            _buildLocationSelection(
              locations: [
                "عيون الجوا",
                "البكيرية",
                "البدايع",
                "المذنب",
                "الرس",
                "مليداء",
                "عنيزة",
                "بريدة"
              ],
              onSelected: (location) => setState(() => toLocation = location),
              selectedLocation: toLocation,
            ),
            SizedBox(height: padding),

            // Home Location
            _buildSectionTitle("موقع المنزل"),
            _buildInputField(
              hintText: "أدخل رابط موقع منزلك أو نقطة اللقاء",
              onChanged: (value) => setState(() => homeLocation = value),
            ),
            SizedBox(height: padding),

            // Work Location
            _buildSectionTitle("موقع العمل"),
            _buildInputField(
              hintText: "أدخل رابط موقع العمل أو نقطة الوصول",
              onChanged: (value) => setState(() => workLocation = value),
            ),
            SizedBox(height: padding),

            // Price Input
            _buildSectionTitle("السعر (ريال سعودي)"),
            _buildInputField(
              controller: priceController,
              keyboardType: TextInputType.number,
              hintText: "أدخل المبلغ",
              suffixText: "ريال",
              onChanged: (value) =>
                  setState(() => price = double.tryParse(value) ?? 0),
            ),
            SizedBox(height: padding),

            // Schedule Days Section
            if (scheduleDays.isNotEmpty) ...[
              _buildSectionTitle("أيام الجدول الزمني"),
              _buildScheduleDaysTable(),
              SizedBox(height: padding),
            ],

            // Add Day Button
            _buildAddDayButton(),
            SizedBox(height: padding),

            // Driver Notes
            _buildSectionTitle("ملاحظات للسائق"),
            _buildInputField(
              hintText: "أدخل أي ملاحظات تريد إضافتها للسائق",
              maxLines: 3,
              onChanged: (value) => setState(() => driverNotes = value),
            ),
            SizedBox(height: padding * 2),

            // Submit Button
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.tajawal(
          color: primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSubscriptionTypeSelection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildChoiceButton(
              text: "أسبوعي",
              isSelected: selectedSubscriptionType == "أسبوعي",
              onTap: () => setState(() => selectedSubscriptionType = "أسبوعي"),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: _buildChoiceButton(
              text: "شهري",
              isSelected: selectedSubscriptionType == "شهري",
              onTap: () => setState(() => selectedSubscriptionType = "شهري"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.tajawal(
              color: isSelected ? Colors.white : textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelection() {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 1),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: primaryColor,
                  onPrimary: Colors.white,
                  onSurface: textColor,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          setState(() => subscriptionStartDate = picked);
        }
      },
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.calendar_today, color: primaryColor, size: 20),
            Text(
              subscriptionStartDate != null
                  ? "${subscriptionStartDate!.day}/${subscriptionStartDate!.month}/${subscriptionStartDate!.year}"
                  : "اختر التاريخ",
              style: GoogleFonts.tajawal(
                color: subscriptionStartDate != null ? textColor : hintColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSelection({
    required List<String> locations,
    required Function(String) onSelected,
    required String? selectedLocation,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: locations.map((location) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(
                location,
                style: GoogleFonts.tajawal(
                  color:
                      selectedLocation == location ? Colors.white : textColor,
                ),
              ),
              selected: selectedLocation == location,
              onSelected: (selected) => onSelected(location),
              selectedColor: primaryColor,
              backgroundColor: Colors.grey[50],
              side: BorderSide(color: Colors.grey[300]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInputField({
    TextEditingController? controller,
    String? hintText,
    String? suffixText,
    TextInputType? keyboardType,
    int maxLines = 1,
    required Function(String) onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
      style: GoogleFonts.tajawal(color: textColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.tajawal(color: hintColor),
        suffixText: suffixText,
        suffixStyle: GoogleFonts.tajawal(color: textColor),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildScheduleDaysTable() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1)
          },
          border: TableBorder.all(color: Colors.grey[200]!),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[100]),
              children: [
                _buildTableHeader("اليوم"),
                _buildTableHeader("الوقت"),
                _buildTableHeader("إجراء"),
              ],
            ),
            ...scheduleDays.map((day) {
              return TableRow(
                decoration: BoxDecoration(color: Colors.white),
                children: [
                  _buildTableCell(day['day']),
                  _buildTableCell(day['time']),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red[400]),
                    onPressed: () => setState(() => scheduleDays.remove(day)),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.tajawal(
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.tajawal(color: textColor),
      ),
    );
  }

  Widget _buildAddDayButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final result = await showDialog<Map<String, dynamic>>(
            context: context,
            builder: (context) => AddDayDialog(primaryColor: primaryColor),
          );
          if (result != null) {
            setState(() => scheduleDays.add(result));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor.withOpacity(0.1),
          foregroundColor: primaryColor,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: primaryColor, width: 1.5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 20),
            SizedBox(width: 8),
            Text(
              "إضافة يوم",
              style: GoogleFonts.tajawal(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitSubscription,
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 2,
          shadowColor: secondaryColor.withOpacity(0.3),
        ),
        child: Text(
          "رفع طلب اشتراك",
          style: GoogleFonts.tajawal(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _submitSubscription() {
    if (selectedSubscriptionType.isEmpty ||
        subscriptionStartDate == null ||
        fromLocation == null ||
        toLocation == null ||
        homeLocation == null ||
        workLocation == null ||
        scheduleDays.isEmpty ||
        price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("الرجاء ملء جميع الحقول المطلوبة"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      );
      return;
    }
    // Process data
    final subscriptionData = {
      "type": selectedSubscriptionType,
      "startDate": subscriptionStartDate,
      "from": fromLocation,
      "to": toLocation,
      "homeLocation": homeLocation,
      "workLocation": workLocation,
      "schedule": scheduleDays,
      "price": price,
      "notes": driverNotes,
    };
    //move to DriverSelectionPage
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DriverSelectionPage(
      fromLocation: fromLocation!,
      toLocation: toLocation!,
      subscriptionType: selectedSubscriptionType,
      priceRange: price,
      selectedDays: scheduleDays
          .where((day) => day.containsKey('day'))
          .map((day) => day['day'] as String)
          .toList(),
      subscriptionData: subscriptionData,
    ),
  ),

);


    print("Subscription Data: $subscriptionData");

    // Show success
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("تم إنشاء الاشتراك بنجاح"),
        backgroundColor: secondaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );

    // Navigator.pop(context);
  }
}

class AddDayDialog extends StatefulWidget {
  final Color primaryColor;

  const AddDayDialog({required this.primaryColor, super.key});

  @override
  _AddDayDialogState createState() => _AddDayDialogState();
}

class _AddDayDialogState extends State<AddDayDialog> {
  String? selectedDay;
  TimeOfDay? selectedTime;
  final List<String> days = [
    "الاحد",
    "الاثنين",
    "الثلاثاء",
    "الاربعاء",
    "الخميس"
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "إضافة يوم جديد",
              style: GoogleFonts.tajawal(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.primaryColor,
              ),
            ),
            SizedBox(height: 24),

            // Day Dropdown
            Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonFormField<String>(
                value: selectedDay,
                decoration: InputDecoration(
                  labelText: "اليوم",
                  labelStyle: GoogleFonts.tajawal(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                items: days.map((day) {
                  return DropdownMenuItem(
                    value: day,
                    child: Text(day, style: GoogleFonts.tajawal()),
                  );
                }).toList(),
                onChanged: (value) => setState(() => selectedDay = value),
                style: GoogleFonts.tajawal(color: Colors.black),
              ),
            ),
            SizedBox(height: 16),

            // Time Picker Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: widget.primaryColor,
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (time != null) {
                    setState(() => selectedTime = time);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[50],
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                child: Text(
                  selectedTime != null
                      ? "${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}"
                      : "اختر الوقت",
                  style: GoogleFonts.tajawal(),
                ),
              ),
            ),
            SizedBox(height: 24),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[600],
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text("إلغاء", style: GoogleFonts.tajawal()),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedDay != null && selectedTime != null) {
                      Navigator.pop(context, {
                        'day': selectedDay!,
                        'time':
                            "${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}",
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("إضافة", style: GoogleFonts.tajawal()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
