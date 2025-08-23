import 'dart:math';
import 'package:advertising_app/data/model/car_ad_model.dart';
import 'package:advertising_app/presentation/providers/car_sales_ad_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/presentation/widget/custom_search_card.dart';
import 'package:advertising_app/data/model/ad_priority.dart';
import 'package:advertising_app/data/model/favorite_item_interface_model.dart';
import 'package:advertising_app/constant/string.dart';

// تعريف الثوابت
const Color KTextColor = Color.fromRGBO(0, 30, 91, 1);
const Color KPrimaryColor = Color.fromRGBO(1, 84, 126, 1);
final Color borderColor = const Color.fromRGBO(8, 194, 201, 1);

class CarSalesScreen extends StatefulWidget {
  const CarSalesScreen({super.key});

  @override
  State<CarSalesScreen> createState() => _CarSalesScreenState();
}

class _CarSalesScreenState extends State<CarSalesScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  bool _showFloatingFilterBar = false;
  double _lastScrollOffset = 0.0;
  
  List<String> _selectedTrims = [];
  String? _yearFrom, _yearTo;
  String? _kmFrom, _kmTo;
  String? _priceFrom, _priceTo;
  bool _isMapSortActive = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CarAdProvider>().fetchCarAds();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final currentOffset = _scrollController.offset;
    if (currentOffset <= 200) {
      if (_showFloatingFilterBar) setState(() => _showFloatingFilterBar = false);
      _lastScrollOffset = currentOffset; 
      return;
    }
    if (currentOffset < _lastScrollOffset) {
      if (!_showFloatingFilterBar) setState(() => _showFloatingFilterBar = true);
    } 
    else if (currentOffset > _lastScrollOffset) {
      if (_showFloatingFilterBar) setState(() => _showFloatingFilterBar = false);
    }
    _lastScrollOffset = currentOffset;
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
    final s = S.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<CarAdProvider>(
          builder: (context, provider, child) {
            if (provider.isLoadingAds && provider.carAds.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.loadAdsError != null && provider.carAds.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("An error occurred:\n${provider.loadAdsError}", textAlign: TextAlign.center, style: TextStyle(color: Colors.red.shade700)),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: const Text("Try Again"),
                        onPressed: () => provider.fetchCarAds(),
                      ),
                    ],
                  ),
                )
              );
            }
            
            final allAds = provider.carAds;

            return Stack( 
              children: [
                RefreshIndicator(
                  onRefresh: () => provider.fetchCarAds(),
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
                              GestureDetector(onTap: () => context.pop(), child: Row(children: [Icon(Icons.arrow_back_ios, color: KTextColor, size: 17.sp), Transform.translate(offset: Offset(-3.w, 0), child: Text( s.back, style: TextStyle( fontSize: 14.sp, fontWeight: FontWeight.w500, color: KTextColor)) )])),
                              SizedBox(height: 3.h),
                              Center(child: Text(s.carsales, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24.sp, color: KTextColor))),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 18.w), child: _buildFiltersRow(s)),
                        SizedBox(height: 4.h),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 18.w), child: _buildSortBar(s, provider.totalAds)),
                        SizedBox(height: 5.h),
                         if (allAds.isEmpty)
                           const Center(child: Padding(padding: EdgeInsets.all(32.0), child: Text("No ads found.")))
                         else 
                           ...allAds.map((ad) => _buildCard(ad)).toList(),
                      ],
                    ),
                  ),
                ),
                
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  top: _showFloatingFilterBar ? 0 : -160.h,
                  left: 0, right: 0,
                  child: Material(
                     elevation: 6, color: Colors.white,
                     child: Container(
                       padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                       decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                       child: Column(children: [
                         GestureDetector(
                             onTap: () => context.pop(),
                             child: Row(
                               children: [
                                 Icon(Icons.arrow_back_ios, color: KTextColor, size: 17.sp),
                                 Transform.translate(offset: Offset(-3.w,0), child: Text(s.back, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: KTextColor))),
                               ],
                             ),
                           ),
                           SizedBox(height: 8.h),
                           _buildFiltersRow(s),
                           SizedBox(height: 4.h),
                           _buildSortBar(s, provider.totalAds),
                       ]),
                     ),
                  ),
                )
              ],
            );
          },
        )
      ),
    );
  }

  Widget _buildSortBar(S s, int totalAds) {
     bool isSmallScreen = MediaQuery.of(context).size.width <= 370;
     return Row(
       children: [
         Text('ADS NO: $totalAds', style: TextStyle(fontSize: 12.sp, color: KTextColor, fontWeight: FontWeight.w400)),
         SizedBox(width: isSmallScreen ? 35.w : 30.w),
         Expanded(
           child: Container(
             height: 37.h,
             padding: EdgeInsetsDirectional.symmetric(horizontal: isSmallScreen ? 8.w : 12.w),
             decoration: BoxDecoration(border: Border.all(color: const Color(0xFF08C2C9)), borderRadius: BorderRadius.circular(8.r)),
             child: Row(
               children: [
                 SvgPicture.asset('assets/icons/locationicon.svg', width: 18.w, height: 18.h),
                 SizedBox(width: isSmallScreen ? 12.w : 15.w),
                 Expanded(child: Text(s.sort, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 12.sp))),
                 SizedBox(
                   width: isSmallScreen ? 35.w : 32.w,
                   child: Transform.scale(
                     scale: isSmallScreen ? 0.8 : .9,
                     child: Switch(value: _isMapSortActive, onChanged: (val) => setState(() => _isMapSortActive = val), activeColor: Colors.white, activeTrackColor: const Color(0xFF08C2C9), inactiveThumbColor: Colors.white, inactiveTrackColor: Colors.grey[300]),
                   ),
                 ),
               ],
             ),
           ),
         ),
       ],
     );
  }

  Widget _buildSectionTitle(String title) => Padding(padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0), child: Text(title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: KTextColor)));
  
  Widget _buildCard(CarAdModel item) {
    return GestureDetector(
      onTap: () => context.push('/car-details', extra: AdCardItemAdapter(item)),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SearchCard(item: AdCardItemAdapter(item), showDelete: false, onAddToFavorite: () {}, onDelete: () {}),
      ),
    );
  }

  Widget _buildFiltersRow(S s) {
    return SizedBox(
      height: 35.h,
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/filter.svg', width: 25.w, height: 25.h),
          SizedBox(width: 4.w),
          Flexible(flex: 3, child: _buildMultiSelectField(context, s.trim, _selectedTrims, const ["GLI", "XLI", "Limited"], (selection) => setState(() => _selectedTrims = selection), isFilter: true)),
          SizedBox(width: 1.w),
          Flexible(flex: 3, child: _buildRangePickerField(context, title: s.year, fromValue: _yearFrom, toValue: _yearTo, unit: "", isFilter: true, onTap: () async { final r = await _showRangePicker(context, title: s.year, initialFrom: _yearFrom, initialTo: _yearTo, unit: ""); if(r!=null) setState(() { _yearFrom=r['from']; _yearTo=r['to'];});})),
          SizedBox(width: 1.w),
          Flexible(flex: 3, child: _buildRangePickerField(context, title: s.km, fromValue: _kmFrom, toValue: _kmTo, unit: "KM", isFilter: true, onTap: () async { final r = await _showRangePicker(context, title: s.km, initialFrom: _kmFrom, initialTo: _kmTo, unit: "KM"); if(r!=null) setState(() { _kmFrom=r['from']; _kmTo=r['to'];});})),
          SizedBox(width: 1.w),
          Flexible(flex: 3, child: _buildRangePickerField(context, title: s.price, fromValue: _priceFrom, toValue: _priceTo, unit: "AED", isFilter: true, onTap: () async { final r = await _showRangePicker(context, title: s.price, initialFrom: _priceFrom, initialTo: _priceTo, unit: "AED"); if(r!=null) setState(() { _priceFrom=r['from']; _priceTo=r['to'];});})),
        ],
      ),
    );
  }
}


