import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';
import 'base_button.dart';

class CustomOutlinedButton extends BaseButton {
    CustomOutlinedButton({
        Key? key,
        this.decoration,
        this.leftIcon,
        this.rightIcon,
        this.label,
        VoidCallback? onPressed,
        ButtonStyle? buttonStyle,
        TextStyle? buttonTextStyle,
        bool? isDisabled,
        AlignmentGeometry? alignment,
        double? height,
        double? width,
        EdgeInsetsGeometry? margin,
        required String text,
    }) : super(
        text: text,
        onPressed: onPressed,
        buttonStyle: buttonStyle,
        isDisabled: isDisabled,
        buttonTextStyle: buttonTextStyle,
        height: height,
        alignment: alignment,
        width: width,
        margin: margin,
    );

    final BoxDecoration? decoration;
    final Widget? leftIcon;
    final Widget? rightIcon;
    final Widget? label;

    @override
    Widget build(BuildContext context) {
        return alignment != null
            ? Align(
                alignment: alignment ?? Alignment.center,
                child: buildOutlinedButtonWidget(),
              )
            : buildOutlinedButtonWidget();
    }

    Widget buildOutlinedButtonWidget() => Container(
        height: this.height ?? 42.h,
        width: this.width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: OutlinedButton(
            style: buttonStyle,
            onPressed: isDisabled ?? false ? null : onPressed ?? () {},
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    leftIcon ?? const SizedBox.shrink(),
                    Text(
                        text,
                        style: buttonTextStyle ?? theme.textTheme.bodyLarge,
                    ),
                    rightIcon ?? const SizedBox.shrink(),
                ],
            ),
        ),
    );
}