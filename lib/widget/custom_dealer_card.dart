import 'package:advertising_app/constants.dart';
import 'package:advertising_app/model/top_dealer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DealerCarCard extends StatelessWidget {
  final DealerCarModel car;

  const DealerCarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardSize = getCardSize(screenWidth);

    return Container(
      width: cardSize.width.w,
      height: cardSize.height.h,
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
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: Image.asset(
              car.image,
              height: (cardSize.height * 0.6).h, // 60% من الطول
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  car.price,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  car.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: KTextColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Text(
                      "${car.year}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color.fromRGBO(165, 164, 162, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Text(
                      "${car.km} KM",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color.fromRGBO(165, 164, 162, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
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