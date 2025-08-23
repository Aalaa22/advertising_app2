import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

// تعريف الثوابت المستخدمة في الألوان
const Color KTextColor = Color.fromRGBO(0, 30, 91, 1);
const Color KPrimaryColor = Color.fromRGBO(1, 84, 126, 1);
final Color KDisabledColor = Colors.white;
final Color KDisabledTextColor = Colors.grey.shade600;

class CarSalesSaveAdScreen extends StatefulWidget {
  final Function(Locale) onLanguageChange;

  const CarSalesSaveAdScreen({Key? key, required this.onLanguageChange}) : super(key: key);

  @override
  State<CarSalesSaveAdScreen> createState() => _CarSalesSaveAdScreenState();
}

class _CarSalesSaveAdScreenState extends State<CarSalesSaveAdScreen> {
  // --- Controllers & Variables for EDITABLE fields ---
  final TextEditingController _priceController = TextEditingController(text: '200000');
  final TextEditingController _descriptionController = TextEditingController(text: '20% Down Payment With Insurance Registration And Delivery To Client Without Fees');
  
  String? selectedPhoneNumber = '00971508236561';
  String? selectedWhatsAppNumber = '00971508236561';

  @override
  void dispose() {
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final currentLocale = Localizations.localeOf(context).languageCode;
    final Color borderColor = Color.fromRGBO(8, 194, 201, 1);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25.h),
              GestureDetector(
                onTap: () => context.pop(),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    Icon(Icons.arrow_back_ios, color: KTextColor, size: 20.sp),
                    Transform.translate(
                      offset: Offset(-3.w, 0),
                      child: Text(s.back, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: KTextColor)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7.h),
              Center(
                child: Text(s.appTitle, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24.sp, color: KTextColor)),
              ),
              SizedBox(height: 8.h),
              
              // +++ بداية الحقول - مقروءة فقط +++
              _buildReadOnlyField(s.make, 'Audi'),
              const SizedBox(height: 7),
              _buildFormRow([
                _buildReadOnlyField(s.model, 'Q5'),
                _buildReadOnlyField(s.trim, 'TSI'),
              ]),
              const SizedBox(height: 7),
              _buildFormRow([
                _buildReadOnlyField(s.year, '2022'),
                _buildReadOnlyField(s.km, '25,000 KM'),
              ]),
              const SizedBox(height: 7),

              // +++ حقل السعر - قابل للتعديل +++
              _buildEditableTextField(s.price, 'AED', _priceController, borderColor, currentLocale, isNumber: true),
              const SizedBox(height: 7),

              // +++ حقول مقروءة فقط +++
              _buildReadOnlyField(s.specs, 'GCC'),
              const SizedBox(height: 7),
              _buildTitleBox(context, s.title, 'Luxury Audi With All Options', borderColor, currentLocale), // Title Box might need to be editable, check requirements
              const SizedBox(height: 7),
              _buildFormRow([
                _buildReadOnlyField(s.carType, 'SUV'),
                _buildReadOnlyField(s.transType, 'Auto'),
                _buildReadOnlyField(s.fuelType, 'Petrol'),
              ]),
              const SizedBox(height: 7),
              _buildFormRow([
                _buildReadOnlyField(s.color, 'Black'),
                _buildReadOnlyField(s.interiorColor, 'Black'),
                _buildReadOnlyField(s.warranty, 'Yes'),
              ]),
              const SizedBox(height: 15),
              _buildFormRow([
                _buildReadOnlyField(s.engineCapacity, '400', titleFontSize: 12.5),
                _buildReadOnlyField(s.cylinders, '6'),
                _buildReadOnlyField(s.horse_power, '3300'),
              ]),
              const SizedBox(height: 7),
              _buildFormRow([
                _buildReadOnlyField(s.doorsNo, '5'),
                _buildReadOnlyField(s.seatsNo, '4'),
                _buildReadOnlyField(s.steeringSide, 'Left'),
              ]),
              const SizedBox(height: 7),

              // +++ اسم المعلن - مقروء فقط +++
               _buildReadOnlyField(s.advertiserName, 'Al Manara Motors'),
              const SizedBox(height: 7),
              
