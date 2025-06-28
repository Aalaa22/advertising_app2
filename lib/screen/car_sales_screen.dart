import 'package:advertising_app/constants.dart';
import 'package:advertising_app/data/dummy_data.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/model/ad_priority.dart';
import 'package:advertising_app/screen/car_details_screen.dart';
import 'package:advertising_app/widget/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CarSalesScreen extends StatefulWidget {
  const CarSalesScreen({super.key});

  @override
  State<CarSalesScreen> createState() => _CarSalesScreenState();
}

class _CarSalesScreenState extends State<CarSalesScreen> {
  @override
  Widget build(BuildContext context) {
   final sortedCars = [...dummyCarSales]..sort(
        (a, b) => a.priority.index.compareTo(b.priority.index),
      );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () => context.pop(),
              child: Row(
                children: [
                  const SizedBox(width: 18),
                  const Icon(Icons.arrow_back_ios, color: KTextColor),
                  Text(
                    S.of(context).back,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: KTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7),
           Center(
              child: Text(
                S.of(context).carsales,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: KTextColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 SvgPicture.asset(
                    'assets/icons/filter.svg',
                    width: 22,
                    height: 24,
                    //color: Color(0xFF01547E),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      // runSpacing: 8,
                      children: [
                        _buildFilterChip('Trim'),
                        _buildFilterChip('Year'),
                        _buildFilterChip('Km'),
                        _buildFilterChip('Price'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                // عدد الإعلانات
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'ADS NO: 1000',
                    style: TextStyle(
                      fontSize: 9,
                      color: KTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                //const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF08C2C9)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 0),
                        SvgPicture.asset(
                          'assets/icons/locationicon.svg',
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            'Sort By The Nearest',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: KTextColor,
                                fontSize: 10),
                          ),
                        ),
                        // const SizedBox(width: 3),
                        Transform.scale(
                          scale: 0.75,                           child: Switch(
                            value: true,
                            activeColor: Colors.white,
                            activeTrackColor: Color(0xFF08C2C9),
                            onChanged: (val) {},
                            materialTapTargetSize: MaterialTapTargetSize
                                .shrinkWrap,                           ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // عرض الكروت
            Expanded(
              child: ListView.builder(
                itemCount: sortedCars.length,
                itemBuilder: (context, index) {
                  final item = sortedCars[index];
                  return GestureDetector(
                    onTap: () {
                      context.push('/car-details', extra: item);
                    },
                    child: FavoriteCard(
                      item: item,
                      showDelete: false,
                      onDelete: () {
                        setState(() {
                          dummyCarSales.remove(item);
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

  Widget _buildFilterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF08C2C9)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: KTextColor,
              ),
            ),
            const SizedBox(width: 7),
            const Icon(Icons.keyboard_arrow_down, color: KTextColor, size: 18),
          ],
        ),
      ),
    );
  }
}

