import 'dart:ui';
import 'package:advertising_app/model/car_sale_model.dart';
import 'package:advertising_app/router/local_notifier.dart';
import 'package:advertising_app/screen/car_details_screen.dart';
import 'package:advertising_app/screen/car_rent_offer_box.dart';
import 'package:advertising_app/screen/car_rent_screen.dart';
import 'package:advertising_app/screen/car_rent_search_screen.dart';
import 'package:advertising_app/screen/car_sales_search_screen.dart';
import 'package:advertising_app/screen/car_service.dart';
import 'package:advertising_app/screen/car_service_offer_box.dart';
import 'package:advertising_app/screen/edit_profile.dart';
import 'package:advertising_app/screen/electronic_offer_box.dart';
import 'package:advertising_app/screen/electronic_screen.dart';
import 'package:advertising_app/screen/electronic_search_screen.dart';
import 'package:advertising_app/screen/email_code.dart';
import 'package:advertising_app/screen/email_login_screen.dart';
import 'package:advertising_app/screen/email_signup.dart';
import 'package:advertising_app/screen/favorite_screen.dart';
import 'package:advertising_app/screen/forgot_pass_email.dart';
import 'package:advertising_app/screen/forgot_pass_phone.dart';
import 'package:advertising_app/screen/car_sales_screen.dart';
import 'package:advertising_app/screen/job_offer_box.dart';
import 'package:advertising_app/screen/job_screen.dart';
import 'package:advertising_app/screen/login_screen.dart';
import 'package:advertising_app/screen/manage_screen.dart';
import 'package:advertising_app/screen/real_estate_offer_box.dart';
import 'package:advertising_app/screen/car_sales_offers_box_screen.dart';
import 'package:advertising_app/screen/other_service.dart';
import 'package:advertising_app/screen/other_service_offer_box.dart';
import 'package:advertising_app/screen/phone_code.dart';
import 'package:advertising_app/screen/post_ad_screen.dart';
import 'package:advertising_app/screen/profile_screen.dart';
import 'package:advertising_app/screen/real_estate_screen.dart';
import 'package:advertising_app/screen/real_estate_search_screen.dart';
import 'package:advertising_app/screen/reset_pass.dart';
import 'package:advertising_app/screen/restaurant_offer_box.dart';
import 'package:advertising_app/screen/restaurants_screen.dart';
import 'package:advertising_app/screen/setting_screen.dart';
import 'package:advertising_app/screen/sinup_screen.dart';
import 'package:advertising_app/screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter({
  required LocaleChangeNotifier notifier,
}) {
  return GoRouter(
    refreshListenable: notifier,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => SignUpScreen(notifier: notifier),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(notifier: notifier),
      ),
      GoRoute(
        path: '/emaillogin',
        builder: (context, state) => EmailLoginScreen(notifier: notifier),
      ),
      GoRoute(
        path: '/emailsignup',
        builder: (context, state) => EmailSignUpScreen(notifier: notifier),
      ),
      GoRoute(
        path: '/passphonelogin',
        builder: (context, state) => ForgotPassPhone(notifier: notifier),
      ),
      GoRoute(
        path: '/forgetpassemail',
        builder: (context, state) => ForgotPassEmail(notifier: notifier),
      ),
      GoRoute(
        path: '/phonecode',
        builder: (context, state) => VerifyPhoneCode(notifier: notifier),
      ),
      GoRoute(
        path: '/emailcode',
        builder: (context, state) => VerifyEmailCode(notifier: notifier),
      ),
      GoRoute(
        path: '/resetpass',
        builder: (context, state) => ResetPassword(notifier: notifier),
      ),
      GoRoute(
        path: '/setting',
        builder: (context, state) => SettingScreen(notifier: notifier),
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
      GoRoute(
        path: '/editprofile',
        builder: (context, state) => EditProfile(),
      ),
      GoRoute(
        path: '/cars-sales',
        builder: (context, state) => const CarSalesScreen(),
      ),
      GoRoute(
        path: '/car-details',
        builder: (context, state) {
          final car = state.extra as CarSalesModel;
          return CarDetailsScreen(car: car);
        },
      ),

       GoRoute(
        path: '/offer_box',
        builder: (context, state) => OffersBoxScreen(
          ),
      ),
        GoRoute(
        path: '/car_rent',
        builder: (context, state) => CarRentScreen(
          ),
      ),
       GoRoute(
        path: '/realEstate',
        builder: (context, state) => RealEstateScreen(
          ),
      ),

       GoRoute(
        path: '/electronics',
        builder: (context, state) => ElectronicScreen(
          ),
      ),

       GoRoute(
        path: '/jobs',
        builder: (context, state) => JobScreen(
          ),
      ),
       GoRoute(
        path: '/carServices',
        builder: (context, state) => CarService(
          ),
      ),
       GoRoute(
        path: '/restaurants',
        builder: (context, state) => RestaurantsScreen(
          ),
      ),
       GoRoute(
        path: '/otherServices',
        builder: (context, state) => OtherServiceScreen(
          ),
      ),
       GoRoute(
        path: '/realestateofeerbox',
        builder: (context, state) => RealEstateOfeerBOX(
          ),
      ),
      GoRoute(
        path: '/electronicofferbox',
        builder: (context, state) => ElectronicOfferBox(
          ),
      ),
      GoRoute(
        path: '/jobofferbox',
        builder: (context, state) => JobOfferBox(
          ),
      ),
      GoRoute(
        path: '/carrentofferbox',
        builder: (context, state) => CarRentOfferBox(
          ),
      ),
      GoRoute(
        path: '/carservicetofferbox',
        builder: (context, state) => CarServiceOfferBox(
          ),
      ),
      GoRoute(
        path: '/restaurant_offerbox',
        builder: (context, state) => RestaurantOfferBox(
          ),
      ),
      GoRoute(
        path: '/other_service_offer_box',
        builder: (context, state) => OtherServiceOfferBox(
          ),
      ),
      GoRoute(
        path: '/real_estate_search',
        builder: (context, state) => RealEstateSearchScreen(
          ),
      ),
       GoRoute(
        path: '/electronic_search',
        builder: (context, state) => ElectronicSearchScreen(
          ),
      ),
      GoRoute(
        path: '/car_rent_search',
        builder: (context, state) => CarRentSearchScreen(
          ),
      ),
    ],
  );
}