import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/custom_text_style.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';
import 'package:rem_s_appliceation9/widgets/custom_text_form_field.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback onTap;
  final Widget? suffixIcon;

  const CustomDatePicker({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
    this.suffixIcon,
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
            fontSize: 14.fSize,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        SizedBox(height: 8.v),
        GestureDetector(
          onTap: onTap,
          child: CustomTextFormField(
            hintText: value ?? "اختر التاريخ",
            hintStyle: value != null
                ? CustomTextStyles.bodyLargeBlack900
                : CustomTextStyles.bodyLargeGray400,
            textStyle: CustomTextStyles.bodyLargeBlack900,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.h,
              vertical: 10.v,
            ),
            filled: true,
            fillColor: theme.colorScheme.onPrimaryContainer,
            readOnly: true,
            suffix: suffixIcon ??
                const Icon(Icons.calendar_today, color: Color(0xFFFFB300)),
            borderDecoration: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.h),
              borderSide: BorderSide(
                color: appTheme.black900.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
