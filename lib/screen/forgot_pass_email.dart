import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ListView(
                children: [
                  const SizedBox(height: 32),

                  /// Back + Language
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
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
                              ? S.of(context).engilsh
                              : S.of(context).arabic,
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
                    S.of(context).forgetyourpass,
                    textAlign: TextAlign.center,
                    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                    style: const TextStyle(
                      color: KTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 16),

                  /// Label: Enter your email
                  Text(
                    S.of(context).enteremail,
                    textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                    style: const TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Email Field
                  CustomTextField(
                    hintText: 'Yourname@Example.com',
                  ),

                  const SizedBox(height: 20),

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
