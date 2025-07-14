import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/router/local_notifier.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_elevated_button.dart';
import 'package:advertising_app/widget/custom_phone_field.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  final LocaleChangeNotifier notifier;

  const SignUpScreen({
    super.key,
    required this.notifier,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  bool showEmailField = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final isTablet = mediaQuery.width >= 600;

    return AnimatedBuilder(
      animation: widget.notifier,
      builder: (context, _) {
        final locale = widget.notifier.locale;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 40.w : 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16.h),
                  Align(
                    alignment: locale.languageCode == 'ar'
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: GestureDetector(
                      onTap: widget.notifier.toggleLocale,
                      child: Text(
                        locale.languageCode == 'ar'
                            ? S.of(context).arabic : S.of(context).english,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: KTextColor,
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    'images/logo.png',
                    fit: BoxFit.contain,
                    height: 98.h,
                    width: 125.w,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    S.of(context).signUp,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: KTextColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 7.h),
                  Text(
                   '${S.of(context).userName}*',
                    style: TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  CustomTextField(hintText: "Ralph Edwards"),
                  SizedBox(height: 5.h),
                  Text(
                    '${S.of(context).phone }*',
                    style: TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  CustomPhoneField(
                    onCountryChanged: (code) {
                      setState(() {
                        showEmailField = code != 'AE';
                      });
                    },
                  ),
                  if (showEmailField)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.h),
                        Text(
                        ' ${S.of(context).emailSignUp} *',
                          style: TextStyle(
                            color: KTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        CustomTextField(hintText: 'Yourname@Example.com')
                      ],
                    ),
                  SizedBox(height: 5.h),
                  Text(
                    "${S.of(context).password}*",
                    style: TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  CustomTextField(
                    hintText: '1234567',
                    isPassword: true,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    S.of(context).referralCode,
                    style: TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  CustomTextField(hintText: 'xxxxx'),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                        activeColor: const Color.fromRGBO(1, 84, 126, 1),
                        checkColor: Colors.white,
                      ),
                      Expanded(
                        child: Text(
                          S.of(context).agreeTerms,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: KTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push('/login');
                    },
                    child: CustomButton(text: S.of(context).register),
                  ),
                  SizedBox(height: 4.h),
                  Center(
                    child: Text(
                      S.of(context).or,
                      style: TextStyle(
                        color: KTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: CustomElevatedButton(
                          onpress: () {
                            context.push('/emailsignup');
                          },
                          text: S.of(context).emailSignUp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Flexible(
                        child: CustomElevatedButton(
                          onpress: () {
                            context.push("/home");
                          },
                          text: S.of(context).guestLogin,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).haveAccount,
                        style: TextStyle(
                          color: KTextColor,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      GestureDetector(
                        onTap: () {
                          context.push('/login');
                        },
                        child: Text(
                          S.of(context).login,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: KTextColor,
                            decorationThickness: 1.5,
                            color: KTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
