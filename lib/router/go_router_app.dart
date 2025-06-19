import 'dart:ui';

import 'package:advertising_app/router/local_notifier.dart';
import 'package:advertising_app/screen/email_code.dart';
import 'package:advertising_app/screen/email_login_screen.dart';
import 'package:advertising_app/screen/email_signup.dart';
import 'package:advertising_app/screen/favorite_screen.dart';
import 'package:advertising_app/screen/forgot_pass_email.dart';
import 'package:advertising_app/screen/forgot_pass_phone.dart';
import 'package:advertising_app/screen/home_screen.dart';
import 'package:advertising_app/screen/login_screen.dart';
import 'package:advertising_app/screen/manage_screen.dart';
import 'package:advertising_app/screen/phone_code.dart';
import 'package:advertising_app/screen/post_ad_screen.dart';
import 'package:advertising_app/screen/profile_screen.dart';
import 'package:advertising_app/screen/reset_pass.dart';
import 'package:advertising_app/screen/setting_screen.dart';
import 'package:advertising_app/screen/sinup_screen.dart';
import 'package:go_router/go_router.dart';



 GoRouter createRouter({
  required LocaleChangeNotifier notifier,
}) {
  return GoRouter(
    refreshListenable: notifier, // ✅ مهم
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LoginScreen(
           notifier: notifier,
        ),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignUpScreen(
         notifier: notifier,
        ),
      ),
      GoRoute(
        path: '/emaillogin',
        builder: (context, state) =>  EmailLoginScreen(
          notifier: notifier,
        ),
      ),
      GoRoute(
        path: '/passphonelogin',
        builder: (context, state) => ForgotPassPhone(),
      ),
      GoRoute(
        path: '/passemaillogin',
        builder: (context, state) => ForgotPassEmail(),
      ),
      GoRoute(
        path: '/phonecode',
        builder: (context, state) =>  VerifyPhoneCode(),
      ),
      GoRoute(
        path: '/emailcode',
        builder: (context, state) => VerifyEmailCode(),
      ),
      GoRoute(
        path: '/resetpass',
        builder: (context, state) =>  ResetPassword(),
      ),
      GoRoute(
        path: '/emailsignup',
        builder: (context, state) =>  EmailSignup(),
      ),
      GoRoute(
        path: '/setting',
        builder: (context, state) => SettingScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/favorite',
        builder: (context, state) => FavoriteScreen(),
      ),
      GoRoute(
        path: '/postad',
        builder: (context, state) => PostAdScreen(),
      ),
      GoRoute(
        path: '/manage',
        builder: (context, state) => ManageScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => ProfileScreen(),
      ),
    ],
  );
}