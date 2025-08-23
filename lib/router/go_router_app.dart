import 'dart:ui';
import 'package:advertising_app/data/model/car_rent_model.dart';
import 'package:advertising_app/data/model/car_sale_model.dart';
import 'package:advertising_app/data/model/car_service_model.dart';
import 'package:advertising_app/data/model/electronic_model.dart';
import 'package:advertising_app/data/model/job_model.dart';
import 'package:advertising_app/data/model/other_service_model.dart';
import 'package:advertising_app/data/model/real_estate_model.dart';
import 'package:advertising_app/data/model/restaurant_model.dart';
import 'package:advertising_app/presentation/screen/all_add_car_rent.dart';
import 'package:advertising_app/presentation/screen/all_add_car_sales.dart';
import 'package:advertising_app/presentation/screen/all_add_car_service.dart';
import 'package:advertising_app/presentation/screen/all_add_electronic.dart';
import 'package:advertising_app/presentation/screen/all_add_job.dart';
import 'package:advertising_app/presentation/screen/all_add_other_service.dart';
import 'package:advertising_app/presentation/screen/all_add_real_estate.dart';
import 'package:advertising_app/presentation/screen/all_add_resturant.dart';
import 'package:advertising_app/presentation/screen/car_rent_ads_screen.dart';
import 'package:advertising_app/presentation/screen/car_rent_save_ads_screen.dart';
import 'package:advertising_app/presentation/screen/car_sales_save_ads_screen.dart';
import 'package:advertising_app/presentation/screen/car_services_ad_screen';
import 'package:advertising_app/presentation/screen/car_servise_save_ads.dart';
import 'package:advertising_app/presentation/screen/electronics_ad_screen.dart';
import 'package:advertising_app/presentation/screen/electronics_save_ad_screen.dart';
import 'package:advertising_app/presentation/screen/job_save_ads_screen.dart';
import 'package:advertising_app/presentation/screen/jod_ads_screen.dart';
import 'package:advertising_app/presentation/screen/other_service_ads_screen.dart';
import 'package:advertising_app/presentation/screen/other_service_save_ads_screen.dart';
import 'package:advertising_app/presentation/screen/payment_screen.dart';
import 'package:advertising_app/presentation/screen/place_an_ad.dart';
import 'package:advertising_app/presentation/screen/real_estate_ads_screen.dart';
import 'package:advertising_app/presentation/screen/real_estate_save_ads_screen.dart';
import 'package:advertising_app/presentation/screen/resturant_ads_screen.dart';
import 'package:advertising_app/presentation/screen/resturant_save_ads_screen.dart';
import 'package:advertising_app/router/local_notifier.dart';
import 'package:advertising_app/presentation/screen/ads_category.dart';
import 'package:advertising_app/presentation/screen/car_details_screen.dart';
import 'package:advertising_app/presentation/screen/car_rent_details_screen.dart';
import 'package:advertising_app/presentation/screen/car_rent_offer_box.dart';
import 'package:advertising_app/presentation/screen/car_rent_screen.dart';
import 'package:advertising_app/presentation/screen/car_rent_search_screen.dart';
import 'package:advertising_app/presentation/screen/car_sales_ads_screen.dart';
import 'package:advertising_app/presentation/screen/car_sales_search_screen.dart';
import 'package:advertising_app/presentation/screen/car_service.dart';
import 'package:advertising_app/presentation/screen/car_service_details.dart';
import 'package:advertising_app/presentation/screen/car_service_offer_box.dart';
import 'package:advertising_app/presentation/screen/car_service_search_screen.dart';
import 'package:advertising_app/presentation/screen/edit_profile.dart';
import 'package:advertising_app/presentation/screen/electronic_details_screen.dart';
import 'package:advertising_app/presentation/screen/electronic_offer_box.dart';
import 'package:advertising_app/presentation/screen/electronic_screen.dart';
import 'package:advertising_app/presentation/screen/electronic_search_screen.dart';
import 'package:advertising_app/presentation/screen/email_code.dart';
import 'package:advertising_app/presentation/screen/email_login_screen.dart';
import 'package:advertising_app/presentation/screen/email_signup.dart';
import 'package:advertising_app/presentation/screen/favorite_screen.dart';
import 'package:advertising_app/presentation/screen/forgot_pass_email.dart';
import 'package:advertising_app/presentation/screen/forgot_pass_phone.dart';
import 'package:advertising_app/presentation/screen/car_sales_screen.dart';
import 'package:advertising_app/presentation/screen/job_details_screen.dart';
import 'package:advertising_app/presentation/screen/job_offer_box.dart';
import 'package:advertising_app/presentation/screen/job_screen.dart';
import 'package:advertising_app/presentation/screen/job_search_screen.dart';
import 'package:advertising_app/presentation/screen/login_screen.dart';
import 'package:advertising_app/presentation/screen/manage_screen.dart';
import 'package:advertising_app/presentation/screen/other_service_search_screen.dart';
import 'package:advertising_app/presentation/screen/other_services_details_screen.dart';
import 'package:advertising_app/presentation/screen/real_estate_details_screen.dart';
import 'package:advertising_app/presentation/screen/real_estate_offer_box.dart';
import 'package:advertising_app/presentation/screen/car_sales_offers_box_screen.dart';
import 'package:advertising_app/presentation/screen/other_service.dart';
import 'package:advertising_app/presentation/screen/other_service_offer_box.dart';
import 'package:advertising_app/presentation/screen/phone_code.dart';
import 'package:advertising_app/presentation/screen/post_ad_screen.dart';
import 'package:advertising_app/presentation/screen/profile_screen.dart';
import 'package:advertising_app/presentation/screen/real_estate_screen.dart';
import 'package:advertising_app/presentation/screen/real_estate_search_screen.dart';
import 'package:advertising_app/presentation/screen/reset_pass.dart';
import 'package:advertising_app/presentation/screen/restaurant_details_screen.dart';
import 'package:advertising_app/presentation/screen/restaurant_offer_box.dart';
import 'package:advertising_app/presentation/screen/restaurant_search_screen.dart';
import 'package:advertising_app/presentation/screen/restaurants_screen.dart';
import 'package:advertising_app/presentation/screen/setting_screen.dart';
import 'package:advertising_app/presentation/screen/sinup_screen.dart';
import 'package:advertising_app/presentation/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter({
  required LocaleChangeNotifier notifier,
}) {
  return GoRouter(
    refreshListenable: notifier,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LoginScreen(notifier: notifier),
      ),
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => SplashGridScreen(),
      // ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignUpScreen(notifier: notifier),
      ),
      // GoRoute(
      //   path: '/login',
      //   builder: (context, state) => LoginScreen(notifier: notifier),
      // ),
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
        builder: (context, state) => ManageScreen(  
onLanguageChange: (Locale ) { },),
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
        path: '/real-details',
        builder: (context, state) {
          final RealEstate = state.extra as RealEstateModel;
          return RealEstateDetailsScreen(real_estate: RealEstate );
        },
      ),

      GoRoute(
        path: '/electronic-details',
        builder: (context, state) {
          final electronic = state.extra as ElectronicModel;
          return ElectronicDetailsScreen(electronic: electronic );
        },
      ),

      GoRoute(
        path: '/job-details',
        builder: (context, state) {
          final job = state.extra as JobModel;
          return JobDetailsScreen (job: job );
        },
      ),


      GoRoute(
        path: '/car-rent-details',
        builder: (context, state) {
          final car_rent = state.extra as CarRentModel;
          return CarRentDetailsScreen (car_rent: car_rent );
        },
      ),

       GoRoute(
        path: '/car-service-details',
        builder: (context, state) {
          final car_service = state.extra as CarServiceModel;
          return CarServiceDetails (car_service: car_service );
        },
      ),

       GoRoute(
        path: '/restaurant-details',
        builder: (context, state) {
          final restaurant = state.extra as RestaurantModel;
          return RestaurantDetailsScreen (restaurant: restaurant );
        },
      ),

      GoRoute(
        path: '/other_service-details',
        builder: (context, state) {
          final other_service = state.extra as OtherServiceModel;
          return OtherServicesDetailsScreen (other_service: other_service );
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
        builder: (context, state) => CarRentSearchScreen()
      ),
      GoRoute(
        path: '/car_service_search',
        builder: (context, state) => CarServiceSearchScreen(
          ),
      ),
     
       GoRoute(
        path: '/restaurant_search',
        builder: (context, state) => RestaurantSearchScreen(
          ),
      ),
      GoRoute(
        path: '/other_service_search',
        builder: (context, state) => OtherServiceSearchScreen(
          ),
      ),
       GoRoute(
        path: '/job_search',
        builder: (context, state) => JobSearchScreen(
          ),
      ),

      GoRoute(
        path: '/ads_category',
        builder: (context, state) => AdsCategoryScreen(
          ),
      ),
      GoRoute(
        path: '/car_sales_ads',
        builder: (context, state) => CarSalesAdScreen(onLanguageChange: (Locale ) {  },),
      ),
       GoRoute(
        path: '/car_sales_save_ads',
        builder: (context, state) => CarSalesSaveAdScreen(onLanguageChange: (Locale ) {  },),
      ),
      GoRoute(
        path: '/car_services_ads',
        builder: (context, state) => CarServicesAdScreen(onLanguageChange: (Locale ) { },),
      ),
      GoRoute(
        path: '/car_services_save_ads',
        builder: (context, state) => CarServicesSaveAdScreen(onLanguageChange: (Locale ) {  },),
      ),
      GoRoute(
        path: '/real_estate_ads',
        builder: (context, state) => RealEstateAdScreen(onLanguageChange: (Locale ) { },),
      ),
       GoRoute(
        path: '/real_estate_save_ads',
        builder: (context, state) => RealEstateSaveAdScreen(onLanguageChange: (Locale ) { },),
      ),
       GoRoute(
        path: '/electronics_ads',
        builder: (context, state) => ElectronicsAdScreen(onLanguageChange: (Locale ) { },),
      ),
       GoRoute(
        path: '/electronics_save_ads',
        builder: (context, state) => ElectronicsSaveAdScreen(onLanguageChange: (Locale ) { },),
      ),
      GoRoute(
        path: '/car_rent_ads',
        builder: (context, state) => CarsRentAdScreen(onLanguageChange: (Locale ) { },),
      ),
       GoRoute(
        path: '/car_rent_save_ads',
        builder: (context, state) => CarsRentSaveAdScreen(onLanguageChange: (Locale ) { },),
      ),
       GoRoute(
        path: '/resturant_ads',
        builder: (context, state) => RestaurantsAdScreen(onLanguageChange: (Locale ) { },),
      ),
       GoRoute(
        path: '/resturant_save_ads',
        builder: (context, state) => RestaurantsSaveAdScreen(onLanguageChange: (Locale ) { },),
      ),
       GoRoute(
        path: '/other_servics_ads',
        builder: (context, state) => OtherServicesAdScreen(onLanguageChange: (Locale ) { },),
      ),
       GoRoute(
        path: '/other_service_save_ads',
        builder: (context, state) => OtherServicesSaveAdScreen(onLanguageChange: (Locale ) { },),
      ),

       GoRoute(
        path: '/job_ads',
        builder: (context, state) => JobsAdScreen(onLanguageChange: (Locale ) { },),
      ),
       GoRoute(
        path: '/job_save_ads',
        builder: (context, state) =>   JobsSaveAdScreen(onLanguageChange: (Locale ) { },),
      ),

      GoRoute(
        path: '/payment',
        builder: (context, state) =>   PaymentScreen(onLanguageChange: (Locale ) { },),
      ),
      GoRoute(
        path: '/placeAnAd',
        builder: (context, state) =>   PlaceAnAd(),
      ),
       GoRoute(
        path: '/all_ad_car_sales',
        builder: (context, state) =>   AllAdCarSales(),
      ),
       GoRoute(
        path: '/all_ad_car_rent',
        builder: (context, state) =>  AllAdCarRent(),
      ),
       GoRoute(
        path: '/AllAdsRealEstate',
        builder: (context, state) =>  AllAdsRealEstate(),
      ),
       GoRoute(
        path: '/AllAddsElectronic',
        builder: (context, state) =>   AllAddsElectronic(),
      ),
       GoRoute(
        path: '/all_add_job',
        builder: (context, state) =>   AllAddsJob(),
      ),
       GoRoute(
        path: '/AllAddsCarService',
        builder: (context, state) =>   AllAddsCarService(),
      ),
       GoRoute(
        path: '/AllAddsRestaurant',
        builder: (context, state) =>   AllAddsRestaurant(),
      ),
       GoRoute(
        path: '/all_add_other_service',
        builder: (context, state) =>   AllAddsOtherService(),
      ),
      
    ],
  );

  
}