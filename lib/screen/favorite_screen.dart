import 'package:advertising_app/constants.dart';
import 'package:advertising_app/data/dummy_data.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/model/favorite_item_interface_model.dart';
import 'package:advertising_app/widget/custom_bottom_nav.dart';
import 'package:advertising_app/widget/custom_card.dart';
import 'package:advertising_app/widget/custom_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int selectedCategory = 0;

  late final List<List<FavoriteItemInterface>> allData;

  @override
  void initState() {
    super.initState();
    allData = [
      dummyCarSales,
      dummyRealEstate,
      dummyRealEstate,
      dummyRealEstate,
      dummyRealEstate,
      dummyRealEstate,
      dummyRealEstate,
      dummyRealEstate,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';

    final List<String> categories = [
      S.of(context).carsales,
      S.of(context).realestate,
      S.of(context).electronics,
      S.of(context).jobs,
      S.of(context).carrent,
      S.of(context).carservices,
      S.of(context).restaurants,
      S.of(context).otherservices
    ];

    final selectedItems = allData[selectedCategory];

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: CustomBottomNav(currentIndex: 1),
        appBar: AppBar(
          title: Text(
            S.of(context).favorites,
            style: TextStyle(
              color: KTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10 ),
              child: CustomCategoryGrid(
                categories: categories,
                selectedIndex: selectedCategory,
                onTap: (index) {
                  setState(() {
                    selectedCategory = index;
                  });
                },
              ),
            ),

            //  CustomCategory(
            //     categories: categories,
            //     selectedIndex: selectedCategory,
            //     onCategorySelected: (index) {
            //       setState(() {
            //         selectedCategory = index;
            //       });
            //     },
            //   ),

            Expanded(
              child: selectedItems.isEmpty
                  ? Center(
                      child: Text(
                        'No items found.',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18.sp,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 10),
                      itemCount: selectedItems.length,
                      itemBuilder: (context, index) {
                        final item = selectedItems[index];
                        return Directionality(
                          textDirection: TextDirection.ltr,
                          child: FavoriteCard(
                            item: item,
                            onDelete: () {
                              setState(() {
                                selectedItems.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
