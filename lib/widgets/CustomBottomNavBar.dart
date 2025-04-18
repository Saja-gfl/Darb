import 'package:flutter/material.dart';
import 'package:rem_s_appliceation9/core/utils/image_constant.dart';
import 'package:rem_s_appliceation9/widgets/custom_image_view.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({Key? key}) : super(key: key);

  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  int _currentIndex = 0;
  final Color _accentColor = const Color(0xFFF7931E);
  final Color _secondaryColor = const Color(0xFFFBB03B);

  final List<Widget> _pages = [
    const _HomeContent(),
    const ChatPage(),
    const DriverInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate responsive sizes
          final navBarWidth = constraints.maxWidth * (isPortrait ? 0.85 : 0.6);
          final horizontalMargin = (constraints.maxWidth - navBarWidth) / 2;
          final logoHeight = constraints.maxHeight * 0.07;
          final contentPadding = EdgeInsets.fromLTRB(
            constraints.maxWidth * 0.05,
            constraints.maxHeight * 0.12,
            constraints.maxWidth * 0.05,
            constraints.maxHeight * 0.1,
          );

          return Stack(
            children: [
              // Main Content
              Padding(
                padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.1),
                child: _pages[_currentIndex],
              ),

              // Fixed Bottom Navigation Bar
              Positioned(
                left: horizontalMargin,
                right: horizontalMargin,
                bottom: constraints.maxHeight * 0.02,
                child: Container(
                  width: navBarWidth,
                  height: constraints.maxHeight * 0.07,
                  padding: EdgeInsets.symmetric(
                    horizontal: navBarWidth * 0.09,
                    vertical: constraints.maxHeight * 0.005,
                  ),
                  decoration: ShapeDecoration(
                    color: const Color(0x99FBB03B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        constraints.maxHeight * 0.015,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNavIcon(
                        icon: Icons.home,
                        isActive: _currentIndex == 0,
                        size: constraints.maxHeight * 0.03,
                        onTap: () => setState(() => _currentIndex = 0),
                      ),
                      _buildNavIcon(
                        icon: Icons.chat,
                        isActive: _currentIndex == 1,
                        size: constraints.maxHeight * 0.03,
                        onTap: () => setState(() => _currentIndex = 1),
                      ),
                      _buildNavIcon(
                        icon: Icons.person,
                        isActive: _currentIndex == 2,
                        size: constraints.maxHeight * 0.03,
                        onTap: () => setState(() => _currentIndex = 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNavIcon({
    required IconData icon,
    required bool isActive,
    required double size,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? Colors.white.withOpacity(0.3) : Colors.transparent,
        ),
        child: Icon(
          icon,
          size: size * 0.8,
          color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accentColor = const Color(0xFFF7931E);
    final secondaryColor = const Color(0xFFFBB03B);
    final textColor = const Color(0xFFC97100);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive sizes
        final logoHeight = constraints.maxHeight * 0.07;
        final sectionSpacing = constraints.maxHeight * 0.03;
        final itemSpacing = constraints.maxHeight * 0.02;
        final fontSizeTitle = constraints.maxHeight * 0.022;
        final fontSizeSubtitle = constraints.maxHeight * 0.018;
        final fontSizeSmall = constraints.maxHeight * 0.016;
        final iconSize = constraints.maxHeight * 0.04;
        final borderRadius = constraints.maxHeight * 0.01;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            constraints.maxWidth * 0.05,
            constraints.maxHeight * 0.05,
            constraints.maxWidth * 0.05,
            constraints.maxHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Logo
              Align(
                alignment: Alignment.topRight,
                child: CustomImageView(
                  height: logoHeight,
                  width: logoHeight * 2,
                  imagePath: ImageConstant.img5935976241859510486,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: sectionSpacing * 1.5),

              // Notifications Section
              Container(
                padding: EdgeInsets.all(constraints.maxWidth * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'الإشعارات',
                      style: TextStyle(
                        color: accentColor,
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.w500,
                        height: 1.33,
                      ),
                    ),
                    SizedBox(height: itemSpacing),
                    _buildNotificationItem(
                      'تم قبول طلب اشتراكك من قبل السائق أحمد.',
                      'منذ ساعتين',
                      accentColor,
                      textColor,
                      iconSize,
                      borderRadius,
                      fontSizeSubtitle,
                      fontSizeSmall,
                    ),
                  ],
                ),
              ),

              SizedBox(height: sectionSpacing * 2),

              // Services Section
              Text(
                'الخدمات',
                style: TextStyle(
                  color: accentColor,
                  fontSize: fontSizeTitle,
                  fontWeight: FontWeight.w500,
                  height: 1.33,
                ),
              ),
              SizedBox(height: itemSpacing),
              _buildServiceItem(
                'عرض الاشتراكات الحالية',
                'تتبع رحلاتك الحالية مع السائقين',
                accentColor,
                secondaryColor,
                borderRadius,
                fontSizeSubtitle,
                fontSizeSmall,
              ),
              SizedBox(height: itemSpacing),
              _buildServiceItem(
                'طلبات اشتراك جديدة',
                'ابدأ اشتراكًا جديدًا بناءً على جدولك الزمني',
                accentColor,
                secondaryColor,
                borderRadius,
                fontSizeSubtitle,
                fontSizeSmall,
              ),
              SizedBox(height: itemSpacing),
              _buildServiceItem(
                'ادارة طلبات الاشتراك',
                'استعرض وادارة طلبات الاشتراك الحالية والمعلقة',
                accentColor,
                secondaryColor,
                borderRadius,
                fontSizeSubtitle,
                fontSizeSmall,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem(
    String message,
    String time,
    Color accentColor,
    Color textColor,
    double iconSize,
    double borderRadius,
    double fontSize,
    double smallFontSize,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: iconSize * 0.5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            decoration: ShapeDecoration(
              color: Colors.black.withOpacity(0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(iconSize / 2),
              ),
            ),
            child: Center(
                child: Text('🔔', style: TextStyle(fontSize: iconSize * 0.6))),
          ),
          SizedBox(width: iconSize * 0.5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                  ),
                ),
                SizedBox(height: iconSize * 0.2),
                Text(
                  time,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: smallFontSize,
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(
    String title,
    String description,
    Color accentColor,
    Color secondaryColor,
    double borderRadius,
    double fontSize,
    double smallFontSize,
  ) {
    return Container(
      padding: EdgeInsets.all(borderRadius * 1.5),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.black.withOpacity(0.15),
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
                SizedBox(height: borderRadius * 0.5),
                Text(
                  description,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: smallFontSize,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: borderRadius * 1.5),
          Container(
            width: borderRadius * 3,
            height: borderRadius * 3,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(borderRadius * 0.5),
            ),
            child: Icon(Icons.arrow_forward, size: borderRadius * 1.5),
          ),
        ],
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.1),
          child: Center(
            child: Text(
              "صفحة المحادثات",
              style: TextStyle(fontSize: constraints.maxHeight * 0.03),
            ),
          ),
        );
      },
    );
  }
}

class DriverInfoPage extends StatelessWidget {
  const DriverInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.1),
          child: Center(
            child: Text(
              "صفحة الملف الشخصي",
              style: TextStyle(fontSize: constraints.maxHeight * 0.03),
            ),
          ),
        );
      },
    );
  }
}
