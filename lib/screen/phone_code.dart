import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/router/local_notifier.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ForgotPassPhone extends StatefulWidget {
  final LocaleChangeNotifier notifier;

  const ForgotPassPhone({super.key, required this.notifier});

  @override
  State<ForgotPassPhone> createState() => _ForgotPassPhoneState();
}

class _ForgotPassPhoneState extends State<ForgotPassPhone> {
  bool showEmailField = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.notifier,
        builder: (context, _) {
          final locale = widget.notifier.locale;

          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: ListView(
                children: [
                  SizedBox(height: 32.h),
                  GestureDetector(
                    onTap: () {
                      context.pop(); 
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios, color: KTextColor, size: 20.sp),
                        SizedBox(width: 4.w),
                        Text(
                          S.of(context).back,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: KTextColor,
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: locale.languageCode == 'ar'
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: GestureDetector(
                            onTap: widget.notifier.toggleLocale,
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
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),
                  Center(
                    child: Image.asset(
                      'images/logo.png',
                      fit: BoxFit.contain,
                      height: 98.h,
                      width: 125.w,
                    ),
                  ),

                  SizedBox(height: 10.h),
                  Text(
                    S.of(context).forgetyourpass,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: KTextColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),

                  SizedBox(height: 15.h),
                  Text(
                    S.of(context).enterphone,
                    style: TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
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
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: TextField(
                        style: TextStyle(fontSize: 14.sp),
                        decoration: InputDecoration(
                          labelText: S.of(context).email,
                          labelStyle: TextStyle(fontSize: 14.sp),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color.fromRGBO(8, 194, 201, 1),
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),

                  SizedBox(height: 20.h),
                  CustomButton(
                    ontap: () {
                      context.push('/phonecode');
                    },
                    text: S.of(context).sendcode,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
