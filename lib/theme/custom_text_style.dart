import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
    TextStyle get sFPro {
        return copyWith(
            fontFamily: 'SF Pro',
        );
    }

    TextStyle get roboto {
        return copyWith(
            fontFamily: 'Roboto',
        );
    }

    TextStyle get inter {
        return copyWith(
            fontFamily: 'Inter',
        );
    }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families
class CustomTextStyles {
    // Body text style
    static TextStyle get bodyLargeBluegray200 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray200,
    );

    static TextStyle get bodyLargeBluegray700 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray700,
    );

    static TextStyle get bodyLargeErrorContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.errorContainer,
    );

    static TextStyle get bodyLargeGray400 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray400,
    );

    static TextStyle get bodyLargeGray60001 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray60001,
    );

    static TextStyle get bodyLargeGray900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray900,
    );

    static TextStyle get bodyLargeOnError => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onError,
    );

    static TextStyle get bodyLargeRed500 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.red500,
    );

    static TextStyle get bodyLargeSFProLightblueA700 => theme.textTheme.bodyLarge!.sFPro.copyWith(
        color: appTheme.lightBlueA700,
        fontSize: 17.fSize,
    );

    static TextStyle get bodyMediumBlack900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900.withOpacity(0.5),
    );

    static TextStyle get bodyMediumInter => theme.textTheme.bodyMedium!.inter;

    static TextStyle get bodyMediumInterBlueA200 => theme.textTheme.bodyMedium!.inter.copyWith(
        color: appTheme.blueA200,
    );

    static TextStyle get bodyMediumInterErrorContainer => theme.textTheme.bodyMedium!.inter.copyWith(
        color: theme.colorScheme.errorContainer,
    );

    static TextStyle get bodyMediumInterGray600 => theme.textTheme.bodyMedium!.inter.copyWith(
        color: appTheme.gray600,
    );

    static TextStyle get bodyMediumInterGray60002 => theme.textTheme.bodyMedium!.inter.copyWith(
        color: appTheme.gray60002,
    );

    static TextStyle get bodyMediumInterGray900 => theme.textTheme.bodyMedium!.inter.copyWith(
        color: appTheme.gray900,
    );

    static TextStyle get bodyMediumOrange800 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.orange800,
    );

    static TextStyle get bodyMediumOrangeA200 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.orangeA200,
    );

    static TextStyle get bodySmallOrange800 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.orange800,
    );

    // Label text style
    static TextStyle get labelSmallAmberA400 => theme.textTheme.labelSmall!.copyWith(
        color: appTheme.amberA400,
    );

    static TextStyle get labelSmallPurple100 => theme.textTheme.labelSmall!.copyWith(
        color: appTheme.purple100,
    );

    // Title text style
    static TextStyle get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w600,
    );

    static TextStyle get titleLargeOrangeA200 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.orangeA200.withOpacity(0.6),
    );

    static TextStyle get titleLargeRobotOfProrContainer => theme.textTheme.titleLarge!.roboto.copyWith(
        color: theme.colorScheme.errorContainer,
        fontWeight: FontWeight.w500,
    );

    static TextStyle get titleLargeRobotOLightgreen500 => theme.textTheme.titleLarge!.roboto.copyWith(
        color: appTheme.lightGreen500,
        fontWeight: FontWeight.w500,
    );

    static TextStyle get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 18.fSize,
    );

    static TextStyle get titleMediumBlack900_1 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
    );

    static TextStyle get titleMediumErrorContainer => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontSize: 18.fSize,
    );

    static TextStyle get titleMediumInter => theme.textTheme.titleMedium!.inter.copyWith(
        fontWeight: FontWeight.w600,
    );

    static TextStyle get titleMediumInterBlack900 => theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.black900,
        fontSize: 18.fSize,
    );

    static TextStyle get titleMediumInterBlack900Bold => theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w700,
    );

    static TextStyle get titleMediumInterBlack900Semibold => theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.black900,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w600,
    );

    static TextStyle get titleMediumInterBlack900Semibold_1 => theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w600,
    );

    static TextStyle get titleMediumInterBlack900_1 => theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.black900,
    );

    static TextStyle get titleMediumOrangeA200 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.orangeA200,
    );

    static TextStyle get titleMediumOrangeA20018 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.orangeA200,
        fontSize: 18.fSize,
    );

    static TextStyle get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900.withOpacity(0.5),
    );

    static TextStyle get titleSmallInterBluegray800 => theme.textTheme.titleSmall!.inter.copyWith(
        color: appTheme.blueGray800,
    );

    static TextStyle get titleSmallOrangeA200 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.orangeA200,
    );
}