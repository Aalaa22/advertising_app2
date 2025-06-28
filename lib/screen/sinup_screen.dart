import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/router/local_notifier.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_elevated_button.dart';
import 'package:advertising_app/widget/custom_phone_field.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  final LocaleChangeNotifier notifier;

  const SignUpScreen({
    super.key,
    required this.notifier,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                    S.of(context).userName ,
                    style: const TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  CustomTextField(hintText: "Ralph Edwards"),
                  const SizedBox(height: 5),
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
                        const SizedBox(height: 5),
                        Text(
                          S.of(context).emailSignUp,
                          style: const TextStyle(
                            color: KTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField( hintText: 'Yourname@Example.com')
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
                            context.push('/emailsignup');
                          },
                          text: S.of(context).emailSignUp,
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



// class SignUpScreen extends StatefulWidget {
//   final LocaleChangeNotifier notifier;

//   const SignUpScreen({
//     super.key,
//     required this.notifier,
//   });

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   bool isChecked = false;
//   bool showEmailField = false;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: widget.notifier,
//       builder: (context, _) {
//         final locale = widget.notifier.locale;

//         return Scaffold(
//           backgroundColor: Colors.white,
//           body: SafeArea(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 18),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const SizedBox(height: 16),
//                  Align(
//   alignment: locale.languageCode == 'ar'
//       ? Alignment.topLeft
//       : Alignment.topRight,
//   child: GestureDetector(
//     onTap: widget.notifier.toggleLocale,
//     child: Text(
//       locale.languageCode == 'ar'
//           ? S.of(context).engilsh
//           : S.of(context).arabic,
//       style: const TextStyle(
//         fontSize: 22,
//         fontWeight: FontWeight.w500,
//         color: KTextColor,
//       ),
//     ),
//   ),
// ),
//                   Image.asset('images/logo.png', height: 150, width: 150),
//                   Text(
//                     S.of(context).signUp,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       color: KTextColor,
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 7),
//                   Text(
//                     S.of(context).userName,
//                     style: const TextStyle(
//                       color: KTextColor,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 18,
//                     ),
//                   ),
//                   CustomTextField(hintText: S.of(context).userName),
//                   const SizedBox(height: 5),
//                   Text(
//                     S.of(context).phone,
//                     style: const TextStyle(
//                       color: KTextColor,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 18,
//                     ),
//                   ),
//                   CustomPhoneField(
//                     onCountryChanged: (code) {
//                       setState(() {
//                         showEmailField = code != 'AE';
//                       });
//                     },
//                   ),
//                   if (showEmailField)
//                     Column(
//                       children: [
//                         Align(
//                           alignment: Alignment.bottomLeft,
//                           child: Text(
//                             S.of(context).emailSignUp,
//                             style: const TextStyle(
//                               color: KTextColor,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                         TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Yourname@example.com',
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Color.fromRGBO(8, 194, 201, 1)),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Color.fromRGBO(8, 194, 201, 1)),
//                             ),
//                             border: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Color.fromRGBO(8, 194, 201, 1)),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   Text(
//                     S.of(context).password,
//                     style: const TextStyle(
//                       color: KTextColor,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 18,
//                     ),
//                   ),
//                   CustomTextField(
//                     hintText: '******',
//                     suffixicon: IconButton(
//                       icon: const Icon(
//                         Icons.visibility_off,
//                         color: KTextColor,
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     S.of(context).referralCode,
//                     style: const TextStyle(
//                       color: KTextColor,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 18,
//                     ),
//                   ),
//                   CustomTextField(hintText: 'xxxxx'),
//                   const SizedBox(height: 2),
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: isChecked,
//                         onChanged: (value) {
//                           setState(() {
//                             isChecked = value!;
//                           });
//                         },
//                         activeColor: const Color.fromRGBO(1, 84, 126, 1),
//                         checkColor: Colors.white,
//                       ),
//                       Text(
//                         S.of(context).agreeTerms,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           color: KTextColor,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                   GestureDetector(
//                       onTap: () {
//                         context.push('/login');
//                       },
//                       child: CustomButton(text: S.of(context).register)),
//                   const SizedBox(height: 4),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Center(
//                       child: Text(
//                         S.of(context).or,
//                         style: const TextStyle(
//                           color: KTextColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CustomElevatedButton(
//                         onpress: () {
//                           context.push('/emailsignup');
//                         },
//                         text: S.of(context).emailSignUp,
//                       ),
//                       const SizedBox(width: 16),
//                       CustomElevatedButton(
//                         onpress: () {
//                           context.push("/home");
//                         },
//                         text: S.of(context).guestLogin,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         S.of(context).haveAccount,
//                         style: const TextStyle(
//                           color: KTextColor,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           context.push('/login');
//                         },
//                         child: Text(
//                           S.of(context).login,
//                           style: const TextStyle(
//                             decoration: TextDecoration.underline,
//                             decorationColor: KTextColor,
//                             decorationThickness: 1.5,
//                             color: KTextColor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
