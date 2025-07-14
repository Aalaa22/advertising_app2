import 'package:advertising_app/constants.dart';
import 'package:advertising_app/generated/l10n.dart';
import 'package:advertising_app/model/ad_priority.dart';
import 'package:advertising_app/model/favorite_item_interface_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FavoriteCard extends StatefulWidget {
  final FavoriteItemInterface item;
  final VoidCallback onDelete;
  final bool showDelete;
  final VoidCallback? onAddToFavorite; 

  const FavoriteCard({
    super.key,
    required this.item,
    required this.onDelete,
    this.showDelete = true,
    this.onAddToFavorite,
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

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
                  itemCount: item.images.length,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      item.images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "${_currentPage + 1}/${item.images.length}",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(item.images.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: 7,
                        height: 7,
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
              ),
              // نجمة أو لوجو الأولوية
              Positioned(
                top: 8,
                left: 8,
                child: _buildPriorityLabel(item.priority),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: _buildTopRightIcon(),  ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/priceicon.svg',
                      width: 24.w,
                      height: 19.h,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      item.price,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item.date,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  item.title,
                  style: TextStyle(
                    color: KTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    children: item.line1.split(' ').map((word) {
                      final parts = word.split(':');
                      if (parts.length == 2) {
                        return TextSpan(
                          text: '${parts[0]}:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: KTextColor,
                            fontSize: 14.sp,
                          ),
                          children: [
                            TextSpan(
                              text: '${parts[1]}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: KTextColor,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return TextSpan(
                          text: '$word ',
                          style: const TextStyle(
                            color: KTextColor,
                            fontSize: 16,
                          ),
                        );
                      }
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.details,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: KTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/locationicon.svg',
                      width: 16.w,
                      height: 20.h,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item.location,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: KTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 38.w,
                      height: 38.h,
                      child: Offstage(
                        offstage: !widget.showDelete,
                        child: IconButton(
                          onPressed: widget.onDelete,
                          icon: SvgPicture.asset(
                            'assets/icons/deleted.svg',
                            width: 23.w,
                            height: 28.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      item.contact,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: KTextColor,
                      ),
                    ),
                    const Spacer(),
                    _buildActionIcon(FontAwesomeIcons.whatsapp),
                    const SizedBox(width: 5),
                    _buildActionIcon(Icons.phone),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon) {
    return Container(
      height: 35.h,
      width: 62.w,
      decoration: BoxDecoration(
        color: const Color(0xFF01547E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }

  Widget _buildPriorityLabel(AdPriority priority) {
    String text;
    Icon? icon;

    switch (priority) {
      case AdPriority.PremiumStar:
        text = 'Premium';
        icon = const Icon(Icons.star, color: Colors.amber, size: 18);
        break;
      case AdPriority.premium:
        text = 'Premium';
        break;
      case AdPriority.featured:
        text = 'Featured';
        break;
      case AdPriority.free:
        text = 'Free';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFC9F8FE), Color(0xFF08C2C9)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: KTextColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (icon != null) ...[
            const SizedBox(width: 2),
            icon,
          ],
        ],
      ),
    );
  }

  Widget _buildTopRightIcon() {
  if (widget.onAddToFavorite != null) {
    return IconButton(
      icon: const Icon(Icons.favorite_border, color: Colors.grey),
      onPressed: _handleAddToFavorite,
    );
  } else if (widget.showDelete) {
    return IconButton(
      icon: const Icon(Icons.favorite, color: Colors.red),
      onPressed: widget.onDelete,
    );
  } else {
    return const SizedBox.shrink();
  }
}
  
  void _handleAddToFavorite() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title:  Text(S.of(context).add_to_favorite,style: TextStyle(color: KTextColor,fontSize: 16)), // "إضافة إلى المفضلة"
    content: Text(S.of(context).confirm_add_to_favorite,style: TextStyle(color: KTextColor,fontSize: 18),), // "هل تريد إضافة هذا العنصر إلى المفضلة؟"
   actions: [
        TextButton(
          child:Text(S.of(context).cancel,style: TextStyle(color: KTextColor,fontSize: 20)),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child:  Text(S.of(context).yes,style: TextStyle(color: KTextColor,fontSize: 20)),
          onPressed: () {
            Navigator.pop(context);
            widget.onAddToFavorite?.call();
          // ✅ Optional: عرض SnackBar تأكيد
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).added_to_favorite)),
            );
          },
          
        ),
        
      ],
    ),
  );
}

}


