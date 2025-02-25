import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  static var outlineBlueGray;
  static var outlineBluegray100;

    // Fill decorations
    static BoxDecoration get fillBlack => BoxDecoration(
        color: appTheme.black900.withOpacity(0.05),
    );

    static BoxDecoration get fillGrayE => BoxDecoration(
        color: appTheme.gray6001e,
    );

    static BoxDecoration get fillOnError => BoxDecoration(
        color: theme.colorScheme.onError,
    );

    static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
    );

    static BoxDecoration get fillOnPrimaryContainer1 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(0.8),
    );

    // Outline decorations
    static BoxDecoration get outlineBlack => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
        boxShadow: [
            BoxShadow(
                color: appTheme.black900.withOpacity(0.05),
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: Offset(0, 0),
            ),
        ],
    );

    static BoxDecoration get outlineBlack900 => BoxDecoration(
        border: Border.all(
            color: appTheme.black900.withOpacity(0.1),
            width: 1.h,
        ),
    );

    static BoxDecoration get outlineBlack9001 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
        boxShadow: [
            BoxShadow(
                color: appTheme.black900.withOpacity(0.1),
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: Offset(0, 1),
            ),
        ],
    );

    static BoxDecoration get outlineGray => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
        border: Border.all(
            color: appTheme.gray300,
            width: 1.h,
        ),
    );

    static BoxDecoration get outlineGray200 => BoxDecoration(
        border: Border.all(
            color: appTheme.gray200,
            width: 1.h,
        ),
    );

    static BoxDecoration get outlineGray2001 => BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: appTheme.gray200,
                width: 1.h,
            ),
        ),
    );

    static BoxDecoration get outlineGray300 => BoxDecoration(
        border: Border.all(
            color: appTheme.gray300,
            width: 1.h,
        ),
    );

    static BoxDecoration get outlineOnErrorContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
        border: Border.all(
            color: theme.colorScheme.onErrorContainer,
            width: 2.h,
        ),
        boxShadow: [
            BoxShadow(
                color: appTheme.black900.withOpacity(0.1),
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: Offset(0, 1),
            ),
        ],
    );

    static BoxDecoration get outlineOnPrimaryContainer => BoxDecoration(
        border: Border.all(
            color: theme.colorScheme.onPrimaryContainer,
            width: 4.h,
        ),
    );

    static BoxDecoration get outlinePrimary => BoxDecoration(
        border: Border.all(
            color: theme.colorScheme.primary,
            width: 1.h,
        ),
    );

    static BoxDecoration get outlineSecondaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
        border: Border.all(
            color: theme.colorScheme.secondaryContainer,
            width: 1.h,
        ),
    );
}

class BorderRadiusStyle {
  static var roundedBorder8;

    // Circle borders
    static BorderRadius get circleBorder16 => BorderRadius.circular(16.h);

    static BorderRadius get circleBorder32 => BorderRadius.circular(32.h);

    static BorderRadius get circleBorder48 => BorderRadius.circular(48.h);

    // Rounded borders
    static BorderRadius get roundedBorder12 => BorderRadius.circular(12.h);

    static BorderRadius get roundedBorder20 => BorderRadius.circular(20.h);

    static BorderRadius get roundedBorder6 => BorderRadius.circular(6.h);
}