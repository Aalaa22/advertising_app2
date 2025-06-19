import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/router/local_notifier.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_elevated_button.dart';
import 'package:advertising_app/widget/custom_phone_field.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
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
    return AnimatedBuilder(
      animation: widget.notifier,
      builder: (context, _) {
        final locale = widget.notifier.locale;
        final isArabic = locale.languageCode == 'ar';

        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: ListView(
              children: [
                const SizedBox(height: 24),

                // ✅ زر تغيير اللغة
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: locale.languageCode != 'en'
                          ? widget.notifier.toggleLocale
                          : null,
                      child: Text(
                        S.of(context).engilsh,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: KTextColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: locale.languageCode != 'ar'
                          ? widget.notifier.toggleLocale
                          : null,
                      child: Text(
                        S.of(context).arabic,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: KTextColor,
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
                  S.of(context).phone,
                  style: const TextStyle(
                    color: KTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
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
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          S.of(context).emailLogin,
                          style: const TextStyle(
                            color: KTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Yourname@example.com',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(8, 194, 201, 1)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(8, 194, 201, 1)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),

                Text(
                  S.of(context).password,
                  style: const TextStyle(
                    color: KTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),

                CustomTextField(
                  hintText: '652454465',
                  suffixicon: IconButton(
                    icon: const Icon(Icons.visibility_off, color: KTextColor),
                    onPressed: () {},
                  ),
                ),

                const SizedBox(height: 20),

                CustomButton(
                  ontap: () {
                    context.go('/setting');
                  },
                  text: S.of(context).login,
                ),

                const SizedBox(height: 8),

                GestureDetector(
                  onTap: () {
                    context.go('/passphonelogin');
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
                    const Expanded(
                      child: Divider(color: KTextColor, thickness: 2),
                    ),
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
                    const Expanded(
                      child: Divider(color: KTextColor, thickness: 2),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                      onpress: () {
                        context.go('/emaillogin');
                      },
                      text: S.of(context).emailLogin,
                    ),
                    const SizedBox(width: 22),
                    CustomElevatedButton(
                      onpress: () {
                        context.go('/setting');
                      },
                      text: S.of(context).guestLogin,
                    ),
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
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
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

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
