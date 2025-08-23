import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart'; // استيراد ضروري للـ PickerDialogStyle
import 'package:advertising_app/constant/string.dart';
import 'package:advertising_app/generated/l10n.dart';

class CustomPhoneField extends StatelessWidget {
  final Function(String)? onCountryChanged;
  final TextEditingController controller;

  const CustomPhoneField({
    super.key,
    this.onCountryChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      initialCountryCode: 'AE',
      style: TextStyle(
        color: KTextColor,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
      ),
      
      decoration: InputDecoration(
        // 1. تم التغيير من labelText إلى hintText
        hintText: S.of(context).phoneNumberHint,
        hintStyle: const TextStyle(color: Color.fromRGBO(129, 126, 126, 1), fontSize: 14, fontWeight: FontWeight.w500),
        
        // منع الـ label من الطفو للأعلى
        floatingLabelBehavior: FloatingLabelBehavior.never,

        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Color.fromRGBO(8, 194, 201, 1)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Color.fromRGBO(8, 194, 201, 1)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Color.fromRGBO(8, 194, 201, 1), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red.shade700, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
        ),
        counterText: '',
      ),

      // 3. تم جعل كود الدولة bold
      dropdownTextStyle: TextStyle(
        color: KTextColor,
        fontSize: 15.sp,
        fontWeight: FontWeight.w700, // أصبح أعرض (Bold)
      ),
      
      // 2. تم تخصيص نافذة البحث لجعل النص أسود
      pickerDialogStyle: PickerDialogStyle(
        // هذا الجزء يضمن ظهور النص الذي تكتبه في البحث باللون الأسود
        searchFieldInputDecoration: InputDecoration(
          labelText: S.of(context).searchCountry,
          labelStyle: const TextStyle(color: KTextColor), // لون النص فوق الحقل
          hintStyle: TextStyle(color: Colors.grey.shade600),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: KTextColor)),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400)),
        ),
        // للتأكيد، نجعل لون اسم الدولة في القائمة أسود
        countryNameStyle: const TextStyle(color: KTextColor),
      ),
      
      onCountryChanged: (country) {
        if (onCountryChanged != null) {
          onCountryChanged!(country.code);
        }
      },
    );
  }
}