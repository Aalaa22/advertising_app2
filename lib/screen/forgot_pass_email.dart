import 'package:advertising_app/constants.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPassEmail extends StatelessWidget {
  const ForgotPassEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: KTextColor),
                    onPressed: () {
                      context.go('/login');
                    },
                  ),
                  Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: KTextColor,
                    ),
                  ),
                ],
              ),
              Image.asset(
                'images/logo.png',
                height: 150,
                width: 150,
              ),
              Text(
                'Forgot Your Password?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: KTextColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Enter Your Email',
                style: TextStyle(
                    color: KTextColor,
                    // height: 36,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              CustomTextField(
                hintText: 'yourName@Example.com',
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                ontap: () {
                  context.go('/emailcode');
                },
                text: "Send code",
              ),
            ],
          ),
        ));
  }
}
