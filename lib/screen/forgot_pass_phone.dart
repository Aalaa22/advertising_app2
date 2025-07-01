import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/router/local_notifier.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_phone_field.dart';
import 'package:flutter/material.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
        animation: widget.notifier,
        builder: (context, _) {
          final locale = widget.notifier.locale;

          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ListView(
                children: [
                  const SizedBox(height: 32),
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
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: KTextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Image.asset(
                    'images/logo.png',
                    fit: BoxFit.contain,
                    height: 98,
                    width: 125,
                  ),
                  SizedBox(height: 10),
                  Text(
                    S.of(context).forgetyourpass,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: KTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    S.of(context).enterphone,
                    style: const TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 3,
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
                      padding: const EdgeInsets.only(top: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: S.of(context).email,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(8, 194, 201, 1),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
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
