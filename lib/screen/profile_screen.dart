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
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNav(currentIndex: 4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: KTextColor),
                        onPressed: () {
                          context.go('/setting');
                        },
                      ),
                      Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: KTextColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    S.of(context).myProfile,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: KTextColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    S.of(context).userName,
                    style: TextStyle(
                        color: KTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  CustomTextField(hintText: S.of(context).userName),
                  const SizedBox(height: 5),
                  Text(
                    S.of(context).phone,
                    style: TextStyle(
                        color: KTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  CustomPhoneField(
                    onCountryChanged: (code) {
                      //  setState(() {
                      //   showEmailField = code != 'AE';
                      //  });
                    },
                  ),
                  Text(
                    S.of(context).whatsApp,
                    style: TextStyle(
                        color: KTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  CustomPhoneField(
                    onCountryChanged: (code) {
                      // setState(() {
                      //   showEmailField = code != 'AE';
                      // });
                    },
                  ),
                  Text(
                    S.of(context).password,
                    style: TextStyle(
                        color: KTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  CustomTextField(
                    hintText: '812365104',
                    suffixicon: IconButton(
                      icon: Icon(
                        Icons.visibility_off,
                        color: KTextColor,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    S.of(context).email,
                    style: TextStyle(
                        color: KTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  CustomTextField(hintText: 'yourName@example.com'),
                  const SizedBox(height: 10),
                  Text(
                    S.of(context).advertiserName,
                    style: TextStyle(
                        color: KTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  CustomTextField(hintText: S.of(context).optional),
                  const SizedBox(height: 10),
                  Text(
                    S.of(context).advertiserType,
                    style: TextStyle(
                        color: KTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  CustomTextField(hintText: S.of(context).optional),
                  const SizedBox(height: 10),
                  Text(
                    S.of(context).advertiserLogo,
                    style: TextStyle(
                        color: KTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromRGBO(8, 194, 201, 1)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, color: KTextColor),
                          SizedBox(width: 10),
                          Text(
                            'Upload Your Logo',
                            style: TextStyle(
                              color: KTextColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 300,
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
                          bottom: 120,
                          left: 20,
                          right: 20,
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 50,
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          left: 20,
                          right: 20,
                          child: ElevatedButton.icon(
                            icon: Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            label: Text(
                              S.of(context).locateMe,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF01547E),
                              minimumSize: Size(double.infinity, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            S.of(context).cancel,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: KTextColor,
                            side: BorderSide(
                              color: Color.fromRGBO(8, 194, 201, 1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(S.of(context).save,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF01547E),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
