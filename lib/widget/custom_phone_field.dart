import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneField extends StatelessWidget {
  final Function(String)? onCountryChanged;

  const CustomPhoneField({this.onCountryChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48, // مساحة كافية للحقل
      child: IntlPhoneField(
        initialCountryCode: 'AE',
        showCountryFlag: true,
        showDropdownIcon: true,
        decoration: InputDecoration(
          labelText: S.of(context).phoneNumberHint,
          labelStyle: const TextStyle(
              color: Color.fromRGBO(129, 126, 126, 1),fontSize: 14,fontWeight: FontWeight.w500), // لون الـ label واضح
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 15), // padding داخلي
          filled: true, // تفعيل الخلفية
          fillColor: Colors.white, // خلفية بيضاء
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
            borderSide: BorderSide(color: Color.fromRGBO(8, 194, 201, 1)),
          ),
          counterStyle:
              const TextStyle(height: 0, fontSize: 0), // إخفاء العداد تمامًا
          counterText: '', // التأكد من إن مفيش نص في العداد
        ),
        style: const TextStyle(
            color: KTextColor, fontSize: 14,fontWeight: FontWeight.w500), // لون الرقم التعريفي أسود
        dropdownTextStyle:
            const TextStyle(color: Colors.black), // لون نص القائمة المنسدلة
        textAlign: TextAlign.start, // محاذاة النص من البداية
        onChanged: (phone) {
          print(phone.completeNumber);
        },
        onCountryChanged: (country) {
          if (onCountryChanged != null) {
            onCountryChanged!(country.code);
          }
        },
      ),
    );
  }
}
