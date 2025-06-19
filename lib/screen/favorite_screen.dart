import 'package:advertising_app/constants.dart';
import 'package:advertising_app/data/dummy_data.dart';
import 'package:advertising_app/model/favorite_item_interface_model.dart';
import 'package:advertising_app/widget/custom_bottom_nav.dart';
import 'package:advertising_app/widget/custom_card.dart';
import 'package:advertising_app/widget/custom_category.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final List<String> categories = [
    'Car Sales',
    'Real Estate',
    'electronics & home appliances',
    'Jobs',
    'Car Rent',
    'cars services',
    'restaurants',
    'other services'
  ];
  int selectedCategory = 0;

  late final List<List<FavoriteItemInterface>> allData;

  @override
  void initState() {
    super.initState();
    allData = [
      dummyCarSales, // List<CarSalesModel>
      dummyRealEstate, // List<RealEstateModel>
    ];
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems = allData[selectedCategory];

    return Scaffold(
      bottomNavigationBar: CustomBottomNav(currentIndex: 1),
      appBar: AppBar(
        title: Center(
          child: Text(
            'Favorite',
            style: TextStyle(
                color: KTextColor,
                 fontWeight: FontWeight.bold,
                  fontSize: 32),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          CustomCategory(
            categories: categories,
            selectedIndex: selectedCategory,
            onCategorySelected: (index) {
              setState(() {
                selectedCategory = index;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                final item = selectedItems[index];
                return FavoriteCard(item: item,
                 onDelete: () {
          setState(() {
            selectedItems.removeAt(index);
          });
        },);
              },
            ),
          ),
        ],
      ),
    );
  }
}



