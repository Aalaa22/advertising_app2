import 'package:advertising_app/constants.dart';
import 'package:advertising_app/data/restaurant_data_dummy.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/model/ad_priority.dart';
import 'package:advertising_app/model/favorite_item_interface_model.dart';
import 'package:advertising_app/widget/custom_search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RestaurantSearchScreen extends StatefulWidget {
  const RestaurantSearchScreen({super.key});

  @override
  State<RestaurantSearchScreen> createState() => _RestaurantSearchScreenState();
}

class _RestaurantSearchScreenState extends State<RestaurantSearchScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showOverlayBar = false;
  double _lastOffset = 0;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final currentOffset = _scrollController.offset;
    final scrollDelta = currentOffset - _lastOffset;

    if (scrollDelta < -5 && !_showOverlayBar && currentOffset > 150) {
      _showOverlayBar = true;
      _showFloatingOverlayBar();
    } else if ((scrollDelta > 5 || currentOffset <= 150) && _showOverlayBar) {
      _showOverlayBar = false;
      _removeFloatingOverlayBar();
    }

    _lastOffset = currentOffset;
  }

  void _showFloatingOverlayBar() {
    _removeFloatingOverlayBar();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top,
        left: 0,
        right: 0,
        child: Material(
          elevation: 6,
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _removeFloatingOverlayBar();
                    context.pop();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios,
                          color: KTextColor, size: 17.sp),
                      Transform.translate(
                        offset: Offset(-3.w, 0),
                        child: Text(
                          S.of(context).back,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: KTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                    SizedBox(height: 5.h),  
                
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/filter.svg', width: 25.w, height: 25.h),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _buildFilterChip(S.of(context).district)),
                          SizedBox(width: 4.w),
                          Expanded(child: _buildFilterChip(S.of(context).price)),
                          SizedBox(width: 4.w),
                          Expanded(child: _buildFilterChip(S.of(context).category)),
                        ],
                      ),
                    ),
                  ],
                ),
                 SizedBox(height: 8.h),
                LayoutBuilder(
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
                                        activeTrackColor: const Color.fromRGBO(
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
                                  SizedBox(width: 15.w),
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
                ),],
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeFloatingOverlayBar() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    final locale = Localizations.localeOf(context).languageCode;

    final List<FavoriteItemInterface> firstPremiumCars = [];
    final List<FavoriteItemInterface> premiumCars = [];
    final List<FavoriteItemInterface> featuredCars = [];
    final List<FavoriteItemInterface> freeCars = [];

    for (var car in RestaurantDataDammy) {
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    GestureDetector(
                  onTap: () {
                    _removeFloatingOverlayBar();
                    context.pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios,
                            color: KTextColor, size: 17.sp),
                        Transform.translate(
                          offset: Offset(-3.w, 0),
                          child: Text(
                            S.of(context).back,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: KTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                    SizedBox(height: 3.h),
                    Center(
                      child: Text(
                        S.of(context).restaurants,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24.sp, color: KTextColor),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/filter.svg', width: 25.w, height: 25.h),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(child: _buildFilterChip(S.of(context).district)),
                                SizedBox(width: 7.w),
                                Expanded(child: _buildFilterChip(S.of(context).price)),
                                SizedBox(width: 7.w),
                                Expanded(child: _buildFilterChip(S.of(context).category)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                     SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w),
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
                                    SizedBox(width: 8.w),
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
                            SizedBox(width: 28.w),
                            Expanded(
                              child: Container(
                                height: 37.h,
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
                                    SizedBox(width: 15.w),
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
                    _buildAdList(S.of(context).priority_first_premium, firstPremiumCars),
                    _buildAdList(S.of(context).priority_premium, premiumCars),
                    _buildAdList(S.of(context).priority_featured, featuredCars),
                    _buildAdList(S.of(context).priority_free, freeCars),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
              style: TextStyle(fontSize: 10.5.sp, color: KTextColor, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(width: 2.w),
          Icon(Icons.keyboard_arrow_down, color: KTextColor, size: 14.sp),
        ],
      ),
    );
  }

  Widget _buildAdList(String title, List<FavoriteItemInterface> items) {
    if (items.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        ...items.map((item) => _buildCard(item)).toList(),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: KTextColor),
      ),
    );
  }

  Widget _buildCard(FavoriteItemInterface item) {
    return GestureDetector(
      onTap: () {},
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SearchCard(
          showLine1: false,
          item: item,
          showDelete: false,
          onAddToFavorite: () {},
          onDelete: () {
            setState(() {
              RestaurantDataDammy.remove(item);
            });
          },
        ),
      ),
    );
  }
}
