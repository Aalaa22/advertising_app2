import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  CustomTextField({this.hintText,this.suffixicon, bool? isPassword});

  String? hintText;
 // final bool? obscureText;
  final Widget? suffixicon;
  @override
  Widget build(BuildContext context) {
    return TextField(
     // obscureText:obscureText!,
      decoration: InputDecoration(
        suffixIcon: suffixicon,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
        color: Color.fromRGBO(8, 194, 201, 1),),
        borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide( color:Color.fromRGBO(8, 194, 201, 1))),   
        border: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(8, 194, 201, 1)),borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
