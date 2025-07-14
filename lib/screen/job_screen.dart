import 'package:advertising_app/data/electronic_dummy_data.dart';
import 'package:advertising_app/data/job_data_dummy.dart';
import 'package:advertising_app/widget/custom_bottom_nav.dart';
import 'package:advertising_app/widget/custom_category.dart';
import 'package:flutter/material.dart';
import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  int _selectedIndex = 3; // ✅ Real Estate مفعل تلقائيًا

  List<String> get categories => [
        S.of(context).carsales,
        S.of(context).realestate,
        S.of(context).electronics,
        S.of(context).jobs,
        S.of(context).carrent,
        S.of(context).carservices,
        S.of(context).restaurants,
        S.of(context).otherservices,
      ];

  Map<String, String> get categoryRoutes => {
        S.of(context).carsales: "/home",
        S.of(context).realestate: "/realEstate",
        S.of(context).electronics: "/electronics",
        S.of(context).jobs: "/jobs",
        S.of(context).carrent: "/car_rent",
        S.of(context).carservices: "/carServices",
        S.of(context).restaurants: "/restaurants",
        S.of(context).otherservices: "/otherServices",
      };

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
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
                          height: 35.h,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: S.of(context).smart_search,
                              hintStyle: TextStyle(
                                  color: const Color.fromRGBO(129, 126, 126, 1),
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
                          size: 35.sp,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                  child: CustomCategoryGrid(
                    categories: categories,
                    selectedIndex: _selectedIndex,
                    onTap: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
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
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20.sp),
                          SizedBox(width: 6.w),
                          Text(
                            S.of(context).discover_best_job,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: KTextColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      _buildDropdown(S.of(context).emirate),
                      SizedBox(height: 3.h),
                      _buildDropdown(S.of(context).category_type),
                      SizedBox(height: 4.h),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(1, 84, 126, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 43,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                S.of(context).search,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                        child: GestureDetector(
                          onTap: () => context.push('/jobofferbox'),
                          child: Container(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 8.w),
                            height: 68.h,
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
                                Expanded(
                                  child: Text(
                                    S.of(context).click_for_deals_job,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: KTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Icon(Icons.arrow_forward_ios,
                                    size: 22.sp, color: KTextColor),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          SizedBox(width: 4.w),
                          Icon(Icons.star, color: Colors.amber, size: 20.sp),
                          SizedBox(width: 4.w),
                          Text(
                            S.of(context).top_premium_dealers,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: KTextColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Column(
                        children: List.generate(3, (sectionIndex) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 8.h,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Al Madayen Company",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: KTextColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {},
                                      child: Text(
                                        S.of(context).see_all_ads,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          decoration: TextDecoration.underline,
                                          decorationColor: const Color.fromRGBO(
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
                                height: 175,
                                width: double.infinity,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: JobData.length,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  itemBuilder: (context, index) {
                                    final ad = JobData[index];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.only(
                                        end: index == JobData.length - 1
                                            ? 0
                                            : 4.w, // بس للي قبل الأخير
                                      ),
                                      child: Container(
                                        width: 145,
                                       // margin: EdgeInsets.only(right: 8.w),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.15),
                                              blurRadius: 5.r,
                                              offset: Offset(0, 2.h),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(4.r),
                                                  child: Image.asset(
                                                    ad.image,
                                                    height: 94.h,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 8,
                                                  right: 8,
                                                  child: Icon(
                                                      Icons.favorite_border,
                                                      color:
                                                          Colors.grey.shade300),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 6.w),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      ad.price,
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 11.5.sp,
                                                      ),
                                                    ),
                                                    Text(
                                                      ad.title,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 11.5.sp,
                                                        color: KTextColor,
                                                      ),
                                                    ),
                                                    Text(
                                                      ad.location,
                                                      style: TextStyle(
                                                        fontSize: 11.5.sp,
                                                        color:
                                                            const Color.fromRGBO(
                                                                165, 164, 162, 1),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
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
      ),
    );
  }

  Widget _buildDropdown(String hint) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        height: 35.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color.fromRGBO(8, 194, 201, 1)),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(border: InputBorder.none),
          hint: Center(
            child: Text(
              hint,
              style: TextStyle(fontSize: 12.sp),
            ),
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
