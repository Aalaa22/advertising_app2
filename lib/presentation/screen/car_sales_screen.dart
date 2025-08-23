import 'dart:math';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/presentation/widget/custom_bottom_nav.dart';
import 'package:advertising_app/presentation/widget/custom_category.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:advertising_app/data/car_sales_data_dummy.dart';

// تعريف الثوابت المستخدمة في الألوان
const Color KTextColor = Color.fromRGBO(0, 30, 91, 1);
const Color KPrimaryColor = Color.fromRGBO(1, 84, 126, 1);
final Color borderColor = Color.fromRGBO(8, 194, 201, 1);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // تم إرجاع المتغيرات إلى قوائم لدعم الاختيار المتعدد
  List<String> _selectedMakes = [];
  List<String> _selectedModels = [];

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
    final s = S.of(context);

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
                            height: 35.h,
                            child: TextField(
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                hintText: S.of(context).smart_search,
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(129, 126, 126, 1),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                                prefixIcon: Icon(Icons.search,
                                    color: borderColor, size: 25.sp),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(color: borderColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                        color: borderColor, width: 1.5)),
                                filled: true,
                                fillColor: Colors.white,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 0.h),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.notifications_none,
                              color: borderColor, size: 35.sp),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                    child: CustomCategoryGrid(
                      categories: categories,
                      selectedIndex: _selectedIndex,
                      onTap: (index) => setState(() => _selectedIndex = index),
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
                              S.of(context).discover_best_cars_deals,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp,
                                  color: KTextColor),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),

                        // +++ استخدام ودجت الاختيار المتعدد لحقل الـ Make +++
                        _buildMultiSelectField(
                          context,
                          s.make,
                          _selectedMakes,
                          ['Toyota', 'Honda', 'Ford', 'Mercedes', 'BMW'],
                          (selection) => setState(() {
                            _selectedMakes = selection;
                            _selectedModels = [];
                          }),
                        ),
                        SizedBox(height: 3.h),

                        // +++ استخدام ودجت الاختيار المتعدد لحقل الـ Model +++
                        _buildMultiSelectField(
                          context,
                          s.model,
                          _selectedModels,
                          [
                            'Camry',
                            'Accord',
                            'Explorer',
                            'C-Class',
                            '3-Series'
                          ],
                          (selection) =>
                              setState(() => _selectedModels = selection),
                        ),
                        SizedBox(height: 4.h),

                        Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                          child: GestureDetector(
                            onTap: () => context.push('/cars-sales'),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(1, 84, 126, 1),
                                  borderRadius: BorderRadius.circular(8)),
                              height: 43,
                              width: double.infinity,
                              child: Center(
                                  child: Text(S.of(context).search,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))),
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                          child: GestureDetector(
                            onTap: () => context.push('/offer_box'),
                            child: Container(
                              padding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 8.w),
                              height: 68.h,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFE4F8F6),
                                    Color(0xFFC9F8FE)
                                  ],
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
                                          fontSize: 13.sp,
                                          color: KTextColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Icon(Icons.arrow_forward_ios,
                                      size: 22.sp, color: KTextColor),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
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
                                  color: KTextColor),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(3, (sectionIndex) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.symmetric(
                                      horizontal: 8.w, vertical: 8.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Al Manara Motors",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: KTextColor)),
                                      Spacer(),
                                      InkWell(
                                        onTap: () =>
                                            context.push('/all_ad_car_sales'),
                                        child: Text(
                                          S.of(context).see_all_ads,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: borderColor,
                                              color: borderColor,
                                              fontWeight: FontWeight.w500),
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
                                    reverse: false,
                                    itemCount:
                                        min(CarSalesDummyData.length, 20),
                                    padding: EdgeInsetsDirectional.symmetric(
                                        horizontal: 5.w),
                                    itemBuilder: (context, index) {
                                      final car = CarSalesDummyData[index];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.only(
                                          end: index ==
                                                  CarSalesDummyData.length - 1
                                              ? 0
                                              : 4.w,
                                        ),
                                        child: Container(
                                          width: 145,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.15),
                                                  blurRadius: 5.r,
                                                  offset: Offset(0, 2.h))
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Stack(children: [
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.r),
                                                    child: Image.asset(
                                                        car.image,
                                                        height: (94).h,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover)),
                                                Positioned(
                                                    top: 8,
                                                    right: 8,
                                                    child: Icon(
                                                        Icons.favorite_border,
                                                        color: Colors
                                                            .grey.shade300)),
                                              ]),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 6.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(car.price,
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize:
                                                                  11.5.sp)),
                                                      Text(car.title,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 11.5.sp,
                                                              color:
                                                                  KTextColor),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                      Row(
                                                        children: [
                                                          Text("${car.year}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      11.5.sp,
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      165,
                                                                      164,
                                                                      162,
                                                                      1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                          SizedBox(width: 8.w),
                                                          Text("${car.km} KM",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      11.5.sp,
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      165,
                                                                      164,
                                                                      162,
                                                                      1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
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
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ++++         ودجت بناء الحقول المعاد استخدامها             ++++
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Widget _buildMultiSelectField(
    BuildContext context,
    String title,
    List<String> selectedValues,
    List<String> allItems,
    Function(List<String>) onConfirm) {
  final s = S.of(context);
  String displayText =
      selectedValues.isEmpty ? title : selectedValues.join(', ');

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.w),
    child: GestureDetector(
      onTap: () async {
        final result = await showModalBottomSheet<List<String>>(
          context: context,
          backgroundColor: Colors.white,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (context) => _MultiSelectBottomSheet(
              title: title, items: allItems, initialSelection: selectedValues),
        );
        if (result != null) {
          onConfirm(result);
        }
      },
      child: Container(
        height: 48,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          displayText,
          style: TextStyle(
              fontWeight:
                  selectedValues.isEmpty ? FontWeight.normal : FontWeight.w500,
              color: selectedValues.isEmpty ? Colors.grey.shade500 : KTextColor,
              fontSize: 12),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    ),
  );
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ++++                اللوحات السفلية (Bottom Sheets)         ++++
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class _MultiSelectBottomSheet extends StatefulWidget {
  final String title;
  final List<String> items;
  final List<String> initialSelection;
  const _MultiSelectBottomSheet(
      {Key? key,
      required this.title,
      required this.items,
      required this.initialSelection})
      : super(key: key);
  @override
  _MultiSelectBottomSheetState createState() => _MultiSelectBottomSheetState();
}

class _MultiSelectBottomSheetState extends State<_MultiSelectBottomSheet> {
  late final List<String> _selectedItems;
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredItems = [];
  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.initialSelection);
    _filteredItems = List.from(widget.items);
    _searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(query))
          .toList();
    });
  }

  void _onItemTapped(String item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Theme(
      data: Theme.of(context).copyWith(
        checkboxTheme: CheckboxThemeData(
          side: MaterialStateBorderSide.resolveWith(
            (_) => BorderSide(width: 1.0, color: borderColor),
          ),
        ),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: KTextColor)),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _searchController,
                  style: TextStyle(color: KTextColor),
                  decoration: InputDecoration(
                    hintText: s.search,
                    prefixIcon: Icon(Icons.search, color: KTextColor),
                    hintStyle: TextStyle(color: KTextColor.withOpacity(0.5)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: KPrimaryColor, width: 2)),
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(),
                Expanded(
                  child: _filteredItems.isEmpty
                      ? Center(
                          child: Text(s.noResultsFound,
                              style: TextStyle(color: KTextColor)))
                      : ListView.builder(
                          itemCount: _filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = _filteredItems[index];
                            return CheckboxListTile(
                              title: Text(item,
                                  style: TextStyle(color: KTextColor)),
                              value: _selectedItems.contains(item),
                              activeColor: KPrimaryColor,
                              checkColor: Colors.white,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (_) => _onItemTapped(item),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, _selectedItems),
                    child: Text(s.apply),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: KPrimaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
