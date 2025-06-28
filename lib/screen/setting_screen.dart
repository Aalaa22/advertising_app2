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
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: widget.notifier,
      builder: (context, _) {
        final locale = widget.notifier.locale;

        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: CustomBottomNav(currentIndex: 4),
          body: SafeArea(
            child: ListView(
              children: [
                const SizedBox(height: 24),
                Center(
                  child: Image.asset(
                    'images/logo.png',
                    height: 98,
                    width: 125,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                _buildTile(
                  context: context,
                  customLeading: SvgPicture.asset(
                    'assets/icons/profile.svg',
                    width: 24,
                    height: 24,
                  ),
                  title: S.of(context).myProfile,
                  ontap: () => context.push('/editprofile'),
                ),
                _buildTile(
                  context: context,
                  customLeading: SvgPicture.asset(
                    'assets/icons/number.svg',
                    width: 12,
                    height: 12,
                  ),
                  title: S.of(context).createAgentCode,
                ),
                _buildNotificationSwitch(context, screenWidth),
                _buildTile(
                  context: context,
                  customLeading: SvgPicture.asset(
                    'assets/icons/language.svg',
                    width: 20,
                    height: 20,
                  ),
                  title: S.of(context).language,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: widget.notifier.toggleLocale,
                        child: Text(
                          locale.languageCode == 'ar'
                              ? S.of(context).engilsh
                              : S.of(context).arabic,
                          style: const TextStyle(
                            color: Color.fromRGBO(8, 194, 201, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_forward_ios,
                          size: 16, color: KTextColor),
                    ],
                  ),
                ),
                _buildTile(
                  context: context,
                  customLeading: SvgPicture.asset(
                    'assets/icons/contact-us.svg',
                    width: 22,
                    height: 22,
                  ),title: S.of(context).contactUs,
                ),
                _buildTile(
                  context: context,
                  customLeading: SvgPicture.asset(
                    'assets/icons/terms.svg',
                    width: 22,
                    height: 22,
                  ),
                  title: S.of(context).termsAndConditions,
                ),
                _buildTile(
                  context: context,
                  customLeading: SvgPicture.asset(
                    'assets/icons/support.svg',
                    width: 22,
                    height: 22,
                  ),
                  title: S.of(context).supportCenter,
                ),
                _buildTile(
                  context: context,
                  icon: Icons.lock_outline,
                  title: S.of(context).privacySecurity,
                ),
                Container(
                  height: 56,
                  margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: 4,
                  ),
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
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: Text(
                      S.of(context).logout,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    onTap: () {
                      context.go("/login");
                    },
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
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
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 58,
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: 4,
      ),
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
        leading: customLeading ??
            Icon(
              icon,
              color: const Color.fromRGBO(8, 194, 201, 1),
              weight: 16,
            ),
        title: Text(
          title,
          style: const TextStyle(
            color: KTextColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: const TextStyle(
                  color: Color.fromRGBO(8, 194, 201, 1),
                  fontSize: 15,
                ),
              )
            : null,
        trailing: trailing ??
            const Icon(Icons.arrow_forward_ios, size: 16, color: KTextColor),
        onTap: ontap,
      ),
    );
  }

  Widget _buildNotificationSwitch(BuildContext context, double screenWidth) {
    return Container(
      height: 58,
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: 4,
      ),
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
        leading: const Icon(
          Icons.notifications_none,
          color: Color.fromRGBO(8, 194, 201, 1),
          size: 28,
        ),
        title: Text(
          S.of(context).notifications,
          style: const TextStyle(
            color: KTextColor,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        trailing: Switch(
          value: true,
          onChanged: (bool value) {},
          activeColor: Colors.white,
          activeTrackColor: const Color.fromRGBO(8, 194, 201, 1),
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey[300],
        ),
      ),
    );
  }
}
