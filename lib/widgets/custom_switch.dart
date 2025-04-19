import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/cupertino.dart';

class CustomSwitch extends StatelessWidget {
  CustomSwitch({
    Key? key,
    this.alignment,
    this.margin,
    this.value,
    this.height = 24,
    this.width = 40,
    required this.onChange,
  }) : super(key: key);

  final Alignment? alignment;
  final EdgeInsetsGeometry? margin;
  final bool? value;
  final double height;
  final double width;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        margin: margin,
        child: alignment != null
            ? Align(
                alignment: alignment ?? AlignmentDirectional.center,
                child: switchWidget)
            : switchWidget);
  }

  Widget get switchWidget => FlutterSwitch(
        value: value ?? false,
        height: 24.h,
        width: 40.h,
        toggleSize: 18,
        borderRadius: 12.h,
        switchBorder: Border.all(
          color: appTheme.gray60001,
          width: 1.h,
        ),
        activeColor: theme.colorScheme.onPrimary,
        activeToggleColor: theme.colorScheme.onError,
        inactiveColor: theme.colorScheme.onPrimaryContainer,
        inactiveToggleColor: appTheme.gray60001,
        onToggle: (value) {
          onChange(value);
        },
      );
}
