import 'dart:io';

import 'package:advertising_app/presentation/providers/car_sales_ad_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:advertising_app/generated/l10n.dart';

// الثوابت
const Color KTextColor = Color.fromRGBO(0, 30, 91, 1);
const Color KPrimaryColor = Color.fromRGBO(1, 84, 126, 1);

class CarSalesAdScreen extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const CarSalesAdScreen({Key? key, required this.onLanguageChange}) : super(key: key);

  @override
  State<CarSalesAdScreen> createState() => _CarSalesAdScreenState();
}

class _CarSalesAdScreenState extends State<CarSalesAdScreen> {
  // --- Controllers لحقول الإدخال النصية ---
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _kilometersController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  // --- متغيرات الحالة لحفظ الاختيارات ---
  String? selectedMake; String? selectedModel; String? selectedTrim; String? selectedYear;
  String? selectedSpec; String? selectedCarType; String? selectedTransType;
  String? selectedFuelType; String? selectedColor; String? selectedInteriorColor;
  String? selectedWarrantyValue;
  String? selectedEngineCap; String? selectedCylinder; String? selectedHorsePower;
  String? selectedDoor; String? selectedSeat; String? selectedSteeringSide;
  String? selectedEmirate; String? selectedAdvertiserType;
  String? selectedAdvertiserName; String? selectedPhoneNumber; String? selectedWhatsAppNumber;
  
