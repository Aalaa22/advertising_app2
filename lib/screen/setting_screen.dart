import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/widget/custom_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNav(currentIndex: 4),
      body: ListView(
        children: [
          Image.asset(
            'images/logo.png',
            height: 150,
            width: 150,
          ),
          _buildTile(
              icon: Icons.person_outline,
              title: S.of(context).myProfile,
              ontap: () {
                context.go('/profile');
              }),
          _buildTile(
            icon: Icons.numbers,
            title: S.of(context).createAccount,
          ),
          _buildNotificationSwitch(context),
          _buildTile(
            icon: Icons.language,
            title: S.of(context).language,
            trailing: Row(
              mainAxisSize: MainAxisSize.min, // مهم علشان ما ياخدش عرض زيادة
              children:  [
                Text(
                  S.of(context).engilsh ,
                  style: TextStyle(
                      color: Color.fromRGBO(8, 194, 201, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 16, color: KTextColor),
              ],
            ),
          ),
          _buildTile(icon: Icons.mail_outline, title:S.of(context).contactUs),
          _buildTile(icon: Icons.rule_outlined, title: S.of(context).termsAndConditions),
          _buildTile(icon: Icons.support_agent, title:S.of(context).supportCenter),
          _buildTile(icon: Icons.lock_outline, title: S.of(context).privacySecurity),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [Color(0xFFE4F8F6), Color(0xFFC9F8FE)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title:  Text(
               S.of(context).logout,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              onTap: () {
                // تنفيذ تسجيل الخروج هنا
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? ontap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Color(0xFFE4F8F6), // اللون الفاتح في البداية
            Color(0xFFC9F8FE), // اللون السماوي في النهاية
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Color.fromRGBO(8, 194, 201, 1)),
        title: Text(
          title,
          style: TextStyle(
            color: KTextColor,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        subtitle: subtitle != null
            ? Text(subtitle,
                style: TextStyle(color: Color.fromRGBO(8, 194, 201, 1)))
            : null,
        trailing: trailing ??
            const Icon(Icons.arrow_forward_ios, size: 16, color: KTextColor),
        onTap: ontap,
      ),
    );
  }

  Widget _buildNotificationSwitch(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: const LinearGradient(
        colors: [Color(0xFFE4F8F6), Color(0xFFC9F8FE)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        )
      ],
    ),
    child: ListTile(
      leading: const Icon(Icons.notifications_none,
          color: Color.fromRGBO(8, 194, 201, 1)),
      title: Text(
        S.of(context).notifications,
        style: const TextStyle(
          color: KTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 18,
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
