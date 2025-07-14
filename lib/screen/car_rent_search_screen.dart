import 'package:advertising_app/constants.dart';
import 'package:advertising_app/data/car_rent_dummy_data.dart';
import 'package:advertising_app/data/electronic_dummy_data.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/model/ad_priority.dart';
import 'package:advertising_app/model/car_rent_model.dart';
import 'package:advertising_app/widget/custom_search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:advertising_app/model/favorite_item_interface_model.dart';



class CarRentSearchScreen extends StatefulWidget {
  const CarRentSearchScreen({super.key});

  @override
  State<CarRentSearchScreen> createState() => _CarRentSearchScreenState();
}

class _CarRentSearchScreenState extends State<CarRentSearchScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    final locale = Localizations.localeOf(context).languageCode;

    // ✅ تقسيم السيارات حسب الأولوية
    final List<CarRentModel> firstPremiumCars = [];
    final List<CarRentModel> premiumCars = [];
    final List<CarRentModel> featuredCars = [];
    final List<CarRentModel> freeCars = [];

    for (var car in CarRentDummyData) {
      switch (car.priority) {
        case AdPriority.PremiumStar:
          firstPremiumCars.add(car);
          break;
        case AdPriority.premium:
          premiumCars.add(car);
          break;
        case AdPriority.featured:
          featuredCars.add(car);
          break;
        case AdPriority.free:
          freeCars.add(car);
          break;
      }
    }

    return Directionality(
      textDirection: locale == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Row(
                    children: [
                      const SizedBox(width: 18),
                      const Icon(Icons.arrow_back_ios, color: KTextColor),
                      Text(
                        S.of(context).back,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: KTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                Center(
                  child: Text(
                    S.of(context).carsales,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24.sp,
                      color: KTextColor,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                // فلاتر
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/filter.svg',
                        width: 25.w,
                        height: 25.h,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                child: _buildFilterChip(S.of(context).trim)),
                            SizedBox(width: 7.w),
                            Expanded(
                                child: _buildFilterChip(S.of(context).year)),
                            SizedBox(width: 7.w),
                            Expanded(child: _buildFilterChip(S.of(context).km)),
                            SizedBox(width: 7.w),
                            Expanded(
                                child: _buildFilterChip(S.of(context).price)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 7.h),

                // عدد الإعلانات وسويتش
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      bool isSmallScreen =
                          MediaQuery.of(context).size.width <= 370;

                      if (isSmallScreen) {
                        return Row(
                          children: [
                            Text(
                              '${S.of(context).ad} 1000',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: KTextColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 35.w),
                            Expanded(
                              child: Container(
                                height: 37.h,
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 8.w),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF08C2C9)),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/locationicon.svg',
                                      width: 18.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Text(
                                        S.of(context).sort,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: KTextColor,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 1.w),
                                    SizedBox(
                                      width: 35.w,
                                      child: Transform.scale(
                                        scale: 0.8,
                                        child: Switch(
                                          value: true,
                                          onChanged: (val) {
                                            // setState(() => _isInvisible = val);
                                            // _showToast(
                                            //   context,
                                            //   val ?  'Invisible Mode Disabled':'Invisible Mode Enabled',
                                            // );
                                          },
                                          activeColor: Colors.white,
                                          activeTrackColor:
                                              const Color.fromRGBO(
                                                  8, 194, 201, 1),
                                          inactiveThumbColor: Colors.white,
                                          inactiveTrackColor: Colors.grey[300],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Row(
                          children: [
                            Text(
                              '${S.of(context).ad} 1000',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: KTextColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 30.w),
                            Expanded(
                              child: Container(
                                height: 37.h,
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 10.w),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF08C2C9)),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/locationicon.svg',
                                      width: 18.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: 20.w),
                                    Expanded(
                                      child: Text(
                                        S.of(context).sort,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: KTextColor,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 32.w,
                                      child: Transform.scale(
                                        scale: .9,
                                        child: Switch(
                                          value: true,
                                          activeColor: Colors.white,
                                          activeTrackColor:
                                              const Color(0xFF08C2C9),
                                          inactiveThumbColor: Colors.grey,
                                          inactiveTrackColor:
                                              Colors.grey.shade300,
                                          onChanged: (val) {},
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),

                // SizedBox(height: 2.h),

                // ✅ عرض المجموعات مع العناوين
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (firstPremiumCars.isNotEmpty) ...[
                      _buildSectionTitle(S.of(context).priority_first_premium),
                      ...firstPremiumCars
                          .map((item) => _buildCard(item))
                          .toList(),
                    ],
                    if (premiumCars.isNotEmpty) ...[
                      _buildSectionTitle(S.of(context).priority_premium),
                      ...premiumCars.map((item) => _buildCard(item)).toList(),
                    ],
                    if (featuredCars.isNotEmpty) ...[
                      _buildSectionTitle(S.of(context).priority_featured),
                      ...featuredCars.map((item) => _buildCard(item)).toList(),
                    ],
                    if (freeCars.isNotEmpty) ...[
                      _buildSectionTitle(S.of(context).priority_free),
                      ...freeCars.map((item) => _buildCard(item)).toList(),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // عنوان القسم
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: KTextColor,
        ),
      ),
    );
  }

  // كارت إعلان
  Widget _buildCard(CarRentModel item) {
    return GestureDetector(
      onTap: () {
       // context.push('/car-details', extra: item);
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SearchCard(
          showLine1: true,
  customLine1Span: TextSpan(
    children: [
      WidgetSpan(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLabelWithValue("Day Rent", item.day_rent),
            const SizedBox(width: 16),
            _buildLabelWithValue("Month Rent", item.month_rent),
          ],
        ),
      ),
    ],
  ),
          item: item,
          showDelete: false,
          onAddToFavorite: () {},
          onDelete: () {
            setState(() {
              CarRentDummyData.remove(item);
            });
          },
        ),
      ),
    );
  }

  // Chip للفلاتر
  Widget _buildFilterChip(String label) {
    return Container(
      height: 33.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF08C2C9)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.5.sp,
                color: KTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: 2.w),
          Icon(
            Icons.keyboard_arrow_down,
            color: KTextColor,
            size: 14.sp,
          ),
        ],
      ),
    );
  }

  void _handleAddToFavorite(CarRentModel item) {}
}


Widget _buildLabelWithValue(String label, String value) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        "$label ",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(0, 30, 90,1 ),
          fontSize: 14,
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(0, 30, 90, 1),
            fontSize: 14,
          ),
        ),
      ),
    ],
  );
}
