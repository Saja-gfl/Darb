import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/widgets/custom_text_form_field.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback onTap;
  final Widget? suffixIcon;

  const CustomDatePicker({
    Key? key,
    required this.label,
    required this.value,
    required this.onTap,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFFFFB300),
            fontSize: 14, // Or 14.fSize if size_utils is properly set
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 8), // Or 8.v if size_utils is set
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: CustomTextFormField(
              controller: TextEditingController(text: value),
              hintText: value?.isEmpty ?? true ? "اختر التاريخ" : null,
              hintStyle: value?.isEmpty ?? true
                  ? TextStyle(
                      color: Colors.grey,
                      fontSize: 16) // Or CustomTextStyles.bodyLargeGray400
                  : TextStyle(
                      color: Colors.black,
                      fontSize: 16), // Or CustomTextStyles.bodyLargeBlack900
              textStyle:
                  TextStyle(color: Colors.black, fontSize: 16), // Fallback
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12, // Or 12.h
                vertical: 10, // Or 10.v
              ),
              filled: true,
              fillColor: Theme.of(context)
                  .colorScheme
                  .surface, // Fallback if theme is missing
              readOnly: true,
              suffix: suffixIcon ??
                  const Icon(
                    Icons.calendar_today,
                    color: Color(0xFFFFB300),
                  ),
              borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8), // Or 8.h
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.1), // Fallback
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
