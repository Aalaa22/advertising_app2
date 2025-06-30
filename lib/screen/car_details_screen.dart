import 'package:advertising_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:advertising_app/constants.dart';
import 'package:advertising_app/model/car_sale_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CarDetailsScreen extends StatefulWidget {
  final CarSalesModel car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final car = widget.car;
    final size = MediaQuery.of(context).size;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 305,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: car.images.length,
                      onPageChanged: (index) =>
                          setState(() => _currentPage = index),
                      itemBuilder: (context, index) => Image.asset(
                        car.images[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
               
// زر الرجوع
Positioned(
  top: 25,
  left: isArabic ? null : 15,
  right: isArabic ? 15 : null,
  child: GestureDetector(
    onTap: () => context.pop(),
    child: Row(
      children: [
        IconButton(
          icon: Icon(
            isArabic ? Icons.arrow_back_ios : Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          S.of(context).back, // الأفضل استخدام الترجمة هنا
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  ),
),

// ❤️ الأيقونة المفضلة
Positioned(
  top: 40,
  left: isArabic ? 16 : null,
  right: isArabic ? null : 16,
  child: const Icon(
    Icons.favorite_border,
    color: Colors.white,
    size: 30,
  ),
),

                  Positioned(
                    bottom: 12,
                    left: size.width / 2 - (car.images.length * 10 / 2),
                    child: Row(
                      children: List.generate(car.images.length, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Colors.white
                                : Colors.white54,
                          ),
                        );
                      }),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: isArabic ? 16 : null,
                    left: isArabic ? null : 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${_currentPage + 1}/${car.images.length}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/priceicon.svg',
                          width: 24,
                          height: 19,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.car.price,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          widget.car.date,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 10),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.car.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: KTextColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          color: KTextColor,
                        ),
                        children: [
                          const TextSpan(text: 'Year: '),
                          TextSpan(
                            text: '${widget.car.year}   ',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const TextSpan(text: 'Km: '),
                          TextSpan(
                            text: '${widget.car.km}   ',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const TextSpan(text: 'Specs: '),
                          TextSpan(
                            text: widget.car.specs,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.car.details,
                      style: const TextStyle(
                        fontSize: 14,
                        color: KTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/locationicon.svg',
                          width: 20,
                          height: 18,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            widget.car.location,
                            style: const TextStyle(
                              fontSize: 14,
                              color: KTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Color(0xFFB5A9B1), thickness: 1),
                    const Text(
                      "Car Details",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: KTextColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 80,
                        crossAxisSpacing: 20,
                      ),
                      children: [
                        _buildDetailBox("Car Type", widget.car.carType),
                        _buildDetailBox("Trans Type", widget.car.transType),
                        _buildDetailBox("Color", widget.car.color),
                        _buildDetailBox(
                            "Interior Color", widget.car.interiorColor),
                        _buildDetailBox("Fuel Type", widget.car.fuelType),
                        _buildDetailBox("Warranty", widget.car.warranty),
                        _buildDetailBox("Doors No", widget.car.doors.toString()),
                        _buildDetailBox("Seats No", widget.car.seats.toString()),
                        _buildDetailBox(
                            "Engine Capacity", widget.car.engineCapacity),
                        _buildDetailBox(
                            "Cylinders", widget.car.cylinders.toString()),
                        _buildDetailBox("Horse Power", widget.car.horsePower),
                        _buildDetailBox(
                            "Steering Side", widget.car.steeringSide),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Color(0xFFB5A9B1), thickness: 1),
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: KTextColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "20 % Down Payment With Insurance\n Registration And Delivery To \n Client Without Fees",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: KTextColor,
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Divider(color: Color(0xFFB5A9B1), thickness: 1),
                    const Text(
                      "Location",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: KTextColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/locationicon.svg',
                            width: 20, height: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.car.location,
                            style: const TextStyle(
                                fontSize: 16,
                                color: KTextColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 188,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              'images/map.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Positioned(
                            top: 100,
                            left: 30,
                            right: 30,
                            child: Icon(Icons.location_pin,
                                color: Colors.red, size: 40),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Color(0xFFB5A9B1), thickness: 1),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: 90,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Agent",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: KTextColor)),
                              const SizedBox(height: 2),
                              const Text("Al Manara Motors",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: KTextColor,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 3),
                              Text("View All Ads",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF08C2C9),
                                    decoration: TextDecoration.underline,
                                    decorationColor: const Color(0xFF08C2C9),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              _buildActionIcon(FontAwesomeIcons.whatsapp),
                              const SizedBox(height: 6),
                              _buildActionIcon(Icons.phone),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Color(0xFFB5A9B1), thickness: 1),
                    const SizedBox(height: 7),
                    Center(
                      child: Text(
                        "Report This Ad",
                        style: TextStyle(
                          color: KTextColor,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          decorationColor: KTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 110,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 32),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFE4F8F6),
                            Color(0xFFC9F8FE),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          "Click Here To Use This Space For Your Ads",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: KTextColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailBox(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 13, color: KTextColor, fontWeight: FontWeight.w600),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF08C2C9)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: KTextColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionIcon(IconData icon) {
    return Container(
      height: 44,
      width: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF01547E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