  // --- متغيرات الحالة للصور ---
  File? _mainImage;
  final List<File> _thumbnailImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _titleController.dispose(); _descriptionController.dispose(); _priceController.dispose();
    _kilometersController.dispose(); _areaController.dispose();
    super.dispose();
  }
  
  Future<void> _pickMainImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (image != null) setState(() => _mainImage = File(image.path));
  }

  Future<void> _pickThumbnailImages() async {
    const int maxImages = 14;
    final int remainingSlots = maxImages - _thumbnailImages.length;
    if (remainingSlots <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You have already added the maximum of 14 images.')));
      return;
    }
    final List<XFile> pickedImages = await _picker.pickMultiImage(imageQuality: 85);
    if (pickedImages.isNotEmpty) {
      int addedCount = 0;
      for (var img in pickedImages) {
        if (_thumbnailImages.length < maxImages) {
          _thumbnailImages.add(File(img.path));
          addedCount++;
        }
      }
      setState(() {});
      if (addedCount < pickedImages.length) {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image limit reached. Only ${addedCount} of ${pickedImages.length} images were added.')));
      }
    }
  }

  Future<void> _submitAd() async {
    final s = S.of(context);
    List<String> validationErrors = [];
    if (_titleController.text.trim().isEmpty) validationErrors.add(s.title);
    if (_descriptionController.text.trim().isEmpty) validationErrors.add(s.describeYourCar);
    if (selectedMake == null) validationErrors.add(s.make);
    if (selectedModel == null) validationErrors.add(s.model);
    if (selectedYear == null) validationErrors.add(s.year);
    if (_kilometersController.text.trim().isEmpty) validationErrors.add(s.km);
    if (_priceController.text.trim().isEmpty) validationErrors.add(s.price);
    if (selectedTransType == null) validationErrors.add(s.transType);
    if (selectedPhoneNumber == null) validationErrors.add(s.phoneNumber);
    if (selectedEmirate == null) validationErrors.add(s.emirate);
    if (_areaController.text.trim().isEmpty) validationErrors.add(s.area);
    if (selectedAdvertiserName == null) validationErrors.add(s.advertiserName);
    if (selectedAdvertiserType == null) validationErrors.add(s.advertiserType);
    if (_mainImage == null) validationErrors.add("Main Image");
    
    if (validationErrors.isNotEmpty) {
      String errorMessage = "Please complete the required fields: ${validationErrors.join(', ')}.";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage), backgroundColor: Colors.orange));
      return;
    }
    
    final provider = context.read<CarAdProvider>();
    final bool warrantyToSend = selectedWarrantyValue == 'Yes';
    
    final success = await provider.submitCarAd(
      title: _titleController.text, description: _descriptionController.text, make: selectedMake!,
      model: selectedModel!, trim: selectedTrim, year: selectedYear!, km: _kilometersController.text,
      price: _priceController.text, specs: selectedSpec, carType: selectedCarType,
      transType: selectedTransType!, fuelType: selectedFuelType, color: selectedColor,
      interiorColor: selectedInteriorColor, warranty: warrantyToSend,
      engineCapacity: selectedEngineCap, cylinders: selectedCylinder, horsepower: selectedHorsePower,
      doorsNo: selectedDoor, seatsNo: selectedSeat, steeringSide: selectedSteeringSide,
      advertiserName: selectedAdvertiserName!, phoneNumber: selectedPhoneNumber!,
      whatsapp: selectedWhatsAppNumber, emirate: selectedEmirate!, area: _areaController.text,
      advertiserType: selectedAdvertiserType!, mainImage: _mainImage!, thumbnailImages: _thumbnailImages,
    );
    
    if(!mounted) return;
    if(success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ad posted successfully!"), backgroundColor: Colors.green));
      context.pop();
    } else {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.createAdError ?? "Failed to post ad."), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final currentLocale = Localizations.localeOf(context).languageCode;
    final Color borderColor = const Color.fromRGBO(8, 194, 201, 1);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
            Center(child: Text(s.appTitle, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24.sp, color: KTextColor))),
            SizedBox(height: 8.h),
            _buildTitledTextFormField(s.title, _titleController, borderColor, currentLocale),
            const SizedBox(height: 7),
            _buildFormRow([
              _buildSingleSelectField(context, s.make, selectedMake, ['Toyota', 'BMW', 'Mercedes'], (v) => setState(() => selectedMake = v)),
              _buildSingleSelectField(context, s.model, selectedModel, ['Camry', 'X5', 'C-Class'], (v) => setState(() => selectedModel = v)),
            ]),
            const SizedBox(height: 7),
            _buildFormRow([
              _buildSingleSelectField(context, s.trim, selectedTrim, ['GLX', 'Sport', 'AMG'], (v) => setState(() => selectedTrim = v)),
              _buildSingleSelectField(context, s.year, selectedYear, ['2023', '2022', '2021', '2020'], (v) => setState(() => selectedYear = v)),
            ]),
            const SizedBox(height: 7),
            _buildFormRow([
              _buildTitledTextFormField(s.km, _kilometersController, borderColor, currentLocale, isNumber: true, hintText: "e.g., 50000"),
              _buildTitledTextFormField(s.price, _priceController, borderColor, currentLocale, isNumber: true, hintText: "e.g., 120000"),
            ]),
            const SizedBox(height: 7),
            _buildFormRow([
              _buildSingleSelectField(context, s.specs, selectedSpec, ['GCC', 'Japanese', 'American'], (v) => setState(() => selectedSpec = v)),
              _buildSingleSelectField(context, s.carType, selectedCarType, ['SUV', 'Sedan', 'Hatchback'], (v) => setState(() => selectedCarType = v)),
            ]),
            const SizedBox(height: 7),
            _buildFormRow([
              _buildSingleSelectField(context, s.transType, selectedTransType, ['Automatic', 'Manual'], (v) => setState(() => selectedTransType = v)),
              _buildSingleSelectField(context, s.fuelType, selectedFuelType, ['Petrol', 'Diesel', 'Electric'], (v) => setState(() => selectedFuelType = v)),
            ]),
            const SizedBox(height: 7),
            _buildFormRow([
              _buildSingleSelectField(context, s.color, selectedColor, ['White', 'Black', 'Silver'], (v) => setState(() => selectedColor = v)),
              _buildSingleSelectField(context, s.interiorColor, selectedInteriorColor, ['Beige', 'Black', 'Red'], (v) => setState(() => selectedInteriorColor = v)),
              _buildSingleSelectField(context, s.warranty, selectedWarrantyValue, ['Yes', 'No'], (selection) => setState(() => selectedWarrantyValue = selection)),
            ]),
            const SizedBox(height: 15),
            _buildFormRow([
              _buildSingleSelectField(context, s.engineCapacity, selectedEngineCap, ['2500', '3500', '5000'], (v) => setState(() => selectedEngineCap = v), titleFontSize: 12.5),
              _buildSingleSelectField(context, s.cylinders, selectedCylinder, ['4', '6', '8'], (v) => setState(() => selectedCylinder = v)),
              _buildSingleSelectField(context, s.horse_power, selectedHorsePower, ['178', '300', '450'], (v) => setState(() => selectedHorsePower = v)),
            ]),
            const SizedBox(height: 7),
            _buildFormRow([
              _buildSingleSelectField(context, s.doorsNo, selectedDoor, ['2', '3', '4', '5'], (v) => setState(() => selectedDoor = v)),
              _buildSingleSelectField(context, s.seatsNo, selectedSeat, ['2', '4', '5', '7'], (v) => setState(() => selectedSeat = v)),
              _buildSingleSelectField(context, s.steeringSide, selectedSteeringSide, ['Left', 'Right'], (v) => setState(() => selectedSteeringSide = v)),
            ]),
            const SizedBox(height: 7),
            TitledSelectOrAddField(
              title: s.advertiserName, value: selectedAdvertiserName, 
              items: ['Ahmed Ali', 'CarDealer UAE'], onChanged: (v) => setState(() => selectedAdvertiserName = v),
            ),
            const SizedBox(height: 7),
            _buildFormRow([
              TitledSelectOrAddField(title: s.phoneNumber, value: selectedPhoneNumber, isNumeric: true, items: ['+971501234567'], onChanged: (v) => setState(() => selectedPhoneNumber = v)),
              TitledSelectOrAddField(title: s.whatsApp, value: selectedWhatsAppNumber, isNumeric: true, items: ['+971501234567'], onChanged: (v) => setState(() => selectedWhatsAppNumber = v)),
            ]),
            const SizedBox(height: 7),
            _buildFormRow([
              _buildSingleSelectField(context, s.emirate, selectedEmirate, ['Dubai', 'Abu Dhabi', 'Sharjah'], (v) => setState(() => selectedEmirate = v)),
              _buildSingleSelectField(context, s.advertiserType, selectedAdvertiserType, ['Individual', 'Dealer'], (v) => setState(() => selectedAdvertiserType = v)),
            ]),
            const SizedBox(height: 7),
            _buildTitledTextFormField(s.area, _areaController, borderColor, currentLocale, hintText: "e.g., Deira"),
            const SizedBox(height: 7),
            TitledDescriptionBox(title: s.describeYourCar, controller: _descriptionController, borderColor: borderColor),
            const SizedBox(height: 10),
            _buildImageButton(s.addMainImage, Icons.add_a_photo_outlined, borderColor, onPressed: _pickMainImage),
            if(_mainImage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.file(_mainImage!, height: 150, fit: BoxFit.cover))),
              ),
            const SizedBox(height: 7),
            _buildImageButton('${s.add14Images} (${_thumbnailImages.length}/14)', Icons.add_photo_alternate_outlined, borderColor, onPressed: _pickThumbnailImages),
            if(_thumbnailImages.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Wrap(spacing: 8, runSpacing: 8, children: _thumbnailImages.map((img) => ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.file(img, width: 80, height: 80, fit: BoxFit.cover))).toList()),
              ),
            const SizedBox(height: 10),
            Text(s.location, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp, color: KTextColor)),
            SizedBox(height: 4.h),
            Directionality(textDirection: TextDirection.ltr, child: Row(children: [ SvgPicture.asset('assets/icons/locationicon.svg', width: 20.w, height: 20.h), SizedBox(width: 8.w), Expanded(child: Text('Dubai souq alharaj', style: TextStyle(fontSize: 14.sp, color: KTextColor, fontWeight: FontWeight.w500))) ])),
            SizedBox(height: 8.h),
            _buildMapSection(context),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Consumer<CarAdProvider>(
                builder: (context, provider, child) {
                  return provider.isCreatingAd
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _submitAd,
                          style: ElevatedButton.styleFrom(backgroundColor: KPrimaryColor, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          child: Text(s.next, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        );
                },
              ),
            ),
             SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
  
  // --- دوال المساعدة للواجهة (كاملة) ---
  Widget _buildFormRow(List<Widget> children) { return Row(crossAxisAlignment: CrossAxisAlignment.start, children: children.map((child) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4.0), child: child))).toList()); }
  Widget _buildTitledTextFormField(String title, TextEditingController controller, Color borderColor, String currentLocale, {bool isNumber = false, String? hintText}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 14)), const SizedBox(height: 4),
      SizedBox(
        height: 48,
        child: TextFormField(
            controller: controller, style: const TextStyle(fontWeight: FontWeight.w500, color: KTextColor, fontSize: 12),
            textAlign: currentLocale == 'ar' ? TextAlign.right : TextAlign.left,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: hintText ?? "Enter value",
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: KPrimaryColor, width: 2)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              fillColor: Colors.white, filled: true
            ),
        ),
      )
    ]);
  }
  Widget _buildSingleSelectField(BuildContext context, String title, String? selectedValue, List<String> allItems, Function(String?) onConfirm, {double? titleFontSize}) {
    final s = S.of(context); String displayText = selectedValue ?? s.chooseAnOption;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: titleFontSize ?? 14)), const SizedBox(height: 4),
      GestureDetector(
        onTap: () async {
          final result = await _showSingleSelectPicker(context, title: title, items: allItems);
          if (result != null) onConfirm(result);
        },
        child: Container(
          height: 48, width: double.infinity, padding: const EdgeInsets.symmetric(horizontal: 16), alignment: Alignment.centerLeft,
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color.fromRGBO(8, 194, 201, 1)), borderRadius: BorderRadius.circular(8)),
          child: Text(displayText, style: TextStyle(fontWeight: selectedValue == null ? FontWeight.normal : FontWeight.w500, color: selectedValue == null ? Colors.grey.shade500 : KTextColor, fontSize: 12), overflow: TextOverflow.ellipsis, maxLines: 1),
        ),
      ),
    ]);
  }
  Future<String?> _showSingleSelectPicker(BuildContext context, {required String title, required List<String> items}) { return showModalBottomSheet<String>(context: context, backgroundColor: Colors.white, isScrollControlled: true, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), builder: (context) => _SingleSelectBottomSheet(title: title, items: items)); }
  Widget _buildTitleBox(BuildContext context, String title, TextEditingController controller, Color borderColor, String currentLocale) { return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 14)), const SizedBox(height: 4), TextFormField(controller: controller, maxLines: null, minLines: 2, style: const TextStyle(fontWeight: FontWeight.w500, color: KTextColor, fontSize: 14), textAlign: currentLocale == 'ar' ? TextAlign.right : TextAlign.left, decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: KPrimaryColor, width: 2)), contentPadding: const EdgeInsets.all(12)))]); }
  Widget _buildImageButton(String title, IconData icon, Color borderColor, {required VoidCallback onPressed}) { return SizedBox(width: double.infinity, child: OutlinedButton.icon(icon: Icon(icon, color: KTextColor), label: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 16)), onPressed: onPressed, style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), side: BorderSide(color: borderColor), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))))); }
  Widget _buildMapSection(BuildContext context) { final s = S.of(context); return SizedBox(height: 320, width: double.infinity, child: Stack(children: [Positioned.fill(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset('assets/images/map.png', fit: BoxFit.cover))), const Positioned(top: 130, left: 0, right: 0, child: Icon(Icons.location_pin, color: Colors.red, size: 40)), Positioned(bottom: 10, left: 10, right: 10, child: ElevatedButton.icon(icon: const Icon(Icons.location_on_outlined, color: Colors.white, size: 26), label: Text(s.locateMe, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)), onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: KPrimaryColor, minimumSize: const Size(double.infinity, 48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))))])); }
}

