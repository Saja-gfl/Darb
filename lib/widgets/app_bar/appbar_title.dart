import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';

class AppbarTitle extends StatelessWidget {
    AppbarTitle({
        Key? key,
        required this.text,
        this.onTap,
        this.margin,
    }) : super(key: key);

    final String text;
    final Function? onTap;
    final EdgeInsetsGeometry? margin;

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: margin ?? EdgeInsets.zero,
            child: GestureDetector(
                onTap: () {
                    onTap?.call();
                },
                child: Text(
                    text,
                    style: theme.textTheme.headlineMedium,
                ),
            ),
        );
    }
}