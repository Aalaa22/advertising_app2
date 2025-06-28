import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/widget/custom_bottom_nav.dart';
import 'package:advertising_app/widget/custom_phone_field.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showEmailField = false;

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
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                context.pop();
              },
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
            CustomTextField(hintText: "Ralph Edwards"),
            _buildLabel(S.of(context).phone, baseFontSize),
            CustomPhoneField(onCountryChanged: (_) {}),
            _buildLabel(S.of(context).whatsApp, baseFontSize),
            CustomPhoneField(onCountryChanged: (_) {}),
            _buildLabel(S.of(context).password, baseFontSize),
            CustomTextField(
              hintText: '1234567',
              isPassword: true,
            ),
            _buildLabel(S.of(context).email, baseFontSize),
            CustomTextField(hintText: 'Name@Example.Com'),
            _buildLabel(S.of(context).advertiserName, baseFontSize),
            CustomTextField(hintText: S.of(context).optional),
            _buildLabel(S.of(context).advertiserType, baseFontSize),
            CustomTextField(hintText: S.of(context).optional),
            _buildLabel(S.of(context).advertiserLogo, baseFontSize),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(8, 194, 201, 1)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: KTextColor),
                    SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        S.of(context).advertiserLogo,
                        style: TextStyle(
                            color: KTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
             
             Text(
                        S.of(context).advertiserLocation,
                        style: TextStyle(
                            color: KTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        
                      ),
                      SizedBox(height: 5,),
                      Text(
                        S.of(context).address,
                        style: TextStyle(
                            color: KTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5,),
            _buildMapSection(context, headingFontSize),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      S.of(context).cancel,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: KTextColor,
                      side: BorderSide(color: Color.fromRGBO(8, 194, 201, 1)),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      S.of(context).save,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF01547E),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 10),
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
          Positioned(
            top: 180,
            // bottom: 150,
            left: 30,
            right: 30,
            child: Icon(Icons.location_pin, color: Colors.red, size: 40),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton.icon(
              icon: Icon(Icons.location_on_outlined,
                  color: Colors.white, size: 26),
              label: Text(
                S.of(context).locateMe,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF01547E),
                minimumSize: Size(double.infinity, 48),
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