// --- Local Widgets (كاملة) ---
// class TitledDescriptionBox extends StatefulWidget { /* ... كامل ... */ }
// class _TitledDescriptionBoxState extends State<TitledDescriptionBox> { /* ... كامل ... */ }
// class TitledSelectOrAddField extends StatelessWidget { /* ... كامل ... */ }
// class _SearchableSelectOrAddBottomSheet extends StatefulWidget { /* ... كامل ... */ }
// class _SearchableSelectOrAddBottomSheetState extends State<_SearchableSelectOrAddBottomSheet> { /* ... كامل ... */ }
// class _SingleSelectBottomSheet extends StatefulWidget { /* ... كامل ... */ }
// class _SingleSelectBottomSheetState extends State<_SingleSelectBottomSheet> { /* ... كامل ... */ }








// import 'dart:io';
// import 'package:advertising_app/presentation/providers/car_sales_ad_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:advertising_app/generated/l10n.dart';

// // الثوابت
// const Color KTextColor = Color.fromRGBO(0, 30, 91, 1);
// const Color KPrimaryColor = Color.fromRGBO(1, 84, 126, 1);

// class CarSalesAdScreen extends StatefulWidget {
//   final Function(Locale) onLanguageChange;
//   const CarSalesAdScreen({Key? key, required this.onLanguageChange}) : super(key: key);

