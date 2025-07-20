import 'package:advertising_app/constants.dart';
import 'package:advertising_app/data/real_estate_dummy_data.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/model/ad_priority.dart';
import 'package:advertising_app/widget/custom_search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:advertising_app/model/favorite_item_interface_model.dart';

// Global variables لحفظ الحالة
class _RealEstateState {
  static double scrollPosition = 0;
  static bool shouldShowOverlay = false;
  static bool wasOverlayVisible = false;
  static bool hasScrolledPast150 = false; // متغير جديد لتتبع التمرير
}

class RealEstateSearchScreen extends StatefulWidget {
  const RealEstateSearchScreen({super.key});

  @override
  State<RealEstateSearchScreen> createState() => _RealEstateSearchScreenState();
}

class _RealEstateSearchScreenState extends State<RealEstateSearchScreen>
    with WidgetsBindingObserver, RouteAware, AutomaticKeepAliveClientMixin {
  
  final ScrollController _scrollController = ScrollController();
  bool _showOverlayBar = false;
  double _lastOffset = 0;
  OverlayEntry? _overlayEntry;
  bool _isScreenActive = true;
  bool _isInitialized = false;
  
  // للاحتفاظ بحالة الصفحة
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addObserver(this);
    
    // استعادة الحالة المحفوظة فوراً
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeState();
    });
  }

  void _initializeState() {
    if (!mounted || _isInitialized) return;
    
    // استعادة scroll position
    if (_RealEstateState.scrollPosition > 0 && _scrollController.hasClients) {
      _scrollController.jumpTo(_RealEstateState.scrollPosition);
      _lastOffset = _RealEstateState.scrollPosition;
    }
    
    // استعادة overlay state
    if (_RealEstateState.shouldShowOverlay && _RealEstateState.scrollPosition > 150) {
      _showOverlayBar = true;
      _RealEstateState.hasScrolledPast150 = true; // استعادة الفلاغ
      _showFloatingOverlayBar();
    }
    
    _isInitialized = true;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      _removeFloatingOverlayBar();
    } else if (state == AppLifecycleState.resumed) {
      // لما التطبيق يرجع من الخلفية
      if (_RealEstateState.shouldShowOverlay && !_showOverlayBar) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showOverlayBar = true;
            _showFloatingOverlayBar();
          }
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    if (!_isInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _initializeState();
      });
    }
  }

  void _saveCurrentState() {
    if (_scrollController.hasClients) {
      _RealEstateState.scrollPosition = _scrollController.offset;
      _RealEstateState.shouldShowOverlay = _showOverlayBar;
      _RealEstateState.wasOverlayVisible = _showOverlayBar;
    }
  }

  void _handleScroll() {
    if (!_isScreenActive || !mounted) return;
    
    final currentOffset = _scrollController.offset;
    final scrollDelta = currentOffset - _lastOffset;
    
    // حفظ الحالة الحالية
    _RealEstateState.scrollPosition = currentOffset;

    // منطق مبسط: إظهار الـ overlay عند scroll up إذا كان تحت 150px حاليا أو سابقا
    if (scrollDelta < -3 && !_showOverlayBar) {
      // يظهر الـ overlay إذا كان المستخدم حاليا تحت 150 أو المسافة المحفوظة تحت 150
      if (currentOffset > 150 || _RealEstateState.scrollPosition >= 150) {
        setState(() {
          _showOverlayBar = true;
        });
        _RealEstateState.shouldShowOverlay = true;
        _showFloatingOverlayBar();
      }
    } 
    else if (scrollDelta > 3 && _showOverlayBar) {
      setState(() {
        _showOverlayBar = false;
      });
      _RealEstateState.shouldShowOverlay = false;
      _removeFloatingOverlayBar();
    }
    // إخفاء الـ overlay إذا وصل لأعلى الصفحة
    else if (currentOffset <= 100 && _showOverlayBar) {
      setState(() {
        _showOverlayBar = false;
      });
      _RealEstateState.shouldShowOverlay = false;
      _removeFloatingOverlayBar();
    }

    _lastOffset = currentOffset;
  }

  void _showFloatingOverlayBar() {
    if (!_isScreenActive || !mounted) return;
    
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
                          Expanded(child: _buildFilterChip(S.of(context).type)),
                          SizedBox(width: 7.w),
                          Expanded(child: _buildFilterChip(S.of(context).district)),
                          SizedBox(width: 7.w),
                          Expanded(child: _buildFilterChip(S.of(context).contract)),
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
                                        onChanged: (val) {},
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
    _RealEstateState.scrollPosition = 0;
    _RealEstateState.shouldShowOverlay = false;
    _RealEstateState.wasOverlayVisible = false;
    _RealEstateState.hasScrolledPast150 = false;
  }

  @override
  void dispose() {
    _isScreenActive = false;
    _scrollController.dispose();
    _removeFloatingOverlayBar();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // مطلوب للـ AutomaticKeepAliveClientMixin
    
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

    for (var car in RealEstateDummyData) {
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
          child: SingleChildScrollView(
            key: const PageStorageKey('real_estate_scroll'),
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
                      SizedBox(height: 3.h),
                      Center(
                        child: Text(
                          S.of(context).realestate,
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
                            Expanded(
                                child: _buildFilterChip(S.of(context).type)),
                            SizedBox(width: 7.w),
                            Expanded(
                                child: _buildFilterChip(S.of(context).district)),
                            SizedBox(width: 7.w),
                            Expanded(
                                child: _buildFilterChip(S.of(context).contract)),
                            SizedBox(width: 7.w),
                            Expanded(
                                child: _buildFilterChip(S.of(context).price)),
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
                                          onChanged: (val) {},
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
        // حفظ الحالة الحالية قبل الانتقال
        _saveCurrentState();
        _removeFloatingOverlayBar();
        context.push('/real-details', extra: item);
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SearchCard(
          showLine1: false,
          item: item,
          showDelete: false,
          onAddToFavorite: () {},
          onDelete: () {
            setState(() {
              RealEstateDummyData.remove(item);
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