class AdCardItemAdapter implements FavoriteItemInterface {
  final CarAdModel _ad;
  AdCardItemAdapter(this._ad);
  @override String get contact => _ad.advertiserName;
  @override String get date => _ad.createdAt.split('T').first;
  @override String get details => _ad.description;
  @override String get imageUrl => _ad.mainImage;
  @override List<String> get images => [_ad.mainImage, ..._ad.thumbnailImages].where((img) => img.isNotEmpty).toList();
  @override bool get isPremium => _ad.priority != AdPriority.free;
  @override String get line1 => "Year: ${_ad.year}  Km: ${_ad.km}km   Specs: ${_ad.specs ?? ''}" ;
  @override String get line2 => _ad.title;
  @override String get price => "AED ${_ad.price}";
  @override String get location => _ad.emirate;
  @override AdPriority get priority => _ad.priority;
  @override String get title => _ad.title;
}

Widget _buildMultiSelectField(BuildContext context, String title, List<String> selectedValues, List<String> allItems, Function(List<String>) onConfirm, {bool isFilter = false}) {
  final s = S.of(context); String displayText = selectedValues.isEmpty ? title : selectedValues.join(', ');
  return GestureDetector(
    onTap: () async {
      final result = await showModalBottomSheet<List<String>>(context: context, isScrollControlled: true, builder: (context) => _MultiSelectBottomSheet(title: title, items: allItems, initialSelection: selectedValues));
      if (result != null) { onConfirm(result); }
    },
    child: Container(
        height: isFilter ? 35 : 48, alignment: Alignment.center, padding: const EdgeInsets.symmetric(horizontal: 8), 
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(8)),
        child: Text(displayText, style: TextStyle(fontWeight: FontWeight.w500, color: KTextColor, fontSize: 9.5), overflow: TextOverflow.ellipsis, maxLines: 1)
    ),
  );
}

