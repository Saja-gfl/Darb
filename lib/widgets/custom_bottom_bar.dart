import 'package:flutter/material.dart';
import '../core/app_export.dart';

enum BottomBarEnum {
  Lock,
  Linkedinorange800,
  Lockonprimarycontainer,
  Homeonprimarycontainer
}

// ignore_for_file: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

// ignore_for_file: must_be_immutable
class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgLock,
      activeIcon: ImageConstant.imgLock,
      type: BottomBarEnum.Lock,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgLinkedinOrange800,
      activeIcon: ImageConstant.imgLinkedinOrange800,
      type: BottomBarEnum.Linkedinorange800,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgLockOnprimarycontainer,
      activeIcon: ImageConstant.imgLockOnprimarycontainer,
      type: BottomBarEnum.Lockonprimarycontainer,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgHomeOnprimarycontainer,
      activeIcon: ImageConstant.imgHomeOnprimarycontainer,
      type: BottomBarEnum.Homeonprimarycontainer,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 30.h,
        right: 30.h,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(
          13.h,
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: bottomMenuList[index].icon,
              height: 24.h,
              width: 26.h,
              color: theme.colorScheme.onPrimaryContainer,
            ),
            activeIcon: CustomImageView(
              imagePath: bottomMenuList[index].activeIcon,
              height: 24.h,
              width: 26.h,
              color: appTheme.orange800,
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

// ignore_for_file: must_be_immutable
class BottomMenuModel {
  BottomMenuModel(
      {required this.icon, required this.activeIcon, required this.type});

  String icon;

  String activeIcon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
