import 'package:advertising_app/constants.dart';
import 'package:advertising_app/data/top_dealer_dummy_data.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/model/favorite_item_interface_model.dart';
import 'package:advertising_app/widget/custom_bottom_nav.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_category.dart';
import 'package:advertising_app/widget/custom_dealer_card.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ✅ خليهم getters عشان يكون الـ context متاح
  List<String> get categories => [
        S.of(context).carsales,
        S.of(context).realestate,
        S.of(context).electronics,
        S.of(context).jobs,
        S.of(context).carrent,
        S.of(context).carservices,
        S.of(context).restaurants,
        S.of(context).otherservices
      ];

  Map<String, String> get categoryRoutes => {
        S.of(context).carsales: "/cars-sales",
        S.of(context).realestate: "/realEstate",
        S.of(context).electronics: "/electronics",
        S.of(context).jobs: "/jobs",
        S.of(context).carrent: "/carRent",
        S.of(context).carservices: "/carServices",
        S.of(context).restaurants: "/restaurants",
        S.of(context).otherservices: "/otherServices",
      };

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));


    return Directionality(
        textDirection: locale == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: CustomBottomNav(currentIndex: 0),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40.h,
                            // width: 310.w,
                            child: TextField(
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                hintText: S.of(context).smart_search,
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(129, 126, 126, 1),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: const Color.fromRGBO(8, 194, 201, 1),
                                  size: 25.sp,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(8, 194, 201, 1),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(8, 194, 201, 1),
                                    width: 1.5,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 0.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.notifications_none,
                            color: const Color.fromRGBO(8, 194, 201, 1),
                            size: 37.sp,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                    child: CustomCategoryGrid(
                      categories: categories,
                      onCategoryPressed: (selectedCategory) {
                        final route = categoryRoutes[selectedCategory];
                        if (route != null) {
                          context.push(route);
                        } else {
                          print('Route not found for $selectedCategory');
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20.sp),
                            SizedBox(width: 6.w),
                            Text(
                              S.of(context).discover_best_cars_deals,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                color: KTextColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        _buildDropdown(S.of(context).choose_make),
                        SizedBox(height: 7.h),
                        _buildDropdown(S.of(context).choose_model),
                        SizedBox(height: 10.h),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                          child: CustomButton(text: S.of(context).search),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                          child: Container(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 8.w),
                            height: 98.h,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Color(0xFFE4F8F6), Color(0xFFC9F8FE)],
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/cardolar.svg',
                                  height: 25.sp,
                                  width: 24.sp,
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Text(
                                    S
                                        .of(context)
                                        .click_for_amazing_daily_cars_deals,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: KTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Icon(Icons.arrow_forward_ios,
                                    size: 22.sp, color: KTextColor),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            SizedBox(width: 4.w),
                            Icon(Icons.star, color: Colors.amber, size: 20.sp),
                            SizedBox(width: 4.w),
                            Text(
                              S.of(context).top_premium_dealers,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                color: KTextColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(3, (sectionIndex) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 16.w,
                                    vertical: 8.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Al Manara Motors",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: KTextColor,
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {},
                                        child: Text(
                                          S.of(context).see_all_ads,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                const Color.fromRGBO(
                                                    8, 194, 201, 1),
                                            color: const Color.fromRGBO(
                                                8, 194, 201, 1),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 157.h,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: topPremiumDealerCars.length,
                                    padding: EdgeInsetsDirectional.symmetric(
                                        horizontal: 12.w),
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: 170.w,
                                        margin: EdgeInsetsDirectional.only(
                                          end: 10.w,
                                        ),
                                        child: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: DealerCarCard(
                                            car: topPremiumDealerCars[index],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildDropdown(String hint) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color.fromRGBO(8, 194, 201, 1)),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(border: InputBorder.none),
          hint: Text(
            hint,
            style: TextStyle(fontSize: 14.sp),
          ),
          style: TextStyle(
            color: const Color.fromRGBO(129, 126, 126, 1),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          items: const [],
          onChanged: (value) {},
        ),
      ),
    );
  }
}
