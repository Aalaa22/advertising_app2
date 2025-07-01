import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final bool isPassword;
  final TextDirection? textDirection;

  const CustomTextField({
    this.hintText,
    this.isPassword = false,
    this.textDirection,
    super.key,
    IconButton? suffixicon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.06;

    return Container(
      height: height,
      child: TextField(
        obscureText: widget.isPassword ? _obscureText : false,
        textDirection: widget.textDirection,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric( horizontal: 16),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Color.fromRGBO(129, 126, 126, 1),
            fontSize: 14,
            fontWeight: FontWeight.w500
            
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Color.fromRGBO(8, 194, 201, 1), // لون العين
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(8, 194, 201, 1)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(8, 194, 201, 1)),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(8, 194, 201, 1)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
