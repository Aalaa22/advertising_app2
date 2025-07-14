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

class LoginScreen extends StatefulWidget {
  final LocaleChangeNotifier notifier;

  const LoginScreen({
    super.key,
    required this.notifier,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showEmailField = false;

  @override
  Widget build(BuildContext context) {
    final locale = widget.notifier.locale;

    return AnimatedBuilder(
      animation: widget.notifier,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: ListView(
              children: [
                SizedBox(height: 24.h),
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
                  S.of(context).login,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: KTextColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  S.of(context).phone,
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
                      Text(
                        S.of(context).emailLogin,
                        style: TextStyle(
                          color: KTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                      CustomTextField(hintText: 'Yourname@example.com'),
                    ],
                  ),
                SizedBox(height: 5.h),
                Text(
                  S.of(context).password,
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
                SizedBox(height: 20.h),
                CustomButton(
                  ontap: () {
                    context.push('/home');
                  },
                  text: S.of(context).login,
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: () {
                    context.push('/passphonelogin');
                  },
                  child: Text(
                    S.of(context).forgotPassword,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.5,
                      color: KTextColor,
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(color: KTextColor, thickness: 2),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        S.of(context).or,
                        style: TextStyle(
                          color: KTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(color: KTextColor, thickness: 2),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        onpress: () {
                          context.push('/emaillogin');
                        },
                        text: S.of(context).emailLogin,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomElevatedButton(
                        onpress: () {
                          context.push('/home');
                        },
                        text: S.of(context).guestLogin,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).dontHaveAccount,
                      style: TextStyle(
                        color: KTextColor,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: () {
                        context.push('/');
                      },
                      child: Text(
                        S.of(context).createAccount,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: KTextColor,
                          decorationThickness: 1.5,
                          color: KTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
