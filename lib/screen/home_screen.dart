import 'package:advertising_app/constants.dart';
import 'package:advertising_app/data/top_dealer_dummy_data.dart';
import 'package:advertising_app/model/favorite_item_interface_model.dart';
import 'package:advertising_app/widget/custom_bottom_nav.dart';
import 'package:advertising_app/widget/custom_button.dart';
import 'package:advertising_app/widget/custom_category.dart';
import 'package:advertising_app/widget/custom_dealer_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categoryList = [
    'Car Sales',
    'Real Estate',
    'Electronics & Home \n Appliances',
    'Jobs',
    'Car Rent',
    'Car Services',
    'Restaurants',
    'Other Services'
  ];

  final Map<String, String> categoryRoutes = {
    'Car Sales': '/cars-sales',
    'Real Estate': '/real-estate',
    'Electronics & Home': '/electronics',
    'Jobs': '/jobs',
    'Cars Rent': '/cars-rent',
    'Cars Services': '/cars-services',
    'Restaurants': '/restaurants',
    'Other Services': '/other-services',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNav(currentIndex: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            // 🔍 حقل البحث + الجرس
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Smart Search',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color.fromRGBO(8, 194, 201, 1),
                          size: 32,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(8, 194, 201, 1),
                            //  width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(8, 194, 201, 1),
                            width: 1.5,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),

                  // const SizedBox(width: 1),

                  IconButton(
                    icon: Icon(
                      Icons.notifications_none,
                      color: Color.fromRGBO(8, 194, 201, 1),
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            CustomCategory(
              categories: categoryList,
              onCategoryPressed: (selectedCategory) {
                final route = categoryRoutes[selectedCategory];
                if (route != null) {
                  context.push(route);   }
                   else {
                  print('Route not found for $selectedCategory');
                }
              },
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 6),
                      Text("Discover Best Cars Deals",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: KTextColor)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildDropdown("Choose Make"),
                  const SizedBox(height: 7),
                  _buildDropdown("Choose Model"),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CustomButton(
                      text: "Search",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      height: 98,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFE4F8F6),
                            Color(0xFFC9F8FE),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/cardolar.svg',
                            height: 25,
                            width: 24,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                              child: Text(
                            "Click For Amazing Daily Cars Deals",
                            style: TextStyle(
                                fontSize: 10,
                                color: KTextColor,
                                fontWeight: FontWeight.w500),
                          )),
                          Icon(Icons.arrow_forward_ios,
                              size: 20, color: KTextColor),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 4),
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 4),
                      Text("Top Premium Dealers",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: KTextColor)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(3, (sectionIndex) {
                      return Column(
                      //  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Al Manara Motors",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: KTextColor),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const Text(
                                    "See All Ads",
                                    style: TextStyle(
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          Color.fromRGBO(8, 194, 201, 1),
                                      color: Color.fromRGBO(8, 194, 201, 1),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Scroll أفقي للكروت
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: topPremiumDealerCars.length,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 148,
                                  margin: EdgeInsets.only(right: 12),
                                  child: DealerCarCard(
                                      car: topPremiumDealerCars[index]),
                                );
                              },
                            ),
                          ),

                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color.fromRGBO(8, 194, 201, 1)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonFormField<String>(
          decoration: const InputDecoration(border: InputBorder.none),
          hint: Text(hint),
          style: TextStyle(
              color: Color.fromRGBO(129, 126, 126, 1),
              fontSize: 14,
              fontWeight: FontWeight.w400),
          items: const [],
          onChanged: (value) {},
        ),
      ),
    );
  }
}