Widget _buildRangePickerField(BuildContext context, {required String title, String? fromValue, String? toValue, required String unit, required VoidCallback onTap, bool isFilter = false}) {
  final s = S.of(context); String displayText = (fromValue == null || fromValue.isEmpty) && (toValue == null || toValue.isEmpty) ? title : '${fromValue ?? s.from} - ${toValue ?? s.to} $unit'.trim();
  return GestureDetector(
    onTap: onTap,
    child: Container(
        height: isFilter ? 35 : 48, alignment: Alignment.center, padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(8)),
        child: Text(displayText, style: TextStyle(fontWeight: FontWeight.w500, color: KTextColor, fontSize: 9.5), overflow: TextOverflow.ellipsis)),
  );
}

Future<Map<String, String?>?> _showRangePicker(BuildContext context, {required String title, String? initialFrom, String? initialTo, required String unit}) {
  return showModalBottomSheet<Map<String, String?>>(context: context, isScrollControlled: true, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), builder: (context) => _RangeSelectionBottomSheet(title: title, initialFrom: initialFrom, initialTo: initialTo, unit: unit));
}

class _MultiSelectBottomSheet extends StatefulWidget {
  final String title; final List<String> items; final List<String> initialSelection;
  const _MultiSelectBottomSheet({required this.title, required this.items, required this.initialSelection});
  @override _MultiSelectBottomSheetState createState() => _MultiSelectBottomSheetState();
}
class _MultiSelectBottomSheetState extends State<_MultiSelectBottomSheet> {
  late final List<String> _selectedItems;
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredItems = [];
  @override void initState() { super.initState(); _selectedItems = List.from(widget.initialSelection); _filteredItems = List.from(widget.items); _searchController.addListener(_filterItems); }
  @override void dispose() { _searchController.dispose(); super.dispose(); }
  void _filterItems() { final query = _searchController.text.toLowerCase(); setState(() => _filteredItems = widget.items.where((item) => item.toLowerCase().contains(query)).toList()); }
  void _onItemTapped(String item) { setState(() { if (_selectedItems.contains(item)) { _selectedItems.remove(item); } else { _selectedItems.add(item); }}); }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Theme(
      data: Theme.of(context).copyWith(checkboxTheme: CheckboxThemeData(side: MaterialStateBorderSide.resolveWith((_) => BorderSide(width: 1.0, color: borderColor),),),),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 16, left: 16, right: 16),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: KTextColor)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _searchController, style: const TextStyle(color: KTextColor), 
                decoration: InputDecoration(
                  hintText: s.search, prefixIcon: const Icon(Icons.search, color: KTextColor), hintStyle: TextStyle(color: KTextColor.withOpacity(0.5)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: KPrimaryColor, width: 2)),
                ),
              ),
              const SizedBox(height: 8), const Divider(),
              Expanded(
                child: _filteredItems.isEmpty 
                  ? Center(child: Text(s.noResultsFound, style: const TextStyle(color: KTextColor)))
                  : ListView.builder(
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        return CheckboxListTile(
                          title: Text(item, style: const TextStyle(color: KTextColor)), value: _selectedItems.contains(item),
                          activeColor: KPrimaryColor, checkColor: Colors.white, controlAffinity: ListTileControlAffinity.leading,
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
                  style: ElevatedButton.styleFrom(backgroundColor: KPrimaryColor, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  child: Text(s.apply),
                ),
              ),
               const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _RangeSelectionBottomSheet extends StatefulWidget {
  final String title; final String? initialFrom; final String? initialTo; final String unit;
  const _RangeSelectionBottomSheet({required this.title, this.initialFrom, this.initialTo, required this.unit});
  @override __RangeSelectionBottomSheetState createState() => __RangeSelectionBottomSheetState();
}
class __RangeSelectionBottomSheetState extends State<_RangeSelectionBottomSheet> {
  late TextEditingController _fromController;
  late TextEditingController _toController;
  @override void initState() { super.initState(); _fromController = TextEditingController(text: widget.initialFrom); _toController = TextEditingController(text: widget.initialTo); }
  @override void dispose() { _fromController.dispose(); _toController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    
    Widget buildTextField(String hint, String suffix, TextEditingController controller) {
      return Expanded(
        child: TextFormField(
          controller: controller, keyboardType: TextInputType.number, style: const TextStyle(fontWeight: FontWeight.w500, color: KTextColor, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint, hintStyle: TextStyle(color: Colors.grey.shade400),
            suffixIcon: suffix.isNotEmpty ? Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: Text(suffix, style: const TextStyle(color: KTextColor, fontWeight: FontWeight.bold, fontSize: 12))) : null,
            suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: KPrimaryColor, width: 2)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), fillColor: Colors.white, filled: true,
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: KTextColor)),
            TextButton(
              onPressed: () { _fromController.clear(); _toController.clear(); setState(() {}); }, 
              child: Text(s.reset, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14.sp))),
          ]),
          SizedBox(height: 16.h),
          Row(children: [
            buildTextField(s.from, widget.unit, _fromController),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: Text(s.to, style: const TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 14))),
            buildTextField(s.to, widget.unit, _toController),
          ]),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context, {'from': _fromController.text, 'to': _toController.text}),
              style: ElevatedButton.styleFrom(backgroundColor: KPrimaryColor, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              child: Text(s.apply, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}




// import 'dart:math';
// import 'package:advertising_app/data/model/car_ad_model.dart';
// import 'package:advertising_app/presentation/providers/car_sales_ad_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// import 'package:advertising_app/generated/l10n.dart';
// import 'package:advertising_app/presentation/widget/custom_search_card.dart';
// import 'package:advertising_app/data/model/ad_priority.dart';
// import 'package:advertising_app/data/model/favorite_item_interface_model.dart';

// // تعريف الثوابت
// const Color KTextColor = Color.fromRGBO(0, 30, 91, 1);
// const Color KPrimaryColor = Color.fromRGBO(1, 84, 126, 1);
// final Color borderColor = const Color.fromRGBO(8, 194, 201, 1);

// class CarSalesScreen extends StatefulWidget {
//   const CarSalesScreen({super.key});

//   @override
//   State<CarSalesScreen> createState() => _CarSalesScreenState();
// }

// class _CarSalesScreenState extends State<CarSalesScreen>
//     with AutomaticKeepAliveClientMixin {
//   final ScrollController _scrollController = ScrollController();
//   bool _showFloatingFilterBar = false;
//   double _lastScrollOffset = 0.0;

//   // متغيرات الفلاتر
//   List<String> _selectedTrims = [];
//   String? _yearFrom, _yearTo;
//   String? _kmFrom, _kmTo;
//   String? _priceFrom, _priceTo;
//   bool _isMapSortActive = false;

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_handleScroll);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<CarAdProvider>().fetchCarAds();
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_handleScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _handleScroll() {
//     final currentOffset = _scrollController.offset;
//     if (currentOffset <= 200) {
//       if (_showFloatingFilterBar) setState(() => _showFloatingFilterBar = false);
//       _lastScrollOffset = currentOffset; 
//       return;
//     }
    
//     if (currentOffset < _lastScrollOffset) {
//       if (!_showFloatingFilterBar) setState(() => _showFloatingFilterBar = true);
//     } 
//     else if (currentOffset > _lastScrollOffset) {
//       if (_showFloatingFilterBar) setState(() => _showFloatingFilterBar = false);
//     }
//     _lastScrollOffset = currentOffset;
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
//     final s = S.of(context);
//     final locale = Localizations.localeOf(context).languageCode;
    
//     return Directionality(
//       textDirection: locale == 'ar' ? TextDirection.rtl : TextDirection.ltr,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: Consumer<CarAdProvider>(
//             builder: (context, provider, child) {
//               if (provider.isLoadingAds && provider.carAds.isEmpty) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (provider.loadAdsError != null && provider.carAds.isEmpty) {
//                 return Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("An error occurred:\n${provider.loadAdsError}", textAlign: TextAlign.center, style: TextStyle(color: Colors.red.shade700)),
//                         const SizedBox(height: 10),
//                         ElevatedButton.icon(
//                           icon: const Icon(Icons.refresh),
//                           label: const Text("Try Again"),
//                           onPressed: () => provider.fetchCarAds(),
//                         ),
//                       ],
//                     ),
//                   )
//                 );
//               }
              
//               final allAds = provider.carAds;

//               return Stack( 
//                 children: [
//                   RefreshIndicator(
//                     onRefresh: () => provider.fetchCarAds(),
//                     child: SingleChildScrollView(
//                       key: const PageStorageKey('car_sales_scroll'),
//                       controller: _scrollController,
//                       padding: const EdgeInsets.all(4),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 10.h),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 18.w),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () => context.pop(),
//                                   child: Row(
//                                     children: [
//                                       Icon(Icons.arrow_back_ios, color: KTextColor, size: 17.sp),
//                                       Transform.translate(
//                                         offset: Offset(-3.w, 0),
//                                         child: Text( s.back, style: TextStyle( fontSize: 14.sp, fontWeight: FontWeight.w500, color: KTextColor)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: 3.h),
//                                 Center(child: Text(s.carsales, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24.sp, color: KTextColor))),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 8.h),
//                           Padding(padding: EdgeInsets.symmetric(horizontal: 18.w), child: _buildFiltersRow(s)),
//                           SizedBox(height: 4.h),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 18.w),
//                             child: LayoutBuilder(
//                               builder: (context, constraints) {
//                                 bool isSmallScreen = MediaQuery.of(context).size.width <= 370;
//                                 return Row(
//                                   children: [
//                                     Text( '${s.ad} ${provider.totalAds}', style: TextStyle(fontSize: 12.sp, color: KTextColor, fontWeight: FontWeight.w400)),
//                                     SizedBox(width: isSmallScreen ? 35.w : 30.w),
//                                     Expanded(
//                                       child: Container(
//                                         height: 37.h,
//                                         padding: EdgeInsetsDirectional.symmetric(horizontal: isSmallScreen ? 8.w : 12.w),
//                                         decoration: BoxDecoration(border: Border.all(color: const Color(0xFF08C2C9)), borderRadius: BorderRadius.circular(8.r)),
//                                         child: Row(
//                                           children: [
//                                             SvgPicture.asset('assets/icons/locationicon.svg', width: 18.w, height: 18.h),
//                                             SizedBox(width: isSmallScreen ? 12.w : 15.w),
//                                             Expanded(child: Text(s.sort, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 12.sp))),
//                                             SizedBox(
//                                               width: isSmallScreen ? 35.w : 32.w,
//                                               child: Transform.scale(
//                                                 scale: isSmallScreen ? 0.8 : .9,
//                                                 child: Switch(value: true, onChanged: (val) {}, activeColor: Colors.white, activeTrackColor: const Color(0xFF08C2C9), inactiveThumbColor: Colors.grey, inactiveTrackColor: Colors.grey[300]),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                           SizedBox(height: 5.h),
//                            if (allAds.isEmpty)
//                              const Center(child: Padding(padding: EdgeInsets.all(32.0), child: Text("No ads found.")))
//                            else 
//                              ...allAds.map((ad) => _buildCard(ad)).toList(),
//                         ],
//                       ),
//                     ),
//                   ),
                
//                   AnimatedPositioned(
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.easeInOut,
//                     top: _showFloatingFilterBar ? 0 : -160.h,
//                     left: 0, right: 0,
//                     child: Material(
//                        elevation: 6, color: Colors.white,
//                        child: Container(
//                          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
//                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
//                          child: Column(children: [
//                            GestureDetector(onTap: () => context.pop(), child: Row(
//                              children: [
//                                Icon(Icons.arrow_back_ios, color: KTextColor, size: 17.sp),
//                                Transform.translate(offset: Offset(-3.w,0), child: Text(s.back, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: KTextColor))),
//                              ],
//                            )),
//                            SizedBox(height: 8.h),
//                            _buildFiltersRow(s),
//                            SizedBox(height: 4.h),
//                            LayoutBuilder(builder: (context, constraints) => Row(/* ... */)),
//                          ]),
//                        ),
//                     ),
//                   )
//                 ],
//               );
//             },
//           )
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) => Padding(padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0), child: Text(title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: KTextColor)));
  
