import 'package:advertising_app/constants.dart';
import 'package:advertising_app/model/favorite_item_interface_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoriteCard extends StatefulWidget {
  final FavoriteItemInterface item;
  final VoidCallback onDelete;

  const FavoriteCard({
    super.key,
    required this.item,
    required this.onDelete,
  });

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  late PageController _pageController;
  int _currentPage = 0;

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
    final item = widget.item;
    final images = item.images;

    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              // عدد الصور
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("${_currentPage + 1}/${images.length}",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
              // مؤشر الصور (dots)
              Positioned(
                bottom: 8,
                right: 8,
                child: Row(
                  children: List.generate(images.length, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.grey.shade400,
                      ),
                    );
                  }),
                ),
              ),
             
              if (item.isPremium)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFC9F8FE),
                          Color(0xFF08C2C9),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('Premium',
                        style: TextStyle(color: KTextColor, fontSize: 12)),
                  ),
                ),
              // Favorite Icon
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: widget.onDelete, 
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Price
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.tags,
                      size: 22,
                      color: KTextColor,
                    ),
                    SizedBox(width: 10),
                    Text(item.price,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 22)),
                    Spacer(),
                    Text(item.date,
                        style: TextStyle(color: Colors.grey, fontSize: 16))
                  ],
                ),
                SizedBox(height: 6),
                
                Text(item.title,
                    style: TextStyle(
                        color: KTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                SizedBox(height: 7),
               
                Text(item.line1,
                    style: TextStyle(
                        fontSize: 16,
                        color: KTextColor,
                        fontWeight: FontWeight.w500)),

                SizedBox(height: 7), 
                Text(item.line2,
                    style: TextStyle(
                        fontSize: 16,
                        color: KTextColor,
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 7),
                // Location
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 25, color: KTextColor),
                    SizedBox(width: 6),
                    Text(item.location,
                        style: TextStyle(fontSize: 18, color: KTextColor)),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                        size: 42,
                      ),
                      onPressed: widget.onDelete,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Dealer name

                SizedBox(height: 6),
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(item.contact,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: KTextColor,
                            fontSize: 20)),
                    Spacer(),
                    IconButton(
                      icon:
                          Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
                      onPressed: () async {
                        final phoneNumber = "0123456789"; 
                        final uri = Uri.parse("tel:$phoneNumber");
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        } else {}
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.phone, color: Colors.blue),
                      onPressed: () async {
                        final phoneNumber = "0123456789";
                        final uri = Uri.parse("tel:$phoneNumber");
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        } else {}
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
