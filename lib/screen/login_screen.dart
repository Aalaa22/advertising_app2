import 'package:advertising_app/constants.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_elevated_button.dart';
import 'package:advertising_app/widget/custom_phone_field.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ListView(
            children: [
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'English',
                    style: TextStyle(
                        color: KTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                  ),
                  Text(
                    'عربي',
                    style: TextStyle(
                        color: KTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                  )
                ],
              ),
              Image.asset(
                'images/logo.png',
                height: 150,
                width: 150,
              ),
              Text(
                'Log In',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: KTextColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Phone',
                style: TextStyle(
                    color: KTextColor,
                    // height: 36,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              CustomPhoneField(),
              Text(
                'Password',
                style: TextStyle(
                    color: KTextColor,
                    // height: 36,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              CustomTextField(
                hintText: '652454465',
                suffixicon: IconButton(
                  icon: Icon(
                    Icons.visibility_off,
                    color: KTextColor,
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                text: "Log In",
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  context.go('/passphonelogin');
                },
                child: Text(
                  "Forgot Password?",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    decoration: TextDecoration.underline,
                    //  decorationColor: KTextColor, // لون الخط تحت النص
                    decorationThickness: 1.5,
                    color: KTextColor,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: KTextColor,
                      thickness: 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Or",
                      style: TextStyle(
                          color: KTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: KTextColor,
                      thickness: 2,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    onpress: () {
                      context.go('/emaillogin');
                    },
                    text: 'Email Login',
                  ),
                  SizedBox(
                    width: 22,
                  ),
                  CustomElevatedButton(
                    onpress: () {},
                    text: 'Guest Login',
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have An Account? ",
                    style: TextStyle(
                        color: KTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go('/signup');
                    },
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: KTextColor, // لون الخط
                          decorationThickness: 1.5, // سُمك الخط
                          color: KTextColor, // لون النص
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                ],
              ),
              Spacer(
                flex: 2,
              )
            ],
          ),
        ));
  }
}