//   @override
//   State<CarSalesAdScreen> createState() => _CarSalesAdScreenState();
// }

// class _CarSalesAdScreenState extends State<CarSalesAdScreen> {
//   // --- Controllers لحقول الإدخال النصية ---
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _kilometersController = TextEditingController();
//   final TextEditingController _areaController = TextEditingController();

//   // --- متغيرات الحالة لحفظ الاختيارات ---
//   String? selectedMake; String? selectedModel; String? selectedTrim; String? selectedYear;
//   String? selectedSpec; String? selectedCarType; String? selectedTransType;
//   String? selectedFuelType; String? selectedColor; String? selectedInteriorColor;
//   String? selectedWarrantyValue; // متغير نصي للضمان "Yes" / "No"
//   String? selectedEngineCap; String? selectedCylinder; String? selectedHorsePower;
//   String? selectedDoor; String? selectedSeat; String? selectedSteeringSide;
//   String? selectedEmirate; String? selectedAdvertiserType;
//   String? selectedAdvertiserName; String? selectedPhoneNumber; String? selectedWhatsAppNumber;
  
//   // --- متغيرات الحالة للصور ---
//   File? _mainImage;
//   final List<File> _thumbnailImages = [];
//   final ImagePicker _picker = ImagePicker();

//   @override
//   void dispose() {
//     _titleController.dispose(); _descriptionController.dispose(); _priceController.dispose();
//     _kilometersController.dispose(); _areaController.dispose();
//     super.dispose();
//   }
  
//   Future<void> _pickMainImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
//     if (image != null) setState(() => _mainImage = File(image.path));
//   }

//   Future<void> _pickThumbnailImages() async {
//     const int maxImages = 14;
//     final int remainingSlots = maxImages - _thumbnailImages.length;
//     if (remainingSlots <= 0) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You have already added the maximum of 14 images.')));
//       return;
//     }
//     final List<XFile> pickedImages = await _picker.pickMultiImage(imageQuality: 85);
//     if (pickedImages.isNotEmpty) {
//       int addedCount = 0;
//       for (var img in pickedImages) {
//         if (_thumbnailImages.length < maxImages) {
//           _thumbnailImages.add(File(img.path));
//           addedCount++;
//         }
//       }
//       setState(() {});
//       if (addedCount < pickedImages.length) {
//          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image limit reached. Only ${addedCount} of ${pickedImages.length} images were added.')));
//       }
//     }
//   }