//   Widget _buildCard(CarAdModel item) {
//     return GestureDetector(
//       onTap: () => context.push('/car-details', extra: AdCardItemAdapter(item)),
//       child: Directionality(
//         textDirection: TextDirection.ltr,
//         child: SearchCard(item: AdCardItemAdapter(item), showDelete: false, onAddToFavorite: () {}, onDelete: () {}),
//       ),
//     );
//   }

//   Widget _buildFiltersRow(S s) {
//     return SizedBox(
//       height: 35.h,
//       child: Row(
//         children: [
//           SvgPicture.asset('assets/icons/filter.svg', width: 25.w, height: 25.h),
//           SizedBox(width: 4.w),
//           Flexible(flex: 3, child: _buildMultiSelectField(context, s.trim, _selectedTrims, const ["GLI", "XLI", "Limited"], (selection) => setState(() => _selectedTrims = selection), isFilter: true)),
//           SizedBox(width: 1.w),
//           Flexible(flex: 3, child: _buildRangePickerField(context, title: s.year, fromValue: _yearFrom, toValue: _yearTo, unit: "", isFilter: true, onTap: () async { final r = await _showRangePicker(context, title: s.year, initialFrom: _yearFrom, initialTo: _yearTo, unit: ""); if(r!=null) setState(() { _yearFrom=r['from']; _yearTo=r['to'];});})),
//           SizedBox(width: 1.w),
//           Flexible(flex: 3, child: _buildRangePickerField(context, title: s.km, fromValue: _kmFrom, toValue: _kmTo, unit: "KM", isFilter: true, onTap: () async { final r = await _showRangePicker(context, title: s.km, initialFrom: _kmFrom, initialTo: _kmTo, unit: "KM"); if(r!=null) setState(() { _kmFrom=r['from']; _kmTo=r['to'];});})),
//           SizedBox(width: 1.w),
//           Flexible(flex: 3, child: _buildRangePickerField(context, title: s.price, fromValue: _priceFrom, toValue: _priceTo, unit: "AED", isFilter: true, onTap: () async { final r = await _showRangePicker(context, title: s.price, initialFrom: _priceFrom, initialTo: _priceTo, unit: "AED"); if(r!=null) setState(() { _priceFrom=r['from']; _priceTo=r['to'];});})),
//         ],
//       ),
//     );
//   }
// }


