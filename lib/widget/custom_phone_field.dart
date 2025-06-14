import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneField extends StatefulWidget {
  const CustomPhoneField({super.key,});

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color:Color.fromRGBO(8, 194, 201, 1),),borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(8, 194, 201, 1)),borderRadius: BorderRadius.circular(10)
    ),

    
              ),
              initialCountryCode: 'AE', // الإمارات
              onChanged: (phone) {
                print(phone.completeNumber); // رقم كامل مع كود الدولة
              },
            );
  }
}