//   Future<void> _submitAd() async {
//     final s = S.of(context);
//     List<String> validationErrors = [];
//     if (_titleController.text.trim().isEmpty) validationErrors.add(s.title);
//     if (_descriptionController.text.trim().isEmpty) validationErrors.add(s.describeYourCar);
//     if (selectedMake == null) validationErrors.add(s.make);
//     if (selectedModel == null) validationErrors.add(s.model);
//     if (selectedYear == null) validationErrors.add(s.year);
//     if (_kilometersController.text.trim().isEmpty) validationErrors.add(s.km);
//     if (_priceController.text.trim().isEmpty) validationErrors.add(s.price);
//     if (selectedTransType == null) validationErrors.add(s.transType);
//     if (selectedPhoneNumber == null) validationErrors.add(s.phoneNumber);
//     if (selectedEmirate == null) validationErrors.add(s.emirate);
//     if (_areaController.text.trim().isEmpty) validationErrors.add(s.area);
//     if (selectedAdvertiserName == null) validationErrors.add(s.advertiserName);
//     if (selectedAdvertiserType == null) validationErrors.add(s.advertiserType);
//     if (_mainImage == null) validationErrors.add("Main Image");
    
//     if (validationErrors.isNotEmpty) {
//       String errorMessage = "Please complete the required fields: ${validationErrors.join(', ')}.";
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage), backgroundColor: Colors.orange));
//       return;
//     }
    
//     final provider = context.read<CarAdProvider>();
//     final bool warrantyToSend = selectedWarrantyValue == 'Yes';
    
//     final success = await provider.submitCarAd(
//       title: _titleController.text, description: _descriptionController.text, make: selectedMake!,
//       model: selectedModel!, trim: selectedTrim, year: selectedYear!, km: _kilometersController.text,
//       price: _priceController.text, specs: selectedSpec, carType: selectedCarType,
//       transType: selectedTransType!, fuelType: selectedFuelType, color: selectedColor,
//       interiorColor: selectedInteriorColor, warranty: warrantyToSend,
//       engineCapacity: selectedEngineCap, cylinders: selectedCylinder, horsepower: selectedHorsePower,
//       doorsNo: selectedDoor, seatsNo: selectedSeat, steeringSide: selectedSteeringSide,
//       advertiserName: selectedAdvertiserName!, phoneNumber: selectedPhoneNumber!,
//       whatsapp: selectedWhatsAppNumber, emirate: selectedEmirate!, area: _areaController.text,
//       advertiserType: selectedAdvertiserType!, mainImage: _mainImage!, thumbnailImages: _thumbnailImages,
//     );
    
//     if(!mounted) return;
//     if(success) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ad posted successfully!"), backgroundColor: Colors.green));
//       context.pop();
//     } else {
//        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.errorMessage ?? "Failed to post ad."), backgroundColor: Colors.red));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//     final currentLocale = Localizations.localeOf(context).languageCode;
//     final Color borderColor = const Color.fromRGBO(8, 194, 201, 1);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 25.h),
//             GestureDetector(
//               onTap: () => context.pop(),
//               child: Row(
//                 children: [
//                   const SizedBox(width: 5),
//                   Icon(Icons.arrow_back_ios, color: KTextColor, size: 20.sp),
//                   Transform.translate(
//                     offset: Offset(-3.w, 0),
//                     child: Text(s.back, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: KTextColor)),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 7.h),
//             Center(child: Text(s.appTitle, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24.sp, color: KTextColor))),
//             SizedBox(height: 8.h),
//               _buildSingleSelectField(context, s.make, selectedMake, ['Toyota', 'BMW', 'Mercedes'], (v) => setState(() => selectedMake = v)),
            
//             const SizedBox(height: 7),
//             _buildFormRow([
//               _buildSingleSelectField(context, s.model, selectedModel, ['Camry', 'X5', 'C-Class'], (v) => setState(() => selectedModel = v)),
//              _buildSingleSelectField(context, s.trim, selectedTrim, ['GLX', 'Sport', 'AMG'], (v) => setState(() => selectedTrim = v)),
            
//             ]),
//             const SizedBox(height: 7),
//             _buildFormRow([
//                _buildSingleSelectField(context, s.year, selectedYear, ['2023', '2022', '2021', '2020'], (v) => setState(() => selectedYear = v)),
//                  _buildTitledTextFormField(s.km, _kilometersController, borderColor, currentLocale, isNumber: true),
           
//             ]),
//             const SizedBox(height: 7),
//             _buildFormRow([
//                _buildTitledTextFormField(s.price, _priceController, borderColor, currentLocale, isNumber: true),
//                _buildSingleSelectField(context, s.specs, selectedSpec, ['GCC', 'Japanese', 'American'], (v) => setState(() => selectedSpec = v)),
             
//             ]),
//             const SizedBox(height: 7),
           
//              _buildTitledTextFormField(s.title, _titleController, borderColor, currentLocale),
           
