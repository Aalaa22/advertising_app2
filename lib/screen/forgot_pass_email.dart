import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../router/local_notifier.dart';

class ForgotPassEmail extends StatelessWidget {
  final LocaleChangeNotifier notifier;

  const ForgotPassEmail({super.key, required this.notifier});

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

                  /// Back + Language
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
                              ? S.of(context).engilsh
                              : S.of(context).arabic,
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
                    S.of(context).forgetyourpass,
                    textAlign: TextAlign.center,
                    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                    style: TextStyle(
                      color: KTextColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 16.h),

                  /// Label: Enter your email
                  Text(
                    S.of(context).enteremail,
                    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                    style: TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  /// Email Field
                  CustomTextField(
                    hintText: 'Yourname@Example.com',
                  ),

                  SizedBox(height: 20.h),

                  /// Send Code Button
                  CustomButton(
                    ontap: () {
                      context.push('/emailcode');
                    },
                    text: S.of(context).sendcode,
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