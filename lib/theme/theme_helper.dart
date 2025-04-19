import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';

String _appTheme = "lightCode";
LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.
// ignore_for_file: must_be_immutable
class ThemeHelper {

    // A map of custom color themes supported by the app
    Map<String, LightCodeColors> _supportedCustomColor = {
        'lightCode': LightCodeColors()
    };

    // A map of color schemes supported by the app
    Map<String, ColorScheme> _supportedColorScheme = {
        'lightCode': ColorSchemes.lightCodeColorScheme
    };

    // Changes the app theme to [_newTheme].
    void changeTheme(String _newTheme) {
        _appTheme = _newTheme;
    }

    /// Returns the lightCode colors for the current theme.
    LightCodeColors _getThemeColors() {
        return _supportedCustomColor[_appTheme] ?? LightCodeColors();
    }

    /// Returns the current theme data.
    ThemeData _getThemeData() {
        var colorScheme = _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
        return ThemeData(
            visualDensity: VisualDensity.standard,
            colorScheme: colorScheme,
            textTheme: TextThemes.textTheme(colorScheme),
            outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(
                        color: colorScheme.primary,
                        width: 1.h,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.h),
                    ),
                    visualDensity: const VisualDensity(
                        vertical: -4,
                        horizontal: -4,
                    ),
                    padding: EdgeInsets.zero,
                ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: appTheme.orangeA200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.h),
                    ),
                    elevation: 0,
                    visualDensity: const VisualDensity(
                        vertical: -4,
                        horizontal: -4,
                    ),
                    padding: EdgeInsets.zero,
                ),
            ),
            dividerTheme: DividerThemeData(
                thickness: 1,
                space: 1,
                color: appTheme.black900.withOpacity(0.1),
            ),
        );
    }

    /// Returns the LightCode colors for the current theme.
    LightCodeColors themeColor() => _getThemeColors();

    /// Returns the current theme data.
    ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
    static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
            color: appTheme.black900,
            fontSize: 16.fSize,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
            color: appTheme.black900,
            fontSize: 14.fSize,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
            color: appTheme.black900.withOpacity(0.5),
            fontSize: 12.fSize,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
        ),
        displayLarge: TextStyle(
            color: appTheme.orangeA200.withOpacity(0.6),
            fontSize: 64.fSize,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
        ),
        headlineMedium: TextStyle(
            color: appTheme.orangeA200,
            fontSize: 27.fSize,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
            color: appTheme.orangeA200,
            fontSize: 24.fSize,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w900,
        ),
        labelLarge: TextStyle(
            color: appTheme.black900,
            fontSize: 12.fSize,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
            color: appTheme.orangeA200,
            fontSize: 10.fSize,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
            color: appTheme.gray40001,
            fontSize: 9.fSize,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w900,
        ),
        titleLarge: TextStyle(
            color: appTheme.orangeA200,
            fontSize: 20.fSize,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w900,
        ),
        titleMedium: TextStyle(
            color: colorScheme.onPrimaryContainer,
            fontSize: 16.fSize,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
            color: appTheme.black900,
            fontSize: 14.fSize,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
        ),
    );
}

/// Class containing the supported color schemes.
class ColorSchemes {

    static final lightCodeColorScheme = ColorScheme.light(
        primary: Color(0XFFD4D4DA),
        primaryContainer: Color(0XFF404040),
        secondaryContainer: Color(0XFFD9D9D9),
        errorContainer: Color(0XFFF7931E),
        onError: Color(0XFF5F5F5F),
        onErrorContainer: Color(0XFF171717),
        onPrimary: Color(0XFF2C2C2C),
        onPrimaryContainer: Color(0XFFFFFFFF),
    );
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {

    // Amber
    Color get amberA400 => Color(0XFFFFC600);

    // Black
    Color get black900 => Color(0XFF000000);

    // Blue
    Color get blueA200 => Color(0XFF3B82F6);

    // BlueGray
    Color get blueGray200 => Color(0XFFADAEBC);
    Color get blueGray300 => Color(0XFF9CA3AF);
    Color get blueGray700 => Color(0XFF525252);
    Color get blueGray70001 => Color(0XFF4B5563);
    Color get blueGray800 => Color(0XFF374151);
    Color get blueGray900 => Color(0XFF292D32);

    // Gray
    Color get gray200 => Color(0XFFE5E7EB);
    Color get gray300 => Color(0XFFE5E5E5);
    Color get gray400 => Color(0XFFB3B3B3);
    Color get gray40001 => Color(0XFFB4B4B4);
    Color get gray500 => Color(0XFFA3A3A3);
    Color get gray600 => Color(0XFF6B7280);
    Color get gray60001 => Color(0XFF757575);
    Color get gray60002 => Color(0XFF737373);
    Color get gray6001e => Color(0X1E787880);
    Color get gray900 => Color(0XFF1E1E1E);

    // LightBlue
    Color get lightBlueA700 => Color(0XFF007AFF);

    // LightGreen
    Color get lightGreen500 => Color(0XFF76CB54);

    // Orange
    Color get orange800 => Color(0XFFC97100);
    Color get orangeA200 => Color(0XFFFBBB3B);

    // Purple
    Color get purple100 => Color(0XFFE4C1F9);

    // Red
    Color get red400 => Color(0XFFF14848);
    Color get red500 => Color(0XFFEF4444);
}
