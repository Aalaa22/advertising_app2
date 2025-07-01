import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/router/local_notifier.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_elevated_button.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EmailLoginScreen extends StatefulWidget {
  final LocaleChangeNotifier notifier;

  const EmailLoginScreen({
    super.key,
    required this.notifier,
  });

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = widget.notifier.locale;
    final isArabic = locale.languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: ListView(
            children: [
              SizedBox(height: 24.h),
              Align(
                alignment: isArabic ? Alignment.topLeft : Alignment.topRight,
                child: GestureDetector(
                  onTap: widget.notifier.toggleLocale,
                  child: Text(
                    isArabic ? S.of(context).engilsh : S.of(context).arabic,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: KTextColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Center(
                child: Image.asset(
                  'images/logo.png',
                  height: 98.h,
                  width: 125.w,
                ),
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
              SizedBox(height: 18.h),
              Text(
                S.of(context).emailLogin,
                style: TextStyle(
                  color: KTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              CustomTextField(hintText: 'YourName@Example.Com'),
              SizedBox(height: 8.h),
              Text(
                S.of(context).password,
                style: TextStyle(
                  color: KTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              CustomTextField(hintText: '1234567', isPassword: true),
              SizedBox(height: 20.h),
              CustomButton(
                text: S.of(context).login,
                ontap: () {
                  context.push('/home');
                },
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () {
                  context.push('/forgetpassemail');
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
                      child: Divider(color: KTextColor, thickness: 2)),
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
                      child: Divider(color: KTextColor, thickness: 2)),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      onpress: () {
                        context.push('/login');
                      },
                      text: S.of(context).phoneLogin,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: CustomElevatedButton(
                      onpress: () {},
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
      ),
    );
  }
}
