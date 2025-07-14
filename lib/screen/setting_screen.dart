import 'package:advertising_app/router/local_notifier.dart';
import 'package:flutter/material.dart';
import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/widget/custom_bottom_nav.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends StatefulWidget {
  final LocaleChangeNotifier notifier;

  const SettingScreen({super.key, required this.notifier});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isInvisible = true;
  bool _isNotificationsEnabled = true;

  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final baseHeight = screenHeight < 700 ? screenHeight : 700;
    final scaleFactor = screenHeight / baseHeight;

    final logoHeight = 100.0 * scaleFactor;
    final logoWidth = logoHeight * 2;
    final tileHeight = 52.0 * scaleFactor;
    final fontSize = 14.0 * scaleFactor;
    final iconSize = 22.0 * scaleFactor;

    return AnimatedBuilder(
      animation: widget.notifier,
      builder: (context, _) {
        final locale = widget.notifier.locale;

        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: CustomBottomNav(currentIndex: 4),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10 * scaleFactor),
                Center(
                  child: Image.asset(
                    'images/logo.png',
                    height: logoHeight,
                    width: logoWidth,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 10 * scaleFactor),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTile(
                        context: context,
                        height: tileHeight,
                        fontSize: fontSize,
                        iconSize: iconSize,
                        customLeading: SvgPicture.asset(
                          'assets/icons/profile.svg',
                          width: iconSize,
                          height: iconSize,
                        ),
                        title: S.of(context).myProfile,
                        ontap: () => context.push('/editprofile'),
                      ),
                      _buildTile(
                        context: context,
                        height: tileHeight,
                        fontSize: fontSize,
                        iconSize: iconSize,
                        customLeading: SvgPicture.asset(
                          'assets/icons/numder.svg',
                          width: iconSize * 0.6,
                          height: iconSize * 0.6,
                        ),
                        title: S.of(context).createAgentCode,
                      ),
                      _buildNotificationSwitch(
                          context, screenWidth, tileHeight, fontSize, iconSize),
                      _buildInvisibleSwitch(
                          context, screenWidth, tileHeight, fontSize, iconSize),
                      _buildTile(
                        context: context,
                        height: tileHeight,
                        fontSize: fontSize,
                        iconSize: iconSize,
                        customLeading: SvgPicture.asset(
                          'assets/icons/language.svg',
                          width: iconSize,
                          height: iconSize,
                        ),
                        title: S.of(context).language,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: widget.notifier.toggleLocale,
                              child: Text(
                                locale.languageCode == 'ar'
                                    ? S.of(context).arabic
                                    : S.of(context).english,
                                style: TextStyle(
                                  color: const Color.fromRGBO(8, 194, 201, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSize,
                                ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: fontSize + 2,
                              color: KTextColor,
                            ),
                          ],
                        ),
                      ),
                      _buildTile(
                        context: context,
                        height: tileHeight,
                        fontSize: fontSize,
                        iconSize: iconSize,
                        customLeading: SvgPicture.asset(
                          'assets/icons/terms.svg',
                          width: iconSize,
                          height: iconSize,
                        ),
                        title: S.of(context).termsAndConditions,
                      ),
                      _buildTile(
                        context: context,
                        height: tileHeight,
                        fontSize: fontSize,
                        iconSize: iconSize,
                        customLeading: SvgPicture.asset(
                          'assets/icons/contact-us.svg',
                          width: iconSize,
                          height: iconSize,
                        ),
                        title: S.of(context).contactUs,
                      ),
                      _buildTile(
                        context: context,
                        height: tileHeight,
                        fontSize: fontSize,
                        iconSize: iconSize,
                        icon: Icons.lock_outline,
                        title: S.of(context).privacySecurity,
                      ),
                      Container(
                        height: tileHeight,
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE4F8F6), Color(0xFFC9F8FE)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                          ),
                          leading: Icon(
                            Icons.logout,
                            color: Colors.red,
                            size: iconSize,
                          ),
                          title: Text(
                            S.of(context).logout,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: fontSize,
                            ),
                          ),
                          onTap: () => context.go("/login"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInvisibleSwitch(BuildContext context, double screenWidth,
      double height, double fontSize, double iconSize) {
       
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Color(0xFFE4F8F6), Color(0xFFC9F8FE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        
        leading: Icon(
          _isInvisible ? Icons.visibility_off : Icons.visibility,
          color: const Color.fromRGBO(8, 194, 201, 1),
          size: iconSize,
        ),
        title: Row(
          children: [
            Text(
              S.of(context).invisibleTitle,
              style: TextStyle(
                color: KTextColor,
                fontWeight: FontWeight.w500,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
        trailing: Transform.scale(
          scale: 0.8,
          child: Switch(
            value: _isInvisible,
            onChanged: (val) {
              setState(() => _isInvisible = val);
              _showToast(
                context,
                val ?  'Invisible Mode Disabled':'Invisible Mode Enabled',
              );
            },
            activeColor: Colors.white,
            activeTrackColor: const Color.fromRGBO(8, 194, 201, 1),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey[300],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationSwitch(
    BuildContext context,
    double screenWidth,
    double height,
    double fontSize,
    double iconSize,
  ) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Color(0xFFE4F8F6), Color(0xFFC9F8FE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        leading: Icon(
          _isNotificationsEnabled
              ? Icons.notifications_active
              : Icons.notifications_off_outlined,
          color: const Color.fromRGBO(8, 194, 201, 1),
          size: iconSize + 4,
        ),
        title: Text(
          S.of(context).notifications,
          style: TextStyle(
            color: KTextColor,
            fontWeight: FontWeight.w500,
            fontSize: fontSize,
          ),
        ),
        trailing: Transform.scale(
          scale: 0.8,
          child: Switch(
            value: _isNotificationsEnabled,
            onChanged: (bool value) {
              setState(() => _isNotificationsEnabled = value);
              _showToast(
                context,
                value ? 'Notifications Enabled' : 'Notifications Disabled',
              );
            },
            activeColor: Colors.white,
            activeTrackColor: const Color.fromRGBO(8, 194, 201, 1),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey[300],
          ),
        ),
      ),
    );
  }

  Widget _buildTile({
    required BuildContext context,
    IconData? icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? ontap,
    Widget? customLeading,
    required double height,
    required double fontSize,
    required double iconSize,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Color(0xFFE4F8F6), Color(0xFFC9F8FE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        leading: customLeading ??
            Icon(
              icon,
              color: const Color.fromRGBO(8, 194, 201, 1),
              size: iconSize,
            ),
        title: Text(
          title,
          style: TextStyle(
            color: KTextColor,
            fontWeight: FontWeight.w500,
            fontSize: fontSize,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(
                  color: const Color.fromRGBO(8, 194, 201, 1),
                  fontSize: fontSize,
                ),
              )
            : null,
        trailing: trailing ??
            Icon(
              Icons.arrow_forward_ios,
              size: fontSize + 2,
              color: KTextColor,
            ),
        onTap: ontap,
      ),
    );
  }
}
