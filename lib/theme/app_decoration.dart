import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBlackC => BoxDecoration(
        color: appTheme.black9000c,
      );
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      );
// Outline decorations
  static BoxDecoration get outlineBlack9000c => BoxDecoration(
        border: Border(
          left: BorderSide(
            color: appTheme.black9000c,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineBlackC => BoxDecoration(
        border: Border.all(
          color: appTheme.black9000c.withOpacity(0.1),
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        border: Border.all(
          color: appTheme.blueGray100,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineBluegray100 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
        border: Border.all(
          color: appTheme.blueGray100,
          width: 1.h,
        ),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder16 => BorderRadius.circular(
        16.h,
      );
// Rounded borders
  static BorderRadius get roundedBorder6 => BorderRadius.circular(
        6.h,
      );
}
