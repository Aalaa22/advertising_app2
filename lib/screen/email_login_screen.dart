import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/router/local_notifier.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_elevated_button.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmailLoginScreen extends StatefulWidget {
  final LocaleChangeNotifier notifier;

  const EmailLoginScreen({
    super.key,
    required this.notifier,
  });

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = widget.notifier.locale;
    final isArabic = locale.languageCode == 'ar';
    final screenWidth = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ListView(
            children: [
              const SizedBox(height: 24),

              /// لغة التبديل
              Align(
                alignment: isArabic ? Alignment.topLeft : Alignment.topRight,
                child: GestureDetector(
                  onTap: widget.notifier.toggleLocale,
                  child: Text(
                    isArabic ? S.of(context).engilsh : S.of(context).arabic,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: KTextColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// اللوجو
              Center(
                child: Image.asset(
                  'images/logo.png',
                  height:98,
                  width: 125,
                ),
              ),

              const SizedBox(height: 10),

              /// العنوان الرئيسي
              Text(
                S.of(context).login,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: KTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 18),

              /// الإيميل
              Text(
                S.of(context).emailLogin,
                style: const TextStyle(
                  color: KTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize:16,
                ),
              ),
              CustomTextField(hintText:'YourName@Example.Com'),

              const SizedBox(height: 8),

              /// الباسورد
              Text(
                S.of(context).password,
                style: const TextStyle(
                  color: KTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize:16,
                ),
              ),
              CustomTextField(hintText: '1234567',isPassword: true,),

              const SizedBox(height: 20),

              /// زرار الدخول
              CustomButton(
                text: S.of(context).login,
                ontap: () {
                  context.push('/home');
                },
              ),

              const SizedBox(height: 8),

              /// نسيان الباسورد
              GestureDetector(
                onTap: () {
                  context.push('/forgetpassemail');
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

              /// خط فاصل + كلمة OR
              Row(
                children: [
                  const Expanded(
                      child: Divider(color: KTextColor, thickness: 2)),
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
                      child: Divider(color: KTextColor, thickness: 2)),
                ],
              ),

              const SizedBox(height: 16),

              /// زرارين: الدخول برقم الهاتف و الدخول كزائر
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      onpress: () {
                        context.push('/login');
                      },
                      text: S.of(context).phoneLogin,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomElevatedButton(
                      onpress: () {},
                      text: S.of(context).guestLogin,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// إنشاء حساب
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).dontHaveAccount,
                    style: const TextStyle(
                      color: KTextColor,
                      fontSize: 12,
                     // fontWeight: FontWeight.w500,
                    ),
                  ),
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
      ),
    );
  }
}
