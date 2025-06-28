import 'package:advertising_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneField extends StatelessWidget {
  final Function(String)? onCountryChanged;

  const CustomPhoneField({this.onCountryChanged, super.key});

  @override
  Widget build(BuildContext context) {
     final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.07, // ارتفاع ثابت
      child: IntlPhoneField(
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          labelText: "508236561",
          counterText: '', // ✅ ده اللي يخفي العداد
          labelStyle: TextStyle(
            color: Color.fromRGBO(129, 126, 126, 1),
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(8, 194, 201, 1)),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(8, 194, 201, 1)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        initialCountryCode: 'AE',
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
