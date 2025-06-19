import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: KTextColor),
                  onPressed: () {
                    context.go('/passphonelogin');
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
            Text(
              S.of(context).resetpass,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: KTextColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              S.of(context).newpass,
              style: TextStyle(
                color: KTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            CustomTextField(
                hintText: '1234567',
                suffixicon: IconButton(
                  icon: Icon(
                    Icons.visibility_off,
                    color: KTextColor,
                  ),
                  onPressed: () {},
                )),
            SizedBox(height: 10),
            Text(
              S.of(context).confirmpass,
              style: TextStyle(
                color: KTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            CustomTextField(
                hintText: '1234567',
                suffixicon: IconButton(
                  icon: Icon(
                    Icons.visibility_off,
                    color: KTextColor,
                  ),
                  onPressed: () {},
                )),
            SizedBox(height: 20),
            CustomButton(
              ontap: () {
                context.go('/login');
              },
              text: S.of(context).confirm,
            ),
      
          ],
        ),
      ),
    );
  }
}
