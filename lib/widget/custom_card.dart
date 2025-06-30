import 'package:advertising_app/constants.dart';
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

  const FavoriteCard({
    super.key,
    required this.item,
    required this.onDelete,
     this.showDelete = true,
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
    final isArabic = Directionality.of(context) == TextDirection.rtl;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(16),
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

                // Positioned(
                //   top: 8,
                //   left: 8,
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //     decoration: BoxDecoration(
                //       gradient: const LinearGradient(
                //         colors: [Color(0xFFC9F8FE), Color(0xFF08C2C9)],
                //         begin: Alignment.topCenter,
                //         end: Alignment.bottomCenter,
                //       ),
                //       borderRadius: BorderRadius.circular(6),
                //     ),
                //     child: Row(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Text(
                //           _getPriorityLabel(item.priority),
                //           style: const TextStyle(
                //               color: KTextColor,
                //               fontSize: 12,
                //               fontWeight: FontWeight.w400),
                //         ),
                //         if (item.priority.toString().contains('firstPremiumStar')) ...[
                //           const SizedBox(width: 4),
                //           const Icon(Icons.star,
                //               size: 14, color: Colors.yellow),
                //         ]
                //       ],
                //     ),
                //   ),
                // ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: widget.showDelete
      ? IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: widget.onDelete,
        )
      : Icon(Icons.favorite_border, color: Colors.grey.shade300),
),
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
                        style:  TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        item.date,
                        style:
                            TextStyle(color: Colors.grey, fontSize: 12.sp,fontWeight: FontWeight.w400),
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
                            style:  TextStyle(
                              fontWeight: FontWeight.w600,
                              color: KTextColor,
                              fontSize: 14.sp,
                            ),
                            children: [
                              TextSpan(
                                text: '${parts[1]}  ',
                                style:  TextStyle(
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
                    item.line2,
                    style:  TextStyle(
                      fontSize: 14.sp,
                      color: KTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/locationicon.svg',
                        width: 16.w,
                        height: 20.h,
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(
                          item.location,
                          style:  TextStyle(
                              fontSize: 14.sp,
                              color: KTextColor,
                              fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                     widget.showDelete
  ? IconButton(
      onPressed: widget.onDelete,
      icon: Image.asset('images/delet.png', width: 32.w,height: 32.h,),
    )
  : const SizedBox.shrink(),
                    ],
                  ),
                   SizedBox(height:  15.h,),
                      
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
      ),
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

  

  // String _getPriorityLabel(priority) {
  //   switch (priority) {
  //     case AdPriority.PremiumStar:
  //       return 'Premium';
  //     case AdPriority.premium:
  //       return 'Premium';
  //     case AdPriority.featured:
  //       return 'Featured';
  //     case AdPriority.free:
  //       return 'Free';
  //     default:
  //       return '';
  //   }
  // }
}








// import 'package:advertising_app/constants.dart';
// import 'package:advertising_app/model/favorite_item_interface_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class FavoriteCard extends StatefulWidget {
//   final FavoriteItemInterface item;
//   final VoidCallback onDelete;

//   const FavoriteCard({
//     super.key,
//     required this.item,
//     required this.onDelete,
//   });

//   @override
//   State<FavoriteCard> createState() => _FavoriteCardState();
// }

// class _FavoriteCardState extends State<FavoriteCard> {
//   late PageController _pageController;
//   int _currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final item = widget.item;
//     final isArabic = Directionality.of(context) == TextDirection.rtl;

//     return Directionality(
//       textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
//       child: Card(
//         color: Colors.white,
//         margin: const EdgeInsets.all(16),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // الصور
//             Stack(
//               children: [
//                 SizedBox(
//                   height: 200,
//                   child: PageView.builder(
//                     controller: _pageController,
//                     itemCount: item.images.length,
//                     onPageChanged: (index) =>
//                         setState(() => _currentPage = index),
//                     itemBuilder: (context, index) => ClipRRect(
//                       borderRadius:
//                           const BorderRadius.vertical(top: Radius.circular(12)),
//                       child: Image.asset(
//                         item.images[index],
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // مؤشر الصور
//                 Positioned(
//                   bottom: 8,
//                   left: 8,
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.5),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       "${_currentPage + 1}/${item.images.length}",
//                       style: const TextStyle(color: Colors.white, fontSize: 12),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 8,
//                   right: 8,
//                   child: Row(
//                     children: List.generate(item.images.length, (index) {
//                       return Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 2),
//                         width: 10,
//                         height: 10,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: _currentPage == index
//                               ? Colors.white
//                               : Colors.grey.shade400,
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//                 if (item.isPremium)
//                   Positioned(
//                     top: 8,
//                     left: 8,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFFC9F8FE), Color(0xFF08C2C9)],
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                         ),
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       child: const Text(
//                         'Premium',
//                         style: TextStyle(
//                             color: KTextColor,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                   ),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: IconButton(
//                     icon: const Icon(Icons.favorite, color: Colors.red),
//                     onPressed: widget.onDelete,
//                   ),
//                 ),
//               ],
//             ),

//             // المحتوى
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Price & Date
//                   Row(
//                     children: [
//                      SvgPicture.asset(
//                     'assets/icons/priceicon.svg',
//                     width: 22,
//                     height: 22,
//                   ), const SizedBox(width: 10),
//                       Text(
//                         item.price,
//                         style: const TextStyle(
//                           color: Colors.red,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       const Spacer(),
//                       Text(
//                         item.date,
//                         style:
//                             const TextStyle(color: Colors.grey, fontSize: 10),
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 8),

