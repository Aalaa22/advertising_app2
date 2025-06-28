import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/router/local_notifier.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_elevated_button.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailSignUpScreen extends StatefulWidget {
  final LocaleChangeNotifier notifier;

  const EmailSignUpScreen({
    super.key,
    required this.notifier,
  });

  @override
  State<EmailSignUpScreen> createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen> {
  bool isChecked = false;
  bool showEmailField = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final isTablet = mediaQuery.width >= 600;

    return AnimatedBuilder(
      animation: widget.notifier,
      builder: (context, _) {
        final locale = widget.notifier.locale;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
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
                    S.of(context).signUp,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: KTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    S.of(context).userName,
                    style: const TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  CustomTextField(hintText: "Ralph Edwards"),
                  const SizedBox(height: 5),
                  Text(
                    S.of(context).email,
                    style: const TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                 CustomTextField(hintText: "Yourname@Example.Com",),
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
                  const SizedBox(height: 5),
                  Text(
                    S.of(context).referralCode,
                    style: const TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  CustomTextField(hintText: 'xxxxx'),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                        activeColor: const Color.fromRGBO(1, 84, 126, 1),
                        checkColor: Colors.white,
                      ),
                      Expanded(
                        child: Text(
                          S.of(context).agreeTerms,
                          style: const TextStyle(
                            fontSize: 14,
                            color: KTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push('/login');
                    },
                    child: CustomButton(text: S.of(context).register),
                  ),
                  const SizedBox(height: 4),
                  Center(
                    child: Text(
                      S.of(context).or,
                      style: const TextStyle(
                        color: KTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: CustomElevatedButton(
                          onpress: () {
                            context.push('/');
                          },
                          text: S.of(context).phonesignup,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: CustomElevatedButton(
                          onpress: () {
                            context.push("/home");
                          },
                          text: S.of(context).guestLogin,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).haveAccount,
                        style: const TextStyle(
                          color: KTextColor,
                          fontSize: 14,
                          //fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          context.push('/login');
                        },
                        child: Text(
                          S.of(context).login,
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: KTextColor,
                            decorationThickness: 1.5,
                            color: KTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

