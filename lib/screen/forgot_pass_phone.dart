import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPassPhone extends StatefulWidget {
  const ForgotPassPhone({super.key});

  @override
  State<ForgotPassPhone> createState() => _ForgotPassPhoneState();
}

class _ForgotPassPhoneState extends State<ForgotPassPhone> {
  bool showEmailField = false;
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
                      context.go('/');
                    },
                  ),
                  Text(
                    S.of(context).back,
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
              SizedBox(height: 10),
              Text(
                S.of(context).forgetyourpass,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: KTextColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                S.of(context).enterphone,
                style: TextStyle(
                    color: KTextColor,
                    // height: 36,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
             CustomPhoneField(
              onCountryChanged: (code) {
                setState(() {
                  showEmailField = code != 'AE'; 
                });
              },
            ),
            if (showEmailField)
              TextField(
                decoration: InputDecoration(
                  labelText: S.of(context).email,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(8, 194, 201, 1)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                ontap: () {
                  context.go('/phonecode');
                },
                text: S.of(context).sendcode,
              ),
            
            ],
          ),
        ));
  }
}
