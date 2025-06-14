import 'package:advertising_app/screen/email_code.dart';
import 'package:advertising_app/screen/email_login_screen.dart';
import 'package:advertising_app/screen/email_signup.dart';
import 'package:advertising_app/screen/forgot_pass_email.dart';
import 'package:advertising_app/screen/forgot_pass_phone.dart';
import 'package:advertising_app/screen/login_screen.dart';
import 'package:advertising_app/screen/phone_code.dart';
import 'package:advertising_app/screen/reset_pass.dart';
import 'package:advertising_app/screen/sinup_screen.dart';
import 'package:advertising_app/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(AdvertisingApp());
}

class AdvertisingApp extends StatelessWidget {
  AdvertisingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }

  final GoRouter _router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashGridScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) {
        return SignUpScreen();
      },
    ),
    GoRoute(
      path: '/emaillogin',
      builder: (context, state) {
        return EmailLoginScreen();
      },
    ),
    GoRoute(
      path: '/passphonelogin',
      builder: (context, state) {
        return ForgotPassPhone();
      },
    ),
    GoRoute(
      path: '/passemaillogin',
      builder: (context, state) {
        return ForgotPassEmail();
      },
    ),
    GoRoute(
      path: '/phonecode',
      builder: (context, state) {
        return VerifyPhoneCode();
      },
    ),
    
    GoRoute(
      path: '/emailcode',
      builder: (context, state) {
        return VerifyEmailCode();
      },
    ),
    GoRoute(
      path: '/resetpass',
      builder: (context, state) {
        return ResetPassword();
      },
    ),
    GoRoute(
      path: '/emailsignup',
      builder: (context, state) {
        return EmailSignup();
      },
    ),
    
  ]);
}