//                   // Title
//                   Text(
//                     item.title,
//                     style: const TextStyle(
//                       color: KTextColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 6),

//                   // Details
//                   RichText(
//                     text: TextSpan(
//                       children: item.line1.split(' ').map((word) {
//                         final parts = word.split(':');
//                         if (parts.length == 2) {
//                           return TextSpan(
//                             text: '${parts[0]}:',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: KTextColor,
//                               fontSize: 16,
//                             ),
//                             children: [
//                               TextSpan(
//                                 text: '${parts[1]}  ',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   color: KTextColor,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           );
//                         } else {
//                           return TextSpan(
//                             text: '$word ',
//                             style: const TextStyle(
//                               color: KTextColor,
//                               fontSize: 16,
//                             ),
//                           );
//                         }
//                       }).toList(),
//                     ),
//                   ),

//                   const SizedBox(height: 10),
//                   Text(
//                     item.line2,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: KTextColor,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),

//                   // Location & Delete Button
//                   Row(
//                     children: [
//                      SvgPicture.asset(
//                     'assets/icons/locationicon.svg',
//                     width: 22,
//                     height: 22,
//                   ),// const SizedBox(width: 2),
//                       Expanded(
//                         child: Text(
//                           item.location,
//                           style: const TextStyle(
//                               fontSize: 14,
//                               color: KTextColor,
//                               fontWeight: FontWeight.w500),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: widget.onDelete,
//                         icon: Image.asset('images/delet.png', width: 30),
//                       ),
//                     ],
//                   ),
//                   //const SizedBox(height: 2),

//                   // Contact + Buttons
//                   Row(
//                     children: [
//                       Text(
//                         item.contact,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 13,
//                           color: KTextColor,
//                         ),
//                       ),
//                       const Spacer(),
//                       _buildActionIcon(FontAwesomeIcons.whatsapp),
//                       const SizedBox(width: 5),
//                       _buildActionIcon(Icons.phone),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildActionIcon(IconData icon) {
//     return Container(
//       height: 44,
//       width: 60,
//       decoration: BoxDecoration(
//         color: const Color(0xFF01547E),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Center(
//         child: Icon(icon, color: Colors.white, size: 20),
//       ),
//     );
//   }
// }