// class AdCardItemAdapter implements FavoriteItemInterface {
//   final CarAdModel _ad;
//   AdCardItemAdapter(this._ad);
  
//   @override String get contact => _ad.advertiserName;
//   @override
//   String get date {
//     // التحقق أولاً إذا كان التاريخ فارغًا
//     if (_ad.createdAt.isEmpty) {
//       return '';
//     }
//     // النص القادم من الـ API يكون بهذا الشكل: "2025-08-20T12:51:13.000000Z"
//     // نحن نريد فقط الجزء الأول قبل حرف 'T'
//     try {
//       return _ad.createdAt.split('T').first; //  النتيجة ستكون "2025-08-20"
//     } catch (e) {
//       // كإجراء احترازي إذا كان شكل النص مختلفًا
//       return _ad.createdAt;
//     }
//   }

//   @override String get details => _ad.description;
//   @override String get imageUrl => _ad.mainImage;
//   @override List<String> get images => [_ad.mainImage, ..._ad.thumbnailImages].where((img) => img.isNotEmpty).toList();
//   @override bool get isPremium => _ad.priority != AdPriority.free;
//   @override String get line1 => "Year: ${_ad.year}  Km: ${_ad.km}km   Specs: ${_ad.specs}" ;
//   @override String get line2 => _ad.title;
//   @override String get price => "AED ${_ad.price}";
//   @override String get location => _ad.emirate;
//   @override AdPriority get priority => _ad.priority;
//   @override String get title => _ad.title; // إضافة недостающая getter
 
