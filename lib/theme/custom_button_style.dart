import 'package:flutter/material.dart';
import '../core/app_export.dart';

// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
    // Filled button style
    static ButtonStyle get fillLightGreen => ElevatedButton.styleFrom(
        backgroundColor: appTheme.lightGreen500,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
    );

    static ButtonStyle get fillLightGreenTL6 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.lightGreen500.withOpacity(0.45),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
    );

    static ButtonStyle get fillOnError => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.onError,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
    );

    static ButtonStyle get fillOrangeA => ElevatedButton.styleFrom(
        backgroundColor: appTheme.orangeA200.withOpacity(0.6),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
    );

    static ButtonStyle get fillOrangeATL81 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.orangeA200.withOpacity(0.6),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
    );

    static ButtonStyle get fillRed => ElevatedButton.styleFrom(
        backgroundColor: appTheme.red400,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
    );

    // Outline button style
    static ButtonStyle get outlineOrangeA => OutlinedButton.styleFrom(
        backgroundColor: theme.colorScheme.onPrimaryContainer,
        side: BorderSide(
            color: appTheme.orangeA200,
            width: 1,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
        ),
        padding: EdgeInsets.zero,
    );

    static ButtonStyle get outlinePrimary => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
            color: theme.colorScheme.primary,
            width: 1,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.h),
        ),
        padding: EdgeInsets.zero,
    );

    // Text button style
    static ButtonStyle get none => ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        elevation: WidgetStateProperty.all<double>(0),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
        side: WidgetStateProperty.all<BorderSide>(
            BorderSide(color: Colors.transparent),
        ),
    );
}