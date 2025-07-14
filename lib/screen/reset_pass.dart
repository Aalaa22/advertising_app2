import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../router/local_notifier.dart';

class ResetPassword extends StatelessWidget {
  final LocaleChangeNotifier notifier;

  const ResetPassword({super.key, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: notifier,
      builder: (context, _) {
        final locale = notifier.locale;
        final isArabic = locale.languageCode == 'ar';

        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: ListView(
                children: [
                  SizedBox(height: 32.h),

                  /// Back + Language in one row
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back_ios, color: KTextColor),
                            SizedBox(width: 4.w),
                            Text(
                              S.of(context).back,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: KTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: notifier.toggleLocale,
                        child: Text(
                          locale.languageCode == 'ar'
                              ?S.of(context).arabic : S.of(context).english,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: KTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  /// Logo
                  Center(
                    child: Image.asset(
                      'images/logo.png',
                      height: 98.h,
                      width: 125.w,
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  /// Title
                  Text(
                    S.of(context).resetpass,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: KTextColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  /// New Password
                  Text(
                    S.of(context).newpass,
                    style: TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  CustomTextField(
                    hintText: '1234567',
                    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                    isPassword: true,
                  ),

                  SizedBox(height: 10.h),

                  /// Confirm Password
                  Text(
                    S.of(context).confirmpass,
                    style: TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  CustomTextField(
                    hintText: '1234567',
                    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                    isPassword: true,
                  ),

                  SizedBox(height: 20.h),

                  /// Confirm Button
                  CustomButton(
                    ontap: () => context.push('/login'),
                    text: S.of(context).confirm,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}