// }


// Widget _buildMultiSelectField(BuildContext context, String title, List<String> selectedValues, List<String> allItems, Function(List<String>) onConfirm, {bool isFilter = false}) {
//   final s = S.of(context); String displayText = selectedValues.isEmpty ? title : selectedValues.join(', ');
//   return GestureDetector(
//     onTap: () async {
//       final result = await showModalBottomSheet<List<String>>(context: context, isScrollControlled: true, builder: (context) => _MultiSelectBottomSheet(title: title, items: allItems, initialSelection: selectedValues));
//       if (result != null) { onConfirm(result); }
//     },
//     child: Container(
//         height: isFilter ? 35 : 48, alignment: Alignment.center, padding: const EdgeInsets.symmetric(horizontal: 8), 
//         decoration: BoxDecoration(color: Colors.white, border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(8)),
//         child: Text(displayText, style: TextStyle(fontWeight: FontWeight.w500, color: KTextColor, fontSize: 9.5), overflow: TextOverflow.ellipsis, maxLines: 1)
//     ),
//   );
// }
// Widget _buildRangePickerField(BuildContext context, {required String title, String? fromValue, String? toValue, required String unit, required VoidCallback onTap, bool isFilter = false}) {
//   final s = S.of(context); String displayText = (fromValue == null || fromValue.isEmpty) && (toValue == null || toValue.isEmpty) ? title : '${fromValue ?? s.from} - ${toValue ?? s.to} $unit'.trim();
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//         height: isFilter ? 35 : 48, alignment: Alignment.center, padding: const EdgeInsets.symmetric(horizontal: 8),
//         decoration: BoxDecoration(color: Colors.white, border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(8)),
//         child: Text(displayText, style: TextStyle(fontWeight: FontWeight.w500, color: KTextColor, fontSize: 9.5), overflow: TextOverflow.ellipsis)),
//   );
// }
// Future<Map<String, String?>?> _showRangePicker(BuildContext context, {required String title, String? initialFrom, String? initialTo, required String unit}) {
//   return showModalBottomSheet<Map<String, String?>>(context: context, isScrollControlled: true, builder: (context) => _RangeSelectionBottomSheet(title: title, initialFrom: initialFrom, initialTo: initialTo, unit: unit));
// }

