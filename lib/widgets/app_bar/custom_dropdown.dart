// lib/widgets/custom_dropdown.dart
import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/Screens/DriverinfoPage.dart';


class CustomDropdown extends StatelessWidget {
  final String label;
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  CustomDropdown({
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
   Widget build(BuildContext context) {
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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(
                hint,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                ),
              ),
              value: value,
              onChanged: onChanged,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                    ),
                  ),
                );
              }).toList(),
              selectedItemBuilder: (BuildContext context) {
                return items.map<Widget>((String item) {
                  return Text(
                    value ?? hint,
                    style: TextStyle(
                      fontSize: 14,
                      color: value == null ? Colors.black.withOpacity(0.5) : Colors.black,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ],
    );
  }
}