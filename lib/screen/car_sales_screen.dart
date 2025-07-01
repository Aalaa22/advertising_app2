import 'package:advertising_app/constants.dart';
import 'package:advertising_app/data/dummy_data.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/model/ad_priority.dart';
import 'package:advertising_app/screen/car_details_screen.dart';
import 'package:advertising_app/widget/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CarSalesScreen extends StatefulWidget {
  const CarSalesScreen({super.key});

  @override
  State<CarSalesScreen> createState() => _CarSalesScreenState();
}

class _CarSalesScreenState extends State<CarSalesScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    final locale = Localizations.localeOf(context).languageCode;

    final sortedCars = [...dummyCarSales]
      ..sort((a, b) => a.priority.index.compareTo(b.priority.index));

    return Directionality(
      textDirection: locale == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        extendBodyBehindAppBar: true, // يخلي الخلفية ورا الستاتس بار

        backgroundColor: Colors.white,
        body: SafeArea(
         
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                // زر الرجوع
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

                SizedBox(height: 7.h),

                // العنوان
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

                SizedBox(height: 16.h),

                // First Row: Filter Icon + Chips
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

                SizedBox(height: 15.h),

                // Second Row
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      bool isSmallScreen =
                          MediaQuery.of(context).size.width <= 360;

                      if (isSmallScreen) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 45.h,
                              padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 12.w),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFF08C2C9)),
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
                                        fontSize: 11.5.sp,
                                      ),
                                    ),
                                  ),
                                  // SizedBox(width: 2.w),
                                  SizedBox(
                                    width: 35.w,
                                    height: 20.h,
                                    child: Switch(
                                      value: true,
                                      activeColor: Colors.white,
                                      activeTrackColor: const Color(0xFF08C2C9),
                                      inactiveThumbColor: Colors.grey,
                                      inactiveTrackColor: Colors.grey.shade300,
                                      onChanged: (val) {},
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text(
                                '${S.of(context).ad} 1000',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: KTextColor,
                                  fontWeight: FontWeight.w400,
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
                            SizedBox(width: 15.w),
                            Expanded(
                              child: Container(
                                height: 45.h,
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 12.w),
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
                                    SizedBox(width: 10.w),
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
                                    SizedBox(width: 8.w),
                                    SizedBox(
                                      width: 35.w,
                                      height: 20.h,
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

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: sortedCars.length,
                  itemBuilder: (context, index) {
                    final item = sortedCars[index];
                    return GestureDetector(
                      onTap: () {
                        context.push('/car-details', extra: item);
                      },
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: FavoriteCard(
                          item: item,
                          showDelete: false,
                          onDelete: () {
                            setState(() {
                              dummyCarSales.remove(item);
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildFilterChip(String label) {
  return Container(
    height: 40.h,
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
              fontSize: 10.5.sp, // Smaller font to fit 4 chips
              color: KTextColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(width: 2.w),
        Icon(
          Icons.keyboard_arrow_down,
          color: KTextColor,
          size: 14.sp, // Smaller icon
        ),
      ],
    ),
  );
}
