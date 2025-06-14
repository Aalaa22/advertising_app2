import 'dart:async';
import 'package:advertising_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashGridScreen extends StatefulWidget {
  @override
  _SplashGridScreenState createState() => _SplashGridScreenState();
}

class _SplashGridScreenState extends State<SplashGridScreen> {
  int _visibleCount = 0;
  late Timer _timer;

  final List<Map<String, String>> items = [
    {"title": "Cars Sales", "image": "images/salesCar.jpg"},
    {"title": "Real Estate", "image": "images/realEstate.jpg"},
    {"title": "Cars Rent", "image": "images/careRent.jpg"},
    {"title": "Cars Services", "image": "images/car_services.png"},
    {
      "title": "Electronics & home appliances",
      "image": "images/electronics.jpg"
    },
    {"title": "Restaurants", "image": "images/restaurant.jpg"},
    {"title": "Jobs", "image": "images/jobs.jpg"},
    {"title": "Other Services", "image": "images/service.jpg"},
  ];

  @override
  void initState() {
    super.initState();
    _startRevealing();
  }

  void _startRevealing() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_visibleCount < items.length) {
        setState(() {
          _visibleCount++;
        });
      } else {
        _timer.cancel();
        Future.delayed(Duration(seconds: 2), () {
          context.go('/signup');
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/logo.png',
                    height: 100,
                    width: 100,
                  ),
                  // SizedBox(width:4),
                  Text(
                    "Enjoy Free Ads",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: KTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: List.generate(_visibleCount, (index) {
                    final item = items[index];
                    return SplashItem(
                        title: item['title']!, image: item['image']!);
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SplashItem extends StatelessWidget {
  final String title;
  final String image;

  const SplashItem({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 150,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 150,
              width: 400,
              child: Expanded(child: Image.asset(image, fit: BoxFit.fitWidth)),
            ),
          ),
          //  SizedBox(height: 1),
          Text(title,
              style: TextStyle(
                  fontSize: 14, color: KTextColor, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
