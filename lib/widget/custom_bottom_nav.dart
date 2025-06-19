import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {

    
      

    return BottomNavigationBar(
      currentIndex: currentIndex,
      showUnselectedLabels: true, 
      selectedItemColor: Color(0xFF01547E),
      unselectedItemColor:Color.fromRGBO( 0, 195, 188,1),
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/favorite');
            break;
          case 2:
            context.go('/postad');
            break;
          case 3:
            context.go('/manage');
            break;
          case 4:
            context.go('/setting');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorite'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Post Ads'),
        BottomNavigationBarItem(icon: Icon(Icons.folder_open), label: 'Manage'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