//             const SizedBox(height: 7),
//             _buildFormRow([
//               _buildSingleSelectField(context, s.carType, selectedCarType, ['SUV', 'Sedan', 'Hatchback'], (v) => setState(() => selectedCarType = v)),
          
//               _buildSingleSelectField(context, s.transType, selectedTransType, ['Automatic', 'Manual'], (v) => setState(() => selectedTransType = v)),
//               _buildSingleSelectField(context, s.fuelType, selectedFuelType, ['Petrol', 'Diesel', 'Electric'], (v) => setState(() => selectedFuelType = v)),
//             ]),
//             const SizedBox(height: 7),
//             _buildFormRow([
//               _buildSingleSelectField(context, s.color, selectedColor, ['White', 'Black', 'Silver'], (v) => setState(() => selectedColor = v)),
//               _buildSingleSelectField(context, s.interiorColor, selectedInteriorColor, ['Beige', 'Black', 'Red'], (v) => setState(() => selectedInteriorColor = v)),
//               // --- هنا تم استبدال الـ Switch بحقل اختيار عادي ---
//               _buildSingleSelectField(context, s.warranty, selectedWarrantyValue, ['Yes', 'No'], (selection) => setState(() => selectedWarrantyValue = selection)),
//             ]),
//             const SizedBox(height: 15),
//             _buildFormRow([
//               _buildSingleSelectField(context, s.engineCapacity, selectedEngineCap, ['2500', '3500', '5000'], (v) => setState(() => selectedEngineCap = v), titleFontSize: 12.5),
//               _buildSingleSelectField(context, s.cylinders, selectedCylinder, ['4', '6', '8'], (v) => setState(() => selectedCylinder = v)),
//               _buildSingleSelectField(context, s.horse_power, selectedHorsePower, ['178', '300', '450'], (v) => setState(() => selectedHorsePower = v)),
//             ]),
//             const SizedBox(height: 7),
//             _buildFormRow([
//               _buildSingleSelectField(context, s.doorsNo, selectedDoor, ['2', '3', '4', '5'], (v) => setState(() => selectedDoor = v)),
//               _buildSingleSelectField(context, s.seatsNo, selectedSeat, ['2', '4', '5', '7'], (v) => setState(() => selectedSeat = v)),
//               _buildSingleSelectField(context, s.steeringSide, selectedSteeringSide, ['Left', 'Right'], (v) => setState(() => selectedSteeringSide = v)),
//             ]),
//             const SizedBox(height: 7),
//             TitledSelectOrAddField(
//               title: s.advertiserName, value: selectedAdvertiserName, 
//               items: ['Ahmed Ali', 'CarDealer UAE'], onChanged: (v) => setState(() => selectedAdvertiserName = v),
//             ),
//             const SizedBox(height: 7),
//             _buildFormRow([
//               TitledSelectOrAddField(title: s.phoneNumber, value: selectedPhoneNumber, isNumeric: true, items: ['+971501234567'], onChanged: (v) => setState(() => selectedPhoneNumber = v)),
//               TitledSelectOrAddField(title: s.whatsApp, value: selectedWhatsAppNumber, isNumeric: true, items: ['+971501234567'], onChanged: (v) => setState(() => selectedWhatsAppNumber = v)),
//             ]),
//             const SizedBox(height: 7),
//             _buildFormRow([
//               _buildSingleSelectField(context, s.emirate, selectedEmirate, ['Dubai', 'Abu Dhabi', 'Sharjah'], (v) => setState(() => selectedEmirate = v)),
//               _buildSingleSelectField(context, s.advertiserType, selectedAdvertiserType, ['Individual', 'Dealer'], (v) => setState(() => selectedAdvertiserType = v)),
//             ]),
//             const SizedBox(height: 7),
//             _buildTitledTextFormField(s.area, _areaController, borderColor, currentLocale),
//             const SizedBox(height: 7),
//             TitledDescriptionBox(title: s.describeYourCar, controller: _descriptionController, borderColor: borderColor),
//             const SizedBox(height: 10),
//             _buildImageButton(s.addMainImage, Icons.add_a_photo_outlined, borderColor, onPressed: _pickMainImage),
//             if(_mainImage != null)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Center(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.file(_mainImage!, height: 150, fit: BoxFit.cover))),
//               ),
//             const SizedBox(height: 7),
//             _buildImageButton('${s.add14Images} (${_thumbnailImages.length}/14)', Icons.add_photo_alternate_outlined, borderColor, onPressed: _pickThumbnailImages),
//             if(_thumbnailImages.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Wrap(spacing: 8, runSpacing: 8, children: _thumbnailImages.map((img) => ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.file(img, width: 80, height: 80, fit: BoxFit.cover))).toList()),
//               ),
//             const SizedBox(height: 10),
//             Text(s.location, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp, color: KTextColor)),
//             SizedBox(height: 4.h),
//             Directionality(textDirection: TextDirection.ltr, child: Row(children: [ SvgPicture.asset('assets/icons/locationicon.svg', width: 20.w, height: 20.h), SizedBox(width: 8.w), Expanded(child: Text('Dubai souq alharaj', style: TextStyle(fontSize: 14.sp, color: KTextColor, fontWeight: FontWeight.w500))) ])),
//             SizedBox(height: 8.h),
//             _buildMapSection(context),
//             const SizedBox(height: 10),
//             SizedBox(
//               width: double.infinity,
//               child: Consumer<CarAdProvider>(
//                 builder: (context, provider, child) {
//                   return provider.isLoading
//                       ? const Center(child: CircularProgressIndicator())
//                       : ElevatedButton(
//                           onPressed: _submitAd,
//                           style: ElevatedButton.styleFrom(backgroundColor: KPrimaryColor, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//                           child: Text(s.next, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
//                         );
//                 },
//               ),
//             ),
//              SizedBox(height: 20.h),
//           ],
//         ),
//       ),
//     );
//   }
  