// class _MultiSelectBottomSheet extends StatefulWidget {
//   final String title; final List<String> items; final List<String> initialSelection;
//   const _MultiSelectBottomSheet({required this.title, required this.items, required this.initialSelection});
//   @override _MultiSelectBottomSheetState createState() => _MultiSelectBottomSheetState();
// }
// class _MultiSelectBottomSheetState extends State<_MultiSelectBottomSheet> {
//   late final List<String> _selectedItems;
//   final TextEditingController _searchController = TextEditingController();
//   List<String> _filteredItems = [];
//   @override void initState() { super.initState(); _selectedItems = List.from(widget.initialSelection); _filteredItems = List.from(widget.items); _searchController.addListener(_filterItems); }
//   @override void dispose() { _searchController.dispose(); super.dispose(); }
//   void _filterItems() { final query = _searchController.text.toLowerCase(); setState(() => _filteredItems = widget.items.where((item) => item.toLowerCase().contains(query)).toList()); }
//   void _onItemTapped(String item) { setState(() { if (_selectedItems.contains(item)) { _selectedItems.remove(item); } else { _selectedItems.add(item); }}); }

//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//     return Theme(
//       data: Theme.of(context).copyWith(checkboxTheme: CheckboxThemeData(side: MaterialStateBorderSide.resolveWith((_) => BorderSide(width: 1.0, color: borderColor),),),),
//       child: Padding(
//         padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: ConstrainedBox(
//           constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: KTextColor)),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _searchController, style: const TextStyle(color: KTextColor), 
//                   decoration: InputDecoration(
//                     hintText: s.search, prefixIcon: const Icon(Icons.search, color: KTextColor), hintStyle: TextStyle(color: KTextColor.withOpacity(0.5)),
//                     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
//                     focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: KPrimaryColor, width: 2)),
//                   ),
//                 ),
//                 const SizedBox(height: 8), const Divider(),
//                 Expanded(
//                   child: _filteredItems.isEmpty 
//                     ? Center(child: Text(s.noResultsFound, style: const TextStyle(color: KTextColor)))
//                     : ListView.builder(
//                         itemCount: _filteredItems.length,
//                         itemBuilder: (context, index) {
//                           final item = _filteredItems[index];
//                           return CheckboxListTile(
//                             title: Text(item, style: const TextStyle(color: KTextColor)), value: _selectedItems.contains(item),
//                             activeColor: KPrimaryColor, checkColor: Colors.white, controlAffinity: ListTileControlAffinity.leading,
//                             onChanged: (_) => _onItemTapped(item),
//                           );
//                         },
//                       ),
//                 ),
//                 const SizedBox(height: 16),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () => Navigator.pop(context, _selectedItems),
//                     style: ElevatedButton.styleFrom(backgroundColor: KPrimaryColor, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//                     child: Text(s.apply),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _RangeSelectionBottomSheet extends StatefulWidget {
//   final String title; final String? initialFrom; final String? initialTo; final String unit;
//   const _RangeSelectionBottomSheet({required this.title, this.initialFrom, this.initialTo, required this.unit});
//   @override __RangeSelectionBottomSheetState createState() => __RangeSelectionBottomSheetState();
// }
// class __RangeSelectionBottomSheetState extends State<_RangeSelectionBottomSheet> {
//   late TextEditingController _fromController;
//   late TextEditingController _toController;
//   @override void initState() { super.initState(); _fromController = TextEditingController(text: widget.initialFrom); _toController = TextEditingController(text: widget.initialTo); }
//   @override void dispose() { _fromController.dispose(); _toController.dispose(); super.dispose(); }

