import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../router/local_notifier.dart';

class VerifyPhoneCode extends StatelessWidget {
  final LocaleChangeNotifier notifier;

  const VerifyPhoneCode({super.key, required this.notifier});

  final String phoneNumber = "+971 5737357344";

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
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ListView(
                children: [
                  const SizedBox(height: 32),

                  /// Back + Language in one row
                  Row(
                    children: [
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
                      const Spacer(),
                      GestureDetector(
                        onTap: notifier.toggleLocale,
                        child: Text(
                          locale.languageCode == 'ar'
                              ? S.of(context).arabic : S.of(context).english,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: KTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// Logo
                  Center(
                    child: Image.asset(
                      'images/logo.png',
                      height: 98,
                      width: 125,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Title
                  Text(
                    S.of(context).verifnum,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: KTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Message
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      "${S.of(context).phoneverify} $phoneNumber",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: KTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Code Field
                  PinCodeTextField(
                    length: 4,
                    appContext: context,
                    onChanged: (value) {},
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 70,
                      fieldWidth: 70,
                      activeFillColor: Colors.white,
                      selectedColor: Colors.blue,
                      activeColor: const Color.fromRGBO(8, 194, 201, 1),
                      inactiveColor: const Color.fromRGBO(8, 194, 201, 1),
                    ),
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 18),

                  /// Button
                  CustomButton(
                    ontap: () {
                      context.push('/resetpass');
                    },
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