import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/core/utils/size_utils.dart';
import 'package:rem_s_appliceation9/theme/theme_helper.dart';

enum Style { bgShadowBlack080 }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
    CustomAppBar({
        Key? key,
        this.height,
        this.shape,
        this.styleType,
        this.leadingWidth,
        this.leading,
        this.title,
        this.centerTitle,
        this.actions,
    }) : super(key: key);

    final double? height;
    final ShapeBorder? shape;
    final Style? styleType;
    final double? leadingWidth;
    final Widget? leading;
    final Widget? title;
    final bool? centerTitle;
    final List<Widget>? actions;

    @override
    Widget build(BuildContext context) {
        return AppBar(
            elevation: 0,
            shape: shape,
            toolbarHeight: height ?? 56.h,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            flexibleSpace: _getStyle(),
            leadingWidth: leadingWidth ?? 0,
            leading: leading,
            title: title,
            titleSpacing: 0,
            centerTitle: centerTitle ?? false,
            actions: actions,
        );
    }

    @override
    Size get preferredSize => Size(
        SizeUtils.width,
        height ?? 56.h,
    );

    Widget? _getStyle() {
        switch (styleType) {
            case Style.bgShadowBlack080:
                return Container(
                    height: 56.h,
                    width: SizeUtils.width,
                    decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimaryContainer,
                        boxShadow: [
                            BoxShadow(
                                color: appTheme.black900.withOpacity(0.13),
                                spreadRadius: 2.h,
                                blurRadius: 2.h,
                                offset: Offset(0, 0),
                            ),
                        ],
                    ),
                );
            default:
                return null;
        }
    }
}