//   Widget _buildFormRow(List<Widget> children) { return Row(crossAxisAlignment: CrossAxisAlignment.start, children: children.map((child) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4.0), child: child))).toList()); }



//   // --- ابحث عن هذه الدالة في ملف CarSalesAdScreen.dart ---
Widget _buildTitledTextFormField(
    String title, 
    TextEditingController controller, 
    Color borderColor, 
    String currentLocale, 
    {bool isNumber = false}
) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 14)), 
      const SizedBox(height: 4),
      SizedBox(
        height: 48,
        child: TextFormField(
            controller: controller,
            style: const TextStyle(fontWeight: FontWeight.w500, color: KTextColor, fontSize: 12),
            textAlign: currentLocale == 'ar' ? TextAlign.right : TextAlign.left,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              // --- هذا هو السطر الوحيد الذي قمنا بتغييره ---
              hintText: "Enter the value", // أو يمكنك استخدام s.enterValue من ملفات الترجمة
              
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: KPrimaryColor, width: 2)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), 
              fillColor: Colors.white, 
              filled: true
            ),
        ),
      )
    ]);
  }
  
  Widget _buildSingleSelectField(BuildContext context, String title, String? selectedValue, List<String> allItems, Function(String?) onConfirm, {double? titleFontSize}) {
    final s = S.of(context); String displayText = selectedValue ?? s.chooseAnOption;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: titleFontSize ?? 14)), const SizedBox(height: 4),
        GestureDetector(
          onTap: () async {
            final result = await _showSingleSelectPicker(context, title: title, items: allItems);
            if(result != null) onConfirm(result);
          },
          child: Container(
            height: 48, width: double.infinity, padding: const EdgeInsets.symmetric(horizontal: 16), alignment: Alignment.centerLeft,
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color.fromRGBO(8, 194, 201, 1)), borderRadius: BorderRadius.circular(8)),
            child: Text(
              displayText, style: TextStyle(fontWeight: selectedValue == null ? FontWeight.normal : FontWeight.w500, color: selectedValue == null ? Colors.grey.shade500 : KTextColor, fontSize: 12),
              overflow: TextOverflow.ellipsis, maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
  Future<String?> _showSingleSelectPicker(BuildContext context, { required String title, required List<String> items}) { return showModalBottomSheet<String>(context: context, backgroundColor: Colors.white, isScrollControlled: true, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), builder: (context) => _SingleSelectBottomSheet(title: title, items: items)); }
  Widget _buildTitleBox(BuildContext context, String title, TextEditingController controller, Color borderColor, String currentLocale) {
     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 14)), const SizedBox(height: 4),
      TextFormField(
        controller: controller, maxLines: null, minLines: 2,
        style: const TextStyle(fontWeight: FontWeight.w500, color: KTextColor, fontSize: 14), textAlign: currentLocale == 'ar' ? TextAlign.right : TextAlign.left,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: KPrimaryColor, width: 2)),
          contentPadding: const EdgeInsets.all(12),
        ),
      ),
    ]);
  }
  Widget _buildImageButton(String title, IconData icon, Color borderColor, {required VoidCallback onPressed}) { return SizedBox(width: double.infinity, child: OutlinedButton.icon(icon: Icon(icon, color: KTextColor), label: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 16)), onPressed: onPressed, style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), side: BorderSide(color: borderColor), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))))); }
  Widget _buildMapSection(BuildContext context) {
    final s = S.of(context);
    return SizedBox(
      height: 320, width: double.infinity,
      child: Stack(children: [
        Positioned.fill(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset('assets/images/map.png', fit: BoxFit.cover))),
        const Positioned(top: 130, left: 0, right: 0, child: Icon(Icons.location_pin, color: Colors.red, size: 40)),
        Positioned(bottom: 10, left: 10, right: 10,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.location_on_outlined, color: Colors.white, size: 26),
            label: Text(s.locateMe, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: KPrimaryColor, minimumSize: const Size(double.infinity, 48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          ),
        )
      ]),
    );
  }

