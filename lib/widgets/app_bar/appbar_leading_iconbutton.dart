import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../custom_icon_button.dart';

class AppbarLeadingIconbutton extends StatelessWidget {
  AppbarLeadingIconbutton({
    Key? key,
    this.imagePath,
    this.height,
    this.width,
    this.onTap,
    this.margin,
  }) : super(
          key: key,
        );

  final double? height;
  final double? width;
  final String? imagePath;
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
        child: CustomIconButton(
          height: height ?? 34.h,
          width: width ?? 36.h,
          padding: EdgeInsets.all(2.h),
          decoration: IconButtonStyleHelper.none,
          child: CustomImageView(
            // imagePath: imagePath ?? ImageConstant.imgRefreshErrorcontainer,
          ),
        ),
      ),
    );
  }
}