// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `User Name`
  String get userName {
    return Intl.message('User Name', name: 'userName', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `508236561`
  String get phoneNumberHint {
    return Intl.message(
      '508236561',
      name: 'phoneNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Referral Code`
  String get referralCode {
    return Intl.message(
      'Referral Code',
      name: 'referralCode',
      desc: '',
      args: [],
    );
  }

  /// `I agree terms & conditions`
  String get agreeTerms {
    return Intl.message(
      'I agree terms & conditions',
      name: 'agreeTerms',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Or`
  String get or {
    return Intl.message('Or', name: 'or', desc: '', args: []);
  }

  /// `Guest Login`
  String get guestLogin {
    return Intl.message('Guest Login', name: 'guestLogin', desc: '', args: []);
  }

  /// `Email Sign Up`
  String get emailSignUp {
    return Intl.message(
      'Email Sign Up',
      name: 'emailSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get login {
    return Intl.message('Log In', name: 'login', desc: '', args: []);
  }

  /// `Already Have An Account?`
  String get haveAccount {
    return Intl.message(
      'Already Have An Account?',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email Login`
  String get emailLogin {
    return Intl.message('Email Login', name: 'emailLogin', desc: '', args: []);
  }

  /// `Don't Have An Account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t Have An Account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `phone sign Up`
  String get phonesignup {
    return Intl.message(
      'phone sign Up',
      name: 'phonesignup',
      desc: '',
      args: [],
    );
  }

  /// `Engilsh`
  String get engilsh {
    return Intl.message('Engilsh', name: 'engilsh', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Phone Login`
  String get phoneLogin {
    return Intl.message('Phone Login', name: 'phoneLogin', desc: '', args: []);
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message('My Profile', name: 'myProfile', desc: '', args: []);
  }

  /// `Create Agent Code`
  String get createAgentCode {
    return Intl.message(
      'Create Agent Code',
      name: 'createAgentCode',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `Terms & Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Support Center`
  String get supportCenter {
    return Intl.message(
      'Support Center',
      name: 'supportCenter',
      desc: '',
      args: [],
    );
  }

  /// `Privacy & Security`
  String get privacySecurity {
    return Intl.message(
      'Privacy & Security',
      name: 'privacySecurity',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `WhatsApp`
  String get whatsApp {
    return Intl.message('WhatsApp', name: 'whatsApp', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Advertiser Name`
  String get advertiserName {
    return Intl.message(
      'Advertiser Name',
      name: 'advertiserName',
      desc: '',
      args: [],
    );
  }

  /// `Advertiser Type`
  String get advertiserType {
    return Intl.message(
      'Advertiser Type',
      name: 'advertiserType',
      desc: '',
      args: [],
    );
  }

  /// `Advertiser Logo`
  String get advertiserLogo {
    return Intl.message(
      'Advertiser Logo',
      name: 'advertiserLogo',
      desc: '',
      args: [],
    );
  }

  /// `Upload Your Logo`
  String get uploadYourLogo {
    return Intl.message(
      'Upload Your Logo',
      name: 'uploadYourLogo',
      desc: '',
      args: [],
    );
  }

  /// `Advertiser Location`
  String get advertiserLocation {
    return Intl.message(
      'Advertiser Location',
      name: 'advertiserLocation',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Locate Me`
  String get locateMe {
    return Intl.message('Locate Me', name: 'locateMe', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `optional`
  String get optional {
    return Intl.message('optional', name: 'optional', desc: '', args: []);
  }

  /// `Premium`
  String get premium {
    return Intl.message('Premium', name: 'premium', desc: '', args: []);
  }

  /// `Price: {price}`
  String price(Object price) {
    return Intl.message(
      'Price: $price',
      name: 'price',
      desc: '',
      args: [price],
    );
  }

  /// `Location: {location}`
  String location(Object location) {
    return Intl.message(
      'Location: $location',
      name: 'location',
      desc: '',
      args: [location],
    );
  }

  /// `Al Manara Motors`
  String get placeName {
    return Intl.message(
      'Al Manara Motors',
      name: 'placeName',
      desc: '',
      args: [],
    );
  }

  /// `Date: {date}`
  String date(Object date) {
    return Intl.message('Date: $date', name: 'date', desc: '', args: [date]);
  }

  /// `{price}`
  String priceOnly(Object price) {
    return Intl.message('$price', name: 'priceOnly', desc: '', args: [price]);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Forgot Your Password?`
  String get forgetyourpass {
    return Intl.message(
      'Forgot Your Password?',
      name: 'forgetyourpass',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your phone`
  String get enterphone {
    return Intl.message(
      'Enter Your phone',
      name: 'enterphone',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendcode {
    return Intl.message('Send Code', name: 'sendcode', desc: '', args: []);
  }

  /// `Enter Your Email`
  String get enteremail {
    return Intl.message(
      'Enter Your Email',
      name: 'enteremail',
      desc: '',
      args: [],
    );
  }

  /// `Verify Your Number`
  String get verifnum {
    return Intl.message(
      'Verify Your Number',
      name: 'verifnum',
      desc: '',
      args: [],
    );
  }

  /// `We've sent an SMS with an activation code to your phone`
  String get phoneverify {
    return Intl.message(
      'We\'ve sent an SMS with an activation code to your phone',
      name: 'phoneverify',
      desc: '',
      args: [],
    );
  }

  /// `We've sent an Email with an activation code to your Email yourname@example.Com `
  String get emilverify {
    return Intl.message(
      'We\'ve sent an Email with an activation code to your Email yourname@example.Com ',
      name: 'emilverify',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Reset Password`
  String get resetpass {
    return Intl.message(
      'Reset Password',
      name: 'resetpass',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newpass {
    return Intl.message('New password', name: 'newpass', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmpass {
    return Intl.message(
      'Confirm Password',
      name: 'confirmpass',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `Car Sales`
  String get carsales {
    return Intl.message('Car Sales', name: 'carsales', desc: '', args: []);
  }

  /// `Real Estate`
  String get realestate {
    return Intl.message('Real Estate', name: 'realestate', desc: '', args: []);
  }

  /// `Electronics & Home \n Appliances`
  String get electronics {
    return Intl.message(
      'Electronics & Home \n Appliances',
      name: 'electronics',
      desc: '',
      args: [],
    );
  }

  /// `Jobs`
  String get jobs {
    return Intl.message('Jobs', name: 'jobs', desc: '', args: []);
  }

  /// `Car Rent`
  String get carrent {
    return Intl.message('Car Rent', name: 'carrent', desc: '', args: []);
  }

  /// `Car Services`
  String get carservices {
    return Intl.message(
      'Car Services',
      name: 'carservices',
      desc: '',
      args: [],
    );
  }

  /// `Restaurants`
  String get restaurants {
    return Intl.message('Restaurants', name: 'restaurants', desc: '', args: []);
  }

  /// `Other Services`
  String get otherservices {
    return Intl.message(
      'Other Services',
      name: 'otherservices',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Settings`
  String get srtting {
    return Intl.message('Settings', name: 'srtting', desc: '', args: []);
  }

  /// `Manage`
  String get manage {
    return Intl.message('Manage', name: 'manage', desc: '', args: []);
  }

  /// `Post Ads`
  String get post {
    return Intl.message('Post Ads', name: 'post', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
