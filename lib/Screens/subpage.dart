import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateSubscriptionPage extends StatefulWidget {
  const CreateSubscriptionPage({super.key});

  @override
  _CreateSubscriptionPageState createState() => _CreateSubscriptionPageState();
}

class _CreateSubscriptionPageState extends State<CreateSubscriptionPage> {
  String selectedSubscriptionType = "شهري"; // Weekly or Monthly
  DateTime? subscriptionStartDate;
  String? fromLocation;
  String? toLocation;
  String? homeLocation;
  String? workLocation;
  List<String> selectedDays = [];
  TimeOfDay? pickupTime;
  TimeOfDay? dropoffTime;
  double priceRange = 50;
  String driverNotes = "";

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
        title: Text(
          'إنشاء اشتراك جديد',
          style: GoogleFonts.getFont(
            'Inter',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Subscription Type
            _buildSubscriptionTypeSelection(),
            const SizedBox(height: 24),

            // Start Date
            _buildDateSelection(),
            const SizedBox(height: 24),

            // From Location
            _buildLocationSelection(
              label: "من",
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
              onSelected: (location) {
                setState(() {
                  fromLocation = location;
                });
              },
            ),
            const SizedBox(height: 16),

            // To Location
            _buildLocationSelection(
              label: "الى",
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
              onSelected: (location) {
                setState(() {
                  toLocation = location;
                });
              },
            ),
            const SizedBox(height: 16),

            // Home Location
            _buildLocationInputField(
              label: "موقعك",
              hint: "الرجاء ادخال رابط صحيح لموقع منزلك او نقطة التقاء مع السائق",
              onChanged: (value) {
                setState(() {
                  homeLocation = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Work Location
            _buildLocationInputField(
              label: "موقع العمل",
              hint: "الرجاء ادخال رابط صحيح لموقع العمل او نقطة الوصول",
              onChanged: (value) {
                setState(() {
                  workLocation = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Delivery Days
            _buildDeliveryDaysSelection(),
            const SizedBox(height: 16),

            // Time Selection
            _buildTimeSelection(),
            const SizedBox(height: 16),

            // Price Range
            _buildPriceRangeSelector(),
            const SizedBox(height: 16),

            // Driver Notes
            _buildDriverNotesField(),
            const SizedBox(height: 24),

            // Submit Button
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  // Subscription Type Selection
  Widget _buildSubscriptionTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "نوع الاشتراك",
          style: TextStyle(
            color: Color(0xFFFFB300),
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildSubscriptionTypeButton("أسبوعي", selectedSubscriptionType == "أسبوعي"),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildSubscriptionTypeButton("شهري", selectedSubscriptionType == "شهري"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubscriptionTypeButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSubscriptionType = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFFFB300) : Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? Border.all(color: Colors.black, width: 2) : Border.all(color: Colors.grey.shade400),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  // Date Selection
  Widget _buildDateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "حدد تاريخ بدء الاشتراك",
          style: TextStyle(
            color: Color(0xFFFFB300),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 1),
            );
            if (picked != null) {
              setState(() {
                subscriptionStartDate = picked;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today, size: 18, color: Color(0xFFFFB300)),
                const SizedBox(width: 8),
                Text(
                  subscriptionStartDate != null
                      ? "${subscriptionStartDate!.day}/${subscriptionStartDate!.month}/${subscriptionStartDate!.year}"
                      : "اختر التاريخ",
                  style: TextStyle(
                    color: subscriptionStartDate != null ? Colors.black : Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Location Selection
  Widget _buildLocationSelection({
    required String label,
    required List<String> locations,
    required Function(String) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFFFFB300),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
          ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: locations.map((location) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(location),
                  selected: (label == "من" && fromLocation == location) || 
                           (label == "الى" && toLocation == location),
                  onSelected: (selected) {
                    onSelected(location);
                  },
                  selectedColor: Color(0xFFFFB300),
                  labelStyle: TextStyle(
                    color: (label == "من" && fromLocation == location) || 
                           (label == "الى" && toLocation == location)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Location Input Field
  Widget _buildLocationInputField({
    required String label,
    required String hint,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFFFFB300),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
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
      ],
    );
  }

  // Delivery Days Selection
  Widget _buildDeliveryDaysSelection() {
    List<String> days = ["الاحد", "الاثنين", "الثلاثاء", "الاربعاء", "الخميس"];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "ايام التوصيل",
          style: TextStyle(
            color: Color(0xFFFFB300),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: days.map((day) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(day),
                  selected: selectedDays.contains(day),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedDays.add(day);
                      } else {
                        selectedDays.remove(day);
                      }
                    });
                  },
                  selectedColor: Color(0xFFFFB300),
                  labelStyle: TextStyle(
                    color: selectedDays.contains(day) ? Colors.white : Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Time Selection
  Widget _buildTimeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "الوقت",
          style: TextStyle(
            color: Color(0xFFFFB300),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildTimePickerButton(
              label: "الى",
              time: dropoffTime,
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  setState(() {
                    dropoffTime = picked;
                  });
                }
              },
            ),
            const SizedBox(width: 16),
            _buildTimePickerButton(
              label: "من",
              time: pickupTime,
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  setState(() {
                    pickupTime = picked;
                  });
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimePickerButton({
    required String label,
    required TimeOfDay? time,
    required Function() onPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFFFFB300),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 4),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade100,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            time != null ? "${time.hour}:${time.minute}" : "اختر الوقت",
            style: TextStyle(
              color: time != null ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  // Price Range Selector
  Widget _buildPriceRangeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "المبلغ المستعد لدفعه",
          style: TextStyle(
            color: Color(0xFFFFB300),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: priceRange,
          min: 0,
          max: 100,
          divisions: 10,
          label: "${priceRange.round()} ريال",
          activeColor: Color(0xFFFFB300),
          inactiveColor: Colors.grey.shade300,
          onChanged: (value) {
            setState(() {
              priceRange = value;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("0 ريال"),
            Text("100 ريال"),
          ],
        ),
      ],
    );
  }

  // Driver Notes Field
  Widget _buildDriverNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "ملاحظات للسائق",
          style: TextStyle(
            color: Color(0xFFFFB300),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: (value) {
            setState(() {
              driverNotes = value;
            });
          },
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "الرجاء ادخال اي ملاحظات تريد اضافتها للسائق",
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
      ],
    );
  }

  // Submit Button
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle form submission
          _submitSubscription();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF76CB54),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          "رفع الطلب",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _submitSubscription() {
    // Validate all required fields
    if (selectedSubscriptionType.isEmpty ||
        subscriptionStartDate == null ||
        fromLocation == null ||
        toLocation == null ||
        homeLocation == null ||
        workLocation == null ||
        selectedDays.isEmpty ||
        pickupTime == null ||
        dropoffTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("الرجاء ملء جميع الحقول المطلوبة"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Process the subscription data
    final subscriptionData = {
      "type": selectedSubscriptionType,
      "startDate": subscriptionStartDate,
      "from": fromLocation,
      "to": toLocation,
      "homeLocation": homeLocation,
      "workLocation": workLocation,
      "days": selectedDays,
      "pickupTime": pickupTime,
      "dropoffTime": dropoffTime,
      "priceRange": priceRange,
      "notes": driverNotes,
    };

    print("Subscription Data: $subscriptionData");
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("تم إرسال طلب الاشتراك بنجاح"),
        backgroundColor: Colors.green,
      ),
    );
    
    // Navigate back or to confirmation page
    Navigator.pop(context);
  }
}