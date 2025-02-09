import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showBackButton)
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          Expanded(
            child: Center(
              child: CustomImageView(
                imagePath: ImageConstant.img5935976241859510486,
                height: 40.h,
                width: 60.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
