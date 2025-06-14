import 'package:flutter/material.dart';
import 'package:advertising_app/constants.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_elevated_button.dart';
import 'package:advertising_app/widget/custom_text_field.dart';
import 'package:go_router/go_router.dart';

class EmailSignup extends StatefulWidget {
  const EmailSignup({super.key});

  @override
  State<EmailSignup> createState() => _EmailSignupState();
}

class _EmailSignupState extends State<EmailSignup> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
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
                const SizedBox(height: 10),
                Image.asset(
                  'images/logo.png',
                  height: 150,
                  width: 150,
                ),
                //const SizedBox(height: 3),
                const Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: KTextColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 7),
                const Text(
                  'User Name',
                  style: TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                CustomTextField(hintText: 'Ralf Edwards'),
                const SizedBox(height: 5),
                Text(
                  'Email',
                  style: TextStyle(
                      color: KTextColor,
                      // height: 36,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                CustomTextField(
                  hintText: 'yourName@Example.com',
                ),
                const Text(
                  'Password',
                  style: TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
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
                const SizedBox(height: 5),
                const Text(
                  'Referal Code',
                  style: TextStyle(
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                CustomTextField(hintText: 'xxxxx'),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      activeColor: Color.fromRGBO(1, 84, 126, 1),
                      checkColor: Colors.white,
                    ),
                    const Text(
                      "I agree terms & conditions",
                      style: TextStyle(
                          fontSize: 18,
                          color: KTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                CustomButton(text: "Register"),
                const SizedBox(height: 4),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Text(
                      "Or",
                      style: TextStyle(
                          color: KTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                      onpress: () {
                        context.go('/signup');
                      },
                      text: 'Phone Sign Up',
                    ),
                    const SizedBox(width: 16),
                    CustomElevatedButton(
                      onpress: () {},
                      text: 'Guest Login',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already Have An Account? ",
                      style: TextStyle(
                          color: KTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go('/login');
                      },
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: KTextColor,
                            decorationThickness: 1.5,
                            color: KTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
