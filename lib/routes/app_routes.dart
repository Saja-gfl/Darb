import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/Screens/DriverSelectionPage.dart';
import 'package:rem_s_appliceation9/Screens/ReviewPage.dart';
import 'package:rem_s_appliceation9/Screens/Welcomepage.dart';
import 'package:rem_s_appliceation9/Screens/number_sub.dart';
import 'package:rem_s_appliceation9/Screens/otp.dart';
import '../Screens/LoginPage.dart';
import '../Screens/RegistrationPage.dart';
import 'package:rem_s_appliceation9/Screens/DriverHomePage.dart';
import 'package:rem_s_appliceation9/Screens/DriverInfoPage.dart';
import 'package:rem_s_appliceation9/Screens/userhome_pageM.dart';
import 'package:rem_s_appliceation9/Screens/UserProfilePage.dart';
import 'package:rem_s_appliceation9/Screens/subpage.dart';
import 'package:rem_s_appliceation9/Screens/chatPage.dart';
import 'package:rem_s_appliceation9/Screens/OngoingSubPage.dart';
import 'package:rem_s_appliceation9/Screens/LoginPage.dart';

class AppRoutes {
  // Existing routes
  static const String k0Screen = '/k0_screen';
  static const String k1Screen = '/k1_screen';
  static const String initialRoute = '/initialRoute';

  // New routes for all screens
  static const String loginPage = '/login_page';
  static const String registrationPage = '/registration_page';
  static const String driverHomePage = '/driver_home_page';
  static const String driverInfoPage = '/driver_info_page';
  static const String driverSelectionPage = '/driver_selection_page';
  static const String userHomePage = '/user_home_page';
  static const String userProfilePage = '/user_profile_page';
  static const String subPage = '/sub_page';
  static const String numberSub = '/number_sub';
  static const String chatPage = '/chat_page';
  static const String findDriverPage = '/find_driver_page';
  static const String reviewPage = '/review_page';
  static const String otpPage = '/otp_page';
  static const String ongoingSubPage = '/ongoing_sub_page';

  static Map<String, WidgetBuilder> routes = {
    // Existing routes
    k0Screen: (context) => K0Screen(),
    k1Screen: (context) => K1Screen(),
    initialRoute: (context) => WelcomePage(),

    // New routes
    loginPage: (context) => K0Screen(),
    registrationPage: (context) => K1Screen(),
    driverHomePage: (context) => DriverHomePage(),
    driverInfoPage: (context) => DriverInfoPage(),
    // driverSelectionPage: (context) => DriverSelectionPage(),
    userHomePage: (context) => UserHomePage(),
    userProfilePage: (context) => UserProfilePage(),
    subPage: (context) => CreateSubscriptionPage(),
    // numberSub: (context) => NumberSubPage(),
    chatPage: (context) => ChatPage(),
    // findDriverPage: (context) => FindDriverPage(),
    // reviewPage: (context) => ReviewPage(),
    // otpPage: (context) => OTPVerificationScreen(),
    ongoingSubPage: (context) => OngoingSubPage(),
  };
}