// --- Widgets محلية كاملة ---
class TitledDescriptionBox extends StatefulWidget {
  final String title; final TextEditingController controller; final Color borderColor;
  const TitledDescriptionBox({Key? key, required this.title, required this.controller, required this.borderColor}) : super(key: key);
  @override
  State<TitledDescriptionBox> createState() => _TitledDescriptionBoxState();
}
class _TitledDescriptionBoxState extends State<TitledDescriptionBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 14)), const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: widget.borderColor)),
          child: Column(
            children: [
              TextFormField(
                controller: widget.controller, maxLines: 5, minLines: 3, maxLength: 5000,
                style: const TextStyle(fontWeight: FontWeight.w500, color: KTextColor, fontSize: 14),
                decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(12), counterText: ""),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ListenableBuilder(
                    listenable: widget.controller,
                    builder: (context, child) => Text('${widget.controller.text.length}/5000', style: const TextStyle(color: Colors.grey, fontSize: 12), textDirection: TextDirection.ltr),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class TitledSelectOrAddField extends StatelessWidget {
  final String title; final String? value; final List<String> items; final Function(String) onChanged; final bool isNumeric;
  const TitledSelectOrAddField({ Key? key, required this.title, required this.value, required this.items, required this.onChanged, this.isNumeric = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final borderColor = const Color.fromRGBO(8, 194, 201, 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: KTextColor, fontSize: 14)), const SizedBox(height: 4),
        GestureDetector(
          onTap: () async {
            final result = await showModalBottomSheet<String>(
              context: context, backgroundColor: Colors.white, isScrollControlled: true, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
              builder: (_) => _SearchableSelectOrAddBottomSheet(title: title, items: items, isNumeric: isNumeric),
            );
            if(result != null && result.isNotEmpty){ onChanged(result); }
          },
          child: Container(
            height: 48, padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [ Expanded(child: Text(value ?? s.chooseAnOption, style: TextStyle(fontWeight: value == null ? FontWeight.normal : FontWeight.w500, color: value == null ? Colors.grey.shade500 : KTextColor, fontSize: 12), overflow: TextOverflow.ellipsis))],
            ),
          ),
        )
      ],
    );
  }
}

class _SearchableSelectOrAddBottomSheet extends StatefulWidget {
  final String title; final List<String> items; final bool isNumeric;
  const _SearchableSelectOrAddBottomSheet({required this.title, required this.items, this.isNumeric = false});
  @override
  _SearchableSelectOrAddBottomSheetState createState() => _SearchableSelectOrAddBottomSheetState();
}
class _SearchableSelectOrAddBottomSheetState extends State<_SearchableSelectOrAddBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _addController = TextEditingController();
  List<String> _filteredItems = [];

  @override
  void initState() { super.initState(); _filteredItems = List.from(widget.items); _searchController.addListener(_filterItems); }
  @override
  void dispose() { _searchController.dispose(); _addController.dispose(); super.dispose(); }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() => _filteredItems = widget.items.where((i) => i.toLowerCase().contains(query)).toList());
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final borderColor = const Color.fromRGBO(8, 194, 201, 1);
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
              controller: _searchController, style: const TextStyle(color: KTextColor),
              decoration: InputDecoration(
                hintText: s.search, prefixIcon: const Icon(Icons.search, color: KTextColor),
                hintStyle: TextStyle(color: KTextColor.withOpacity(0.5)),
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
                        return ListTile(title: Text(item, style: const TextStyle(color: KTextColor)), onTap: () => Navigator.pop(context, item));
                      },
                    ),
            ),
            const Divider(), const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _addController, keyboardType: widget.isNumeric ? TextInputType.number : TextInputType.text,
                    style: const TextStyle(fontWeight: FontWeight.w500, color: KTextColor, fontSize: 12),
                    decoration: InputDecoration(
                      hintText: s.addNew,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: borderColor)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: KPrimaryColor, width: 2)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () { if (_addController.text.isNotEmpty) Navigator.pop(context, _addController.text); },
                  style: ElevatedButton.styleFrom(backgroundColor: KPrimaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
                  child: Text(s.add, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

class _SingleSelectBottomSheet extends StatefulWidget {
  final String title; final List<String> items;
  const _SingleSelectBottomSheet({required this.title, required this.items});
  @override
  _SingleSelectBottomSheetState createState() => _SingleSelectBottomSheetState();
}
class _SingleSelectBottomSheetState extends State<_SingleSelectBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredItems = [];

  @override
  void initState() { super.initState(); _filteredItems = List.from(widget.items); _searchController.addListener(_filterItems); }
  @override
  void dispose() { _searchController.dispose(); super.dispose(); }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() => _filteredItems = widget.items.where((item) => item.toLowerCase().contains(query)).toList());
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final borderColor = const Color.fromRGBO(8, 194, 201, 1);
    
    return Padding(
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
                      return ListTile(title: Text(item, style: const TextStyle(color: KTextColor)), onTap: () => Navigator.pop(context, item));
                    },
                  ),
            ),
             const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}