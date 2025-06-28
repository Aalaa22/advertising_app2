import 'package:advertising_app/widget/custom_bottom_nav.dart';
import 'package:flutter/material.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNav(currentIndex: 0),
      
      body: Center(child: Text("تحت الإنشاء",style: TextStyle(fontSize: 50),)),
    );
     
  }
}