import 'package:advertising_app/constants.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({this.text, this.onpress});
  String? text;
  VoidCallback? onpress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpress!,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: KTextColor,
        side: BorderSide(color: Color.fromRGBO(8, 194, 201, 1)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(text!),
    );
  }
}
