import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Body text style
  static TextStyle get bodyLargeGray100 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray100,
      );
  static TextStyle get bodyLargeGray400 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray400,
      );
  static TextStyle get bodyMediumRobotoOrange800 =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.orange800,
      );
  static TextStyle get bodySmallBlack9000c =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black9000c.withOpacity(0.5),
      );
}
