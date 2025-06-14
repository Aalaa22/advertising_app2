import 'package:advertising_app/constants.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmailCode extends StatelessWidget {
  const VerifyEmailCode({super.key});
  final String Email = "yourname@example.Com";
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
                children: [
                  IconButton(
                    icon: Icon(
                        Icons
                            .arrow_back_ios,
                        color: KTextColor),
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
                'Verify Your Number',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: KTextColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                "We've sent an Email with an activation code to your Email $Email",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: KTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 24),
              PinCodeTextField(
                length: 4,
                appContext: context,
                onChanged: (value) {},
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 70,
                  fieldWidth: 70,
                  activeFillColor: Colors.white,
                  selectedColor: Colors.blue,
                  activeColor: Color.fromRGBO(8, 194, 201, 1),
                  inactiveColor: Color.fromRGBO(8, 194, 201, 1),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 18),
              CustomButton(
                ontap: () {
                  context.go('/resetpass');
                },
                text: "Verify",
              ),
            ],
          ),
        ));
  }
}
