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
    final locale = widget.notifier.locale;
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: widget.notifier,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: ListView(
              children: [
                const SizedBox(height: 24),
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
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: KTextColor,
                      ),
                    ),
                  ),
                ),
               Image.asset(
                      'images/logo.png',
                      fit: BoxFit.contain,
                      height: 98,
                      width: 125,
                    
                  ),
                  SizedBox(height: 10),
                  
                Text(
                  S.of(context).login,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: KTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  S.of(context).phone,
                  style: const TextStyle(
                    color: KTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
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
                        style: const TextStyle(
                          color: KTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    //  const SizedBox(height: 5),
                      CustomTextField(hintText: 'Yourname@example.com',)
                    ],
                  ),
                const SizedBox(height: 5),
                Text(
                  S.of(context).password,
                  style: const TextStyle(
                    color: KTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
               
              
                CustomTextField(
              hintText: '1234567',
              isPassword: true,
              
            ),
                const SizedBox(height: 20),
                CustomButton(
                  ontap: () {
                    context.push('/home');
                  },
                  text: S.of(context).login,
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    context.push('/passphonelogin');
                  },
                  child: Text(
                    S.of(context).forgotPassword,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
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
                          fontSize: 16,
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
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        onpress: () {
                          context.push('/emaillogin');
                        },
                        text: S.of(context).emailLogin,
                      ),
                    ),
                    const SizedBox(width: 16),
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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).dontHaveAccount,
                      style: const TextStyle(
                        color: KTextColor,
                       // fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        context.push('/');
                      },
                      child: Text(
                        S.of(context).createAccount,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: KTextColor,
                          decorationThickness: 1.5,
                          color: KTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
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
