import 'package:advertising_app/constants.dart';
import 'package:advertising_app/data/car_sales_data_dummy.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/model/ad_priority.dart';
import 'package:advertising_app/widget/custom_search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:advertising_app/model/favorite_item_interface_model.dart';

class _CarSalesState {
  static double scrollPosition = 0;
  static bool shouldShowOverlay = false;
  static bool keepOverlayVisible = false;
}

class CarSalesScreen extends StatefulWidget {
  const CarSalesScreen({super.key});

  @override
  State<CarSalesScreen> createState() => _CarSalesScreenState();
}

class _CarSalesScreenState extends State<CarSalesScreen> 
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  
  final ScrollController _scrollController = ScrollController();
  bool _showOverlayBar = false;
  double _lastOffset = 0;
  OverlayEntry? _overlayEntry;
  bool _isScreenActive = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addObserver(this);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_CarSalesState.scrollPosition > 0 && _scrollController.hasClients) {
        _scrollController.jumpTo(_CarSalesState.scrollPosition);
      }
      if (_CarSalesState.shouldShowOverlay) {
        _showOverlayBar = true;
        _showFloatingOverlayBar();
      }
    });
  }

  void _handleScroll() {
    if (!_isScreenActive || !mounted) return;
    
    final currentOffset = _scrollController.offset;
    final scrollDelta = currentOffset - _lastOffset;
    
    _CarSalesState.scrollPosition = currentOffset;

    // Hide overlay when at top of the page
    if (currentOffset <= 100) {
      if (_showOverlayBar) {
        setState(() {
          _showOverlayBar = false;
        });
        _CarSalesState.shouldShowOverlay = false;
        _CarSalesState.keepOverlayVisible = false;
        _removeFloatingOverlayBar();
      }
      return;
    }

    if (_CarSalesState.keepOverlayVisible) {
      _CarSalesState.keepOverlayVisible = false;
      return;
    }

    if (scrollDelta < -5 && !_showOverlayBar) {
      setState(() {
        _showOverlayBar = true;
      });
      _CarSalesState.shouldShowOverlay = true;
      _showFloatingOverlayBar();
    } 
    else if (scrollDelta > 5 && _showOverlayBar) {
      setState(() {
        _showOverlayBar = false;
      });
      _CarSalesState.shouldShowOverlay = false;
      _removeFloatingOverlayBar();
    }

    _lastOffset = currentOffset;
  }

  void _showFloatingOverlayBar() {
    if (!_isScreenActive || !mounted || _overlayEntry != null) return;
    
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
                    _resetState();
                    context.pop();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios, color: KTextColor, size: 17.sp),
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
                    SvgPicture.asset('assets/icons/filter.svg',
                        width: 25.w, height: 25.h),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _buildFilterChip(S.of(context).trim)),
                          SizedBox(width: 7.w),
                          Expanded(child: _buildFilterChip(S.of(context).year)),
                          SizedBox(width: 7.w),
                          Expanded(child: _buildFilterChip(S.of(context).km)),
                          SizedBox(width: 7.w),
                          Expanded(child: _buildFilterChip(S.of(context).price)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isSmallScreen = MediaQuery.of(context).size.width <= 370;
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
                        SizedBox(width: isSmallScreen ? 35.w : 30.w),
                        Expanded(
                          child: Container(
                            height: 37.h,
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: isSmallScreen ? 8.w : 12.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFF08C2C9)),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/locationicon.svg',
                                  width: 18.w,
                                  height: 18.h,
                                ),
                                SizedBox(width: isSmallScreen ? 12.w : 15.w),
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
                                  width: isSmallScreen ? 35.w : 32.w,
                                  child: Transform.scale(
                                    scale: isSmallScreen ? 0.8 : .9,
                                    child: Switch(
                                      value: true,
                                      onChanged: (val) {},
                                      activeColor: Colors.white,
                                      activeTrackColor: const Color(0xFF08C2C9),
                                      inactiveThumbColor: isSmallScreen ? Colors.white : Colors.grey,
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
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
    if (mounted) {
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _removeFloatingOverlayBar() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _resetState() {
    _CarSalesState.scrollPosition = 0;
    _CarSalesState.shouldShowOverlay = false;
    _CarSalesState.keepOverlayVisible = false;
  }

  @override
  void dispose() {
    _isScreenActive = false;
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    _removeFloatingOverlayBar();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
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

    for (var car in CarSalesDummyData) {
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
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                _handleScroll();
              }
              return false;
            },
            child: SingleChildScrollView(
              key: const PageStorageKey('car_sales_scroll'),
              controller: _scrollController,
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _removeFloatingOverlayBar();
                            _resetState();
                            context.pop();
                          },
                          child: Row(
                            children: [
                              Icon(Icons.arrow_back_ios, color: KTextColor, size: 17.sp),
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
                        SizedBox(height: 3.h),
                        Center(
                          child: Text(
                            S.of(context).carsales,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24.sp,
                              color: KTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/filter.svg',
                            width: 25.w, height: 25.h),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(child: _buildFilterChip(S.of(context).trim)),
                              SizedBox(width: 7.w),
                              Expanded(child: _buildFilterChip(S.of(context).year)),
                              SizedBox(width: 7.w),
                              Expanded(child: _buildFilterChip(S.of(context).km)),
                              SizedBox(width: 7.w),
                              Expanded(child: _buildFilterChip(S.of(context).price)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        bool isSmallScreen = MediaQuery.of(context).size.width <= 370;
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
                            SizedBox(width: isSmallScreen ? 35.w : 30.w),
                            Expanded(
                              child: Container(
                                height: 37.h,
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: isSmallScreen ? 8.w : 12.w),
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFF08C2C9)),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/locationicon.svg',
                                      width: 18.w,
                                      height: 18.h,
                                    ),
                                    SizedBox(width: isSmallScreen ? 12.w : 15.w),
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
                                      width: isSmallScreen ? 35.w : 32.w,
                                      child: Transform.scale(
                                        scale: isSmallScreen ? 0.8 : .9,
                                        child: Switch(
                                          value: true,
                                          onChanged: (val) {},
                                          activeColor: Colors.white,
                                          activeTrackColor: const Color(0xFF08C2C9),
                                          inactiveThumbColor: isSmallScreen ? Colors.white : Colors.grey,
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
                      },
                    ),
                  ),
                
                  SizedBox(height: 5.h),
                  if (firstPremiumCars.isNotEmpty) ...[
                    _buildSectionTitle(S.of(context).priority_first_premium),
                    ...firstPremiumCars.map(_buildCard).toList(),
                  ],
                  if (premiumCars.isNotEmpty) ...[
                    _buildSectionTitle(S.of(context).priority_premium),
                    ...premiumCars.map(_buildCard).toList(),
                  ],
                  if (featuredCars.isNotEmpty) ...[
                    _buildSectionTitle(S.of(context).priority_featured),
                    ...featuredCars.map(_buildCard).toList(),
                  ],
                  if (freeCars.isNotEmpty) ...[
                    _buildSectionTitle(S.of(context).priority_free),
                    ...freeCars.map(_buildCard).toList(),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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

  Widget _buildCard(FavoriteItemInterface item) {
    return GestureDetector(
      onTap: () {
        _CarSalesState.scrollPosition = _scrollController.offset;
        _CarSalesState.shouldShowOverlay = _showOverlayBar;
        _CarSalesState.keepOverlayVisible = _showOverlayBar;
        _removeFloatingOverlayBar();
        context.push('/car-details', extra: item).then((_) {
          if (_CarSalesState.keepOverlayVisible && mounted) {
            _showOverlayBar = true;
            _showFloatingOverlayBar();
          }
        });
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SearchCard(
          item: item,
          showDelete: false,
          onAddToFavorite: () {},
          onDelete: () {
            setState(() {
              CarSalesDummyData.remove(item);
            });
          },
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
}