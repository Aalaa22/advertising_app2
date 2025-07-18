import 'package:advertising_app/constants.dart';
import 'package:advertising_app/data/car_rent_dummy_data.dart';
import 'package:advertising_app/data/electronic_dummy_data.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CarRentOfferBox extends StatefulWidget {
  const CarRentOfferBox({super.key});

  @override
  State<CarRentOfferBox> createState() => _CarRentOfferBoxState();
}

class _CarRentOfferBoxState extends State<CarRentOfferBox> {
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardSize = getCardSize(screenWidth);

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
                  // Header Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),

                      // Back Button
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

                      // Title
                      Center(
                        child: Text(
                          "Offers Box",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24.sp,
                            color: KTextColor,
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // Filter Row
                      Padding(
                        padding:
                            EdgeInsetsDirectional.symmetric(horizontal: 8.w),
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
                                      child:
                                          _buildFilterChip(S.of(context).year)),
                                  SizedBox(width: 7.w),
                                  Expanded(
                                      child:
                                          _buildFilterChip(S.of(context).km)),
                                  SizedBox(width: 7.w),
                                  Expanded(
                                      child: _buildFilterChip(
                                          S.of(context).price)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 6.h),

                      // Second Row
                      Padding(
                        padding:
                            EdgeInsetsDirectional.symmetric(horizontal: 8.w),
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
                                  SizedBox(width: 40.w),
                                  Expanded(
                                    child: Container(
                                      height: 37.h,
                                      padding: EdgeInsetsDirectional.symmetric(
                                          horizontal: 8.w),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFF08C2C9)),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
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
                                                inactiveThumbColor:
                                                    Colors.white,
                                                inactiveTrackColor:
                                                    Colors.grey[300],
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
                                  SizedBox(width: 35.w),
                                  Expanded(
                                    child: Container(
                                      height: 37.h,
                                      padding: EdgeInsetsDirectional.symmetric(
                                          horizontal: 12.w),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFF08C2C9)),
                                        borderRadius:
                                            BorderRadius.circular(8.r),
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
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
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
                      SizedBox(height: 5.h),
                    ],
                  ),

                  // Grid Section - Scrollable
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: CarRentDummyData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // crossAxisSpacing: 0,
                        mainAxisSpacing: 6,
                        childAspectRatio: .9,
                      ),
                      itemBuilder: (context, index) {
                        final car = CarRentDummyData[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Container(
                            width: cardSize.width.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(color: Colors.grey.shade300),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.15),
                                  blurRadius: 5.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4.r),
                                    child: Image.asset(
                                      car.image,
                                      height: (cardSize.height * 0.6).h,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Icon(Icons.favorite_border,
                                        color: Colors.grey.shade300),
                                  ),
                                ]),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          car.price,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        Text(
                                          car.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color: KTextColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        
                                        Text(
                                          car.contact,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color: KTextColor,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/Vector.svg',
                                              width: 10.5.w,
                                              height: 13.5.h,
                                            ),
                                            SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                car.location,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Color.fromRGBO(
                                                      0, 30, 91, .75),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

Size getCardSize(double screenWidth) {
  if (screenWidth <= 320) {
    return const Size(120, 140);
  } else if (screenWidth <= 375) {
    return const Size(135, 150);
  } else if (screenWidth <= 430) {
    return const Size(150, 160);
  } else {
    return const Size(165, 175);
  }
}

Widget _buildFilterChip(String label) {
  return Container(
    height: 32.h,
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color(0xFF08C2C9),
      ),
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
