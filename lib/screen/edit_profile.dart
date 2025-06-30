import 'package:flutter/material.dart';
import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/widget/custom_bottom_nav.dart';
import 'package:advertising_app/widget/custom_phone_field.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:go_router/go_router.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 360;
    final baseFontSize = isSmall ? 14.0 : 18.0;
    final headingFontSize = isSmall ? 20.0 : 25.0;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNav(currentIndex: 4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => context.pop(),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios, color: KTextColor),
                  const SizedBox(width: 4),
                  Text(
                    S.of(context).back,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: KTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                S.of(context).myProfile,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: KTextColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildLabel(S.of(context).userName, baseFontSize),
            _buildEditableField(
                "Ralph Edwards", () => context.push('/profile')),
            _buildLabel(S.of(context).phone, baseFontSize),
            _buildPhonePopup(() => context.push('/profile')),
            _buildLabel(S.of(context).whatsApp, baseFontSize),
            _buildPhonePopup(() => context.push('/profile')),
            _buildLabel(S.of(context).password, baseFontSize),
            _buildEditableField('1234567', () => context.push('/profile'),
                isPassword: true),
            _buildLabel(S.of(context).email, baseFontSize),
            _buildEditableField(
                'Name@Example.Com', () => context.push('/profile')),
            _buildLabel(S.of(context).advertiserName, baseFontSize),
            _buildEditableField(
                S.of(context).optional, () => context.push('/profile')),
            _buildLabel(S.of(context).advertiserType, baseFontSize),
            _buildEditableField(
                S.of(context).optional, () => context.push('/profile')),
            _buildLabel(S.of(context).advertiserLogo, baseFontSize),
            GestureDetector(
              onTap: () {
                _showEditPopup(() => context.push('/profile'));
              },
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromRGBO(8, 194, 201, 1)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.camera_alt, color: KTextColor),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        S.of(context).advertiserLogo,
                        style: const TextStyle(
                          color: KTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).advertiserLocation,
              style: const TextStyle(
                color: KTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              S.of(context).address,
              style: const TextStyle(
                color: KTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            _buildMapSection(context, headingFontSize),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/profile');
                    },
                    child: Text(
                      S.of(context).editprof4,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF01547E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  // ======= عناصر فرعية =======

  Widget _buildLabel(String text, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 0),
      child: Text(
        text,
        style: TextStyle(
          color: KTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildEditableField(String hint, VoidCallback onEdit,
      {bool isPassword = false}) {
    return GestureDetector(
      onTap: () => _showEditPopup(onEdit),
      child: AbsorbPointer(
        child: CustomTextField(
          hintText: hint,
          isPassword: isPassword,
        ),
      ),
    );
  }

  Widget _buildPhonePopup(VoidCallback onEdit) {
    return GestureDetector(
      onTap: () => _showEditPopup(onEdit),
      child: AbsorbPointer(
        child: CustomPhoneField(onCountryChanged: (_) {}),
      ),
    );
  }

  void _showEditPopup(VoidCallback onEdit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.white,
        elevation: 10,
        title: Row(
          children: [
            Icon(Icons.edit, color: Color(0xFF01547E)),
            SizedBox(width: 8),
            Text(
             S.of(context).editing1,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF01547E),
              ),
            ),
          ],
        ),
        content: Text(
          S.of(context).editit2,
          style: TextStyle(fontSize: 16, color: KTextColor),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              S.of(context).cancel,
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onEdit();
            },
            child: Text(S.of(context).edit3),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF01547E),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection(BuildContext context, double fontSize) {
    return SizedBox(
      height: 320,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/map.png',
              fit: BoxFit.cover,
            ),
          ),
          const Positioned(
            top: 180,
            left: 30,
            right: 30,
            child: Icon(Icons.location_pin, color: Colors.red, size: 40),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.location_on_outlined,
                  color: Colors.white, size: 26),
              label: Text(
                S.of(context).locateMe,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF01547E),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
