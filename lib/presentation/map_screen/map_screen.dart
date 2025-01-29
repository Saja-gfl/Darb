import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../home_page/home_page.dart';
import '../messages_page/messages_page.dart';
import 'map_initial_page.dart';

// ignore_for_file: must_be_immutable
class MapScreen extends StatelessWidget {
  MapScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryContainer,
      body: Container(
        width: double.maxFinite,
        decoration: AppDecoration.fillOnPrimaryContainer,
        child: Column(
          children: [
            Expanded(
              child: Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.mapInitialPage,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                  pageBuilder: (ctx, ani, ani1) =>
                      getCurrentPage(routeSetting.name!),
                  transitionDuration: Duration(seconds: 0),
                ),
              ),
            ),
            SizedBox(height: 16.h)
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(
          left: 30.h,
          right: 30.h,
          bottom: 16.h,
        ),
        child: _buildBottomNavigationBar(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigationBar(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          Navigator.pushNamed(
              navigatorKey.currentContext!, getCurrentRoute(type));
        },
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Lock:
        return "/";
      case BottomBarEnum.Linkedinorange800:
        return AppRoutes.mapInitialPage;
      case BottomBarEnum.Lockonprimarycontainer:
        return AppRoutes.messagesPage;
      case BottomBarEnum.Homeonprimarycontainer:
        return AppRoutes.homePage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.mapInitialPage:
        return MapInitialPage();
      case AppRoutes.messagesPage:
        return MessagesPage();
      case AppRoutes.homePage:
        return HomePage();
      default:
        return DefaultWidget();
    }
  }
}
