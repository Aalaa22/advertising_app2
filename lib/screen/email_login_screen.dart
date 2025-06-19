import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/router/local_notifier.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_elevated_button.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailLoginScreen extends StatelessWidget {
  final LocaleChangeNotifier notifier;

  const EmailLoginScreen({
    super.key,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: notifier,
      builder: (context, _) {
        final locale = notifier.locale;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: ListView(
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: locale.languageCode != 'en'
                          ? notifier.toggleLocale
                          : null,
                      child: Text(
                        S.of(context).engilsh,
                        style: const TextStyle(
                          color: KTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: locale.languageCode != 'ar'
                          ? notifier.toggleLocale
                          : null,
                      child: Text(
                        S.of(context).arabic,
                        style: const TextStyle(
                          color: KTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
                Image.asset('images/logo.png', height: 150, width: 150),
                Text(
                  S.of(context).login,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: KTextColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  S.of(context).emailLogin,
                  style: const TextStyle(
                    color: KTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                CustomTextField(hintText: 'yourName@example.com'),
                const SizedBox(height: 8),
                Text(
                  S.of(context).password,
                  style: const TextStyle(
                    color: KTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                CustomTextField(hintText: '••••••••'),
                const SizedBox(height: 20),
                CustomButton(text: S.of(context).login),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    context.go('/passemaillogin');
                  },
                  child: Text(
                    S.of(context).forgotPassword,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.5,
                      color: KTextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Expanded(child: Divider(color: KTextColor, thickness: 2)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        S.of(context).or,
                        style: const TextStyle(
                          color: KTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: KTextColor, thickness: 2)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                      onpress: () {
                        context.go('/');
                      },
                      text: S.of(context).phoneLogin,
                    ),
                    const SizedBox(width: 22),
                    CustomElevatedButton(
                      onpress: () {},
                      text: S.of(context).guestLogin,
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).dontHaveAccount,
                      style: const TextStyle(
                        color: KTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go('/signup');
                      },
                      child: Text(
                        S.of(context).createAccount,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: KTextColor,
                          decorationThickness: 1.5,
                          color: KTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
