import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../router/local_notifier.dart';

class VerifyEmailCode extends StatelessWidget {
  final LocaleChangeNotifier notifier;

  const VerifyEmailCode({super.key, required this.notifier});

  final String email = "yourname@example.com";

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
                    S.of(context).verifnum,
                    textAlign: TextAlign.center,
                    textDirection:
                        isArabic ? TextDirection.rtl : TextDirection.ltr,
                    style: TextStyle(
                      color: KTextColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  /// Sub Title
                  Text(
                    S.of(context).emilverify,
                    textAlign: TextAlign.center,
                    textDirection:
                        isArabic ? TextDirection.rtl : TextDirection.ltr,
                    style: TextStyle(
                      color: KTextColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  /// Code Field
                  PinCodeTextField(
                    length: 4,
                    appContext: context,
                    onChanged: (value) {},
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8.r),
                      fieldHeight: 70.h,
                      fieldWidth: 70.w,
                      activeFillColor: Colors.white,
                      selectedColor: Colors.blue,
                      activeColor: const Color.fromRGBO(8, 194, 201, 1),
                      inactiveColor: const Color.fromRGBO(8, 194, 201, 1),
                    ),
                    keyboardType: TextInputType.number,
                  ),

                  SizedBox(height: 18.h),

                  /// Verify Button
                  CustomButton(
                    ontap: () => context.push('/resetpass'),
                    text: S.of(context).verify,
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