//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
    
//     Widget buildTextField(String hint, String suffix, TextEditingController controller) {
//       return Expanded(
//         child: TextFormField(
//           controller: controller, keyboardType: TextInputType.number, style: const TextStyle(fontWeight: FontWeight.w500, color: KTextColor, fontSize: 14),
//           decoration: InputDecoration(
//             hintText: hint, hintStyle: TextStyle(color: Colors.grey.shade400),
//             suffixIcon: suffix.isNotEmpty ? Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: Text(suffix, style: const TextStyle(color: KTextColor, fontWeight: FontWeight.bold, fontSize: 12))) : null,
//             suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
//             enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
//             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: KPrimaryColor, width: 2)),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), fillColor: Colors.white, filled: true,
//           ),
//         ),
//       );
//     }
//     return Padding(
//       padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: KTextColor)),
//             TextButton(
//               onPressed: () { _fromController.clear(); _toController.clear(); setState(() {}); }, 
//               child: Text(s.reset, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14.sp))),
//           ]),
//           SizedBox(height: 16.h),
//           Row(children: [
//             buildTextField(s.from, widget.unit, _fromController),
//             Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: Text(s.to, style: const TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 14))),
//             buildTextField(s.to, widget.unit, _toController),
//           ]),
//           SizedBox(height: 24.h),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () => Navigator.pop(context, {'from': _fromController.text, 'to': _toController.text}),
//               style: ElevatedButton.styleFrom(backgroundColor: KPrimaryColor, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//               child: Text(s.apply, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
//             ),
//           ),
//           SizedBox(height: 16.h),
//         ],
//       ),
//     );
//   }
// }