              // +++ الهاتف والواتساب - قابل للتعديل +++
              _buildFormRow([
                 TitledSelectOrAddField(
                   title: s.phoneNumber, 
                   value: selectedPhoneNumber,
                   items: ['00971508236561', '00971501111111'],
                   onChanged: (newValue) => setState(() => selectedPhoneNumber = newValue), 
                   isNumeric: true
                 ),
                 TitledSelectOrAddField(
                   title: s.whatsApp, 
                   value: selectedWhatsAppNumber,
                   items: ['00971508236561', '00971502222222'],
                   onChanged: (newValue) => setState(() => selectedWhatsAppNumber = newValue), 
                   isNumeric: true
                 ),
              ]),
              const SizedBox(height: 7),

              _buildFormRow([
                _buildReadOnlyField(s.emirate, 'Dubai'),
                _buildReadOnlyField(s.advertiserType, 'Agent'),
              ]),
              const SizedBox(height: 7),
              _buildReadOnlyField(s.area, 'Souq Hiraj'),
              const SizedBox(height: 7),

              // +++ صندوق الوصف - قابل للتعديل +++
              TitledDescriptionBox(title: s.describeYourCar, controller: _descriptionController, borderColor: borderColor),
              const SizedBox(height: 10),
              
              // +++ الصور - قابلة للتعديل +++
              _buildImageButton(s.addMainImage, Icons.add_a_photo_outlined, borderColor),
              const SizedBox(height: 7),
              _buildImageButton(s.add14Images, Icons.add_photo_alternate_outlined, borderColor),
              const SizedBox(height: 10),
              
              Text(s.location, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp, color: KTextColor)),
              SizedBox(height: 4.h),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/locationicon.svg', width: 20.w, height: 20.h),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text('Dubai souq alharaj', style: TextStyle(fontSize: 14.sp, color: KTextColor, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              _buildMapSection(context),
              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(s.save, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: KPrimaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- دوال المساعدة ---

  Widget _buildFormRow(List<Widget> children) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: children.map((child) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4.0), child: child))).toList());
  }
  
  // +++ دالة جديدة: لإنشاء حقل قابل للتعديل +++
  Widget _buildEditableTextField(String title, String hintText, TextEditingController controller, Color borderColor, String currentLocale, {bool isNumber = false}) {
     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 14.sp)), const SizedBox(height: 4),
      SizedBox(
        height: 48,
        child: TextFormField(
            controller: controller,
            style: TextStyle(fontWeight: FontWeight.w500, color: KTextColor, fontSize: 12.sp),
            textAlign: currentLocale == 'ar' ? TextAlign.right : TextAlign.left,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: hintText, hintStyle: TextStyle(color: Colors.grey.shade400),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: KPrimaryColor, width: 2)),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              fillColor: Colors.white, filled: true
            ),
        ),
      )
    ]);
  }

  // +++ دالة جديدة: لإنشاء حقل للقراءة فقط +++
  Widget _buildReadOnlyField(String title, String value, {double? titleFontSize}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: titleFontSize ?? 14.sp)),
        const SizedBox(height: 4),
        Container(
          height: 48,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: KDisabledColor, // لون خلفية مختلف للإشارة إلى أنه غير قابل للتعديل
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w500, color: KDisabledTextColor, fontSize: 12.sp),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
  
  Widget _buildTitleBox(BuildContext context, String title, String initialValue, Color borderColor, String currentLocale) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 14.sp)), const SizedBox(height: 4),
      TextFormField(
        initialValue: initialValue,
        readOnly: true, // جعله للقراءة فقط
        style: TextStyle(fontWeight: FontWeight.w500, color: KDisabledTextColor, fontSize: 14.sp),
        decoration: InputDecoration(
          filled: true,
          fillColor: KDisabledColor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade400)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade400)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade400)),
          contentPadding: EdgeInsets.all(12),
        ),
      ),
    ]);
  }
  
  Widget _buildImageButton(String title, IconData icon, Color borderColor) {
    return SizedBox(width: double.infinity, child: OutlinedButton.icon(icon: Icon(icon, color: KTextColor), label: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 16.sp)), onPressed: () {}, style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), side: BorderSide(color: borderColor), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)))));
  }

  Widget _buildMapSection(BuildContext context) {
    return SizedBox(
        height: 320.h, width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset('assets/images/map.png', fit: BoxFit.cover))),
            Positioned(top: 180, left: 30, right: 30, child: Icon(Icons.location_pin, color: Colors.red, size: 40)),
            Positioned(
              bottom: 10, left: 10, right: 155,
              child: ElevatedButton.icon(
                icon: Icon(Icons.location_on_outlined, color: Colors.white, size: 26),
                label: Text(S.of(context).locateMe, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: KPrimaryColor, minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
    );
  }
}

class TitledSelectOrAddField extends StatelessWidget {
  final String title; final String? value; final List<String> items; final Function(String) onChanged; final bool isNumeric;
  const TitledSelectOrAddField({ Key? key, required this.title, required this.value, required this.items, required this.onChanged, this.isNumeric = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final borderColor = Color.fromRGBO(8, 194, 201, 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 14.sp)), const SizedBox(height: 4),
        GestureDetector(
          onTap: () async {
            final result = await showModalBottomSheet<String>(
              context: context, backgroundColor: Colors.white, isScrollControlled: true, shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
              builder: (_) => _SearchableSelectOrAddBottomSheet(title: title, items: items, isNumeric: isNumeric),
            );
            if(result != null && result.isNotEmpty){ onChanged(result); }
          },
          child: Container(
            height: 48, padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(8)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ Expanded(child: Text( value ?? s.chooseAnOption, style: TextStyle(fontWeight: value == null ? FontWeight.normal : FontWeight.w500, color: value == null ? Colors.grey.shade500 : KTextColor, fontSize: 12.sp))),],),),
        )
      ],
    );
  }
}

class _SearchableSelectOrAddBottomSheet extends StatefulWidget {
  final String title; final List<String> items; final bool isNumeric;
  const _SearchableSelectOrAddBottomSheet({Key? key, required this.title, required this.items, this.isNumeric = false}) : super(key: key);
  @override
  _SearchableSelectOrAddBottomSheetState createState() => _SearchableSelectOrAddBottomSheetState();
}

class _SearchableSelectOrAddBottomSheetState extends State<_SearchableSelectOrAddBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _addController = TextEditingController();
  List<String> _filteredItems = [];
  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(widget.items);
    _searchController.addListener(_filterItems);
  }
  @override
  void dispose() {
    _searchController.dispose();
    _addController.dispose();
    super.dispose();
  }
  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = widget.items.where((item) => item.toLowerCase().contains(query)).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final borderColor = Color.fromRGBO(8, 194, 201, 1);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 16, left: 16, right: 16),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: KTextColor)),
            const SizedBox(height: 16),
            TextFormField(
              controller: _searchController,
              style: TextStyle(color: KTextColor),
              decoration: InputDecoration(
                hintText: s.search, prefixIcon: Icon(Icons.search, color: KTextColor), hintStyle: TextStyle(color: KTextColor.withOpacity(0.5)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: KPrimaryColor, width: 2)),
              ),
            ),
            const SizedBox(height: 8), const Divider(),
            Expanded(
              child: _filteredItems.isEmpty
                  ? Center(child: Text(s.noResultsFound, style: TextStyle(color: KTextColor)))
                  : ListView.builder(
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        return ListTile(title: Text(item, style: TextStyle(color: KTextColor)), onTap: () => Navigator.pop(context, item));
                      },
                    ),
            ),
            const Divider(), const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _addController, keyboardType: widget.isNumeric ? TextInputType.number : TextInputType.text,
                    style: TextStyle(fontWeight: FontWeight.w500, color: KTextColor, fontSize: 12.sp),
                    decoration: InputDecoration(
                      hintText: s.addNew,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: KPrimaryColor, width: 2)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () { if (_addController.text.isNotEmpty) { Navigator.pop(context, _addController.text); } },
                  child: Text(s.add, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: KPrimaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
class TitledDescriptionBox extends StatefulWidget {
  final String title;
  final TextEditingController controller; // Changed to accept a controller
  final Color borderColor;
  final int maxLength;
  const TitledDescriptionBox({Key? key, required this.title, required this.controller, required this.borderColor, this.maxLength = 5000}) : super(key: key);
  @override
  State<TitledDescriptionBox> createState() => _TitledDescriptionBoxState();
}
class _TitledDescriptionBoxState extends State<TitledDescriptionBox> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if(mounted){
         setState(() {});
      }
    });
  }
  @override
  void dispose() {
    // Controller is managed by the parent widget, no need to dispose here.
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 14.sp)),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: widget.borderColor)),
          child: Column(
            children: [
              TextFormField(
                controller: widget.controller,
                maxLines: null,
                maxLength: widget.maxLength,
                style: TextStyle(fontWeight: FontWeight.w500, color: KTextColor, fontSize: 14.sp),
                decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(12), counterText: ""),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text('${widget.controller.text.length}/${widget.maxLength}', style: TextStyle(color: Colors.grey, fontSize: 12), textDirection: TextDirection.ltr)),
              )
            ],
          ),
        ),
      ],
    );
  }
}