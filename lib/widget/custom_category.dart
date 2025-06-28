import 'package:flutter/material.dart';
import 'package:advertising_app/constants.dart';

class CustomCategory extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final Function(int)? onCategorySelected;
  final void Function(String category)? onCategoryPressed;

  const CustomCategory({
    super.key,
    required this.categories,
    this.selectedIndex = -1,
    this.onCategorySelected,
    this.onCategoryPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);

    final firstRow = categories.take(4).toList();
    final rest = categories.skip(4).toList();

    return Directionality(
      textDirection: textDirection,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Column(
          crossAxisAlignment: textDirection == TextDirection.rtl
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(firstRow.length, (index) {
                  final globalIndex = index;
                  final isSelected = globalIndex == selectedIndex;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: GestureDetector(
                      onTap: () {
                        onCategorySelected?.call(globalIndex);
                        onCategoryPressed?.call(firstRow[index]);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF01547E) : null,
                          gradient: isSelected
                              ? null
                              : const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFFE4F8F6),
                                    Color(0xFFC9F8FE),
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color:
                                isSelected ? KTextColor : Colors.grey.shade300,
                          ),
                        ),
                        child: IntrinsicWidth(
                          child: Center(
                            child: Text(
                              firstRow[index],
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.w500,
                                color:
                                    isSelected ? Colors.white : KTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 5),
            Wrap(
              spacing: 1,
              runSpacing: 1,
              children: List.generate(rest.length, (i) {
                final index = i + 4;
                final isSelected = index == selectedIndex;

                return GestureDetector(
                  onTap: () {
                    onCategorySelected?.call(index);
                    onCategoryPressed?.call(rest[i]);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF01547E) : null,
                      gradient: isSelected
                          ? null
                          : const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFE4F8F6),
                                Color(0xFFC9F8FE),
                              ],
                            ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:
                            isSelected ? KTextColor : Colors.grey.shade300,
                      ),
                    ),
                    child: IntrinsicWidth(
                      child: Center(
                        child: Text(
                          rest[i],
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 7,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : KTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:advertising_app/constants.dart';

// class CustomCategory extends StatelessWidget {
//   final List<String> categories;
//   final int selectedIndex;
//   final Function(int)? onCategorySelected;
//   final void Function(String category)? onCategoryPressed;

//   const CustomCategory({
//     super.key,
//     required this.categories,
//     this.selectedIndex = -1,
//     this.onCategorySelected,
//     this.onCategoryPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final textDirection = Directionality.of(context);
//     final isRTL = textDirection == TextDirection.rtl;

//     final firstRow = categories.take(4).toList();
//     final rest = categories.skip(4).toList();

//     final displayedFirstRow = isRTL ? firstRow.reversed.toList() : firstRow;
//     final displayedRest = isRTL ? rest.reversed.toList() : rest;

//     return Directionality(
//       textDirection: textDirection,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//         child: Column(
//           crossAxisAlignment:
//               isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment:
//                   isRTL ? MainAxisAlignment.end : MainAxisAlignment.start,
//               children: List.generate(displayedFirstRow.length, (index) {
//                 final actualIndex =
//                     categories.indexOf(displayedFirstRow[index]);
//                 final isSelected = actualIndex == selectedIndex;

//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 0),
//                   child: GestureDetector(
//                     onTap: () {
//                       onCategorySelected?.call(actualIndex);
//                       onCategoryPressed?.call(displayedFirstRow[index]);
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: isSelected ? const Color(0xFF01547E) : null,
//                         gradient: isSelected
//                             ? null
//                             : const LinearGradient(
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 colors: [
//                                   Color(0xFFE4F8F6),
//                                   Color(0xFFC9F8FE),
//                                 ],
//                               ),
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           color: isSelected ? KTextColor : Colors.grey.shade300,
//                         ),
//                       ),
//                       child: Text(
//                         displayedFirstRow[index],
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 7,
//                           fontWeight: FontWeight.w500,
//                           color: isSelected ? Colors.white : KTextColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             ),
//             const SizedBox(height: 8),
//             Wrap(
//               spacing: 1,
//               runSpacing: 8,
//               textDirection: textDirection,
//               children: List.generate(displayedRest.length, (i) {
//                 final actualIndex = categories.indexOf(displayedRest[i]);
//                 final isSelected = actualIndex == selectedIndex;

//                 return GestureDetector(
//                   onTap: () {
//                     onCategorySelected?.call(actualIndex);
//                     onCategoryPressed?.call(displayedRest[i]);
//                   },
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                     decoration: BoxDecoration(
//                       color: isSelected ? const Color(0xFF01547E) : null,
//                       gradient: isSelected
//                           ? null
//                           : const LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 Color(0xFFE4F8F6),
//                                 Color(0xFFC9F8FE),
//                               ],
//                             ),
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(
//                         color:
//                             isSelected ? KTextColor : Colors.grey.shade300,
//                       ),
//                     ),
//                     child: Text(
//                       displayedRest[i],
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 7,
//                         fontWeight: FontWeight.w500,
//                         color: isSelected ? Colors.white : KTextColor,
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }









// import 'package:flutter/material.dart';
// import 'package:advertising_app/constants.dart';

// class CustomCategory extends StatelessWidget {
//   final List<String> categories;
//   final int selectedIndex;
//   final Function(int)? onCategorySelected;
//   final void Function(String category)? onCategoryPressed;

//   const CustomCategory({
//     super.key,
//     required this.categories,
//     this.selectedIndex = -1,
//     this.onCategorySelected,
//     this.onCategoryPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final textDirection = Directionality.of(context);
//     final isRTL = textDirection == TextDirection.rtl;

//     final firstRow = categories.take(4).toList();
//     final rest = categories.skip(4).toList();

//     final displayedFirstRow = isRTL ? firstRow.reversed.toList() : firstRow;
//     final displayedRest = isRTL ? rest.reversed.toList() : rest;

//     return Directionality(
//       textDirection: textDirection,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//         child: Column(
//           crossAxisAlignment:
//               isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment:
//                   isRTL ? MainAxisAlignment.end : MainAxisAlignment.start,
//               children: List.generate(displayedFirstRow.length, (index) {
//                 final actualIndex =
//                     categories.indexOf(displayedFirstRow[index]);
//                 final isSelected = actualIndex == selectedIndex;

//                 return Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       onCategorySelected?.call(actualIndex);
//                       onCategoryPressed?.call(displayedFirstRow[index]);
//                     },
//                     child: Container(
//                       height: 50,
//                       margin: const EdgeInsets.symmetric(horizontal: 1),
//                       decoration: BoxDecoration(
//                         color: isSelected ? const Color(0xFF01547E) : null,
//                         gradient: isSelected
//                             ? null
//                             : const LinearGradient(
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 colors: [
//                                   Color(0xFFE4F8F6),
//                                   Color(0xFFC9F8FE),
//                                 ],
//                               ),
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color:
//                               isSelected ? KTextColor : Colors.grey.shade300,
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           displayedFirstRow[index],
//                           textAlign: TextAlign.center,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 7,
//                             fontWeight: FontWeight.w500,
//                             color: isSelected ? Colors.white : KTextColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             ),
//             const SizedBox(height: 5),
//             Wrap(
//               spacing: 2,
//               runSpacing: 5,
//               textDirection: textDirection,
//               children: List.generate(displayedRest.length, (i) {
//                 final actualIndex = categories.indexOf(displayedRest[i]);
//                 final isSelected = actualIndex == selectedIndex;

//                 return SizedBox(
//                   width: (MediaQuery.of(context).size.width - 40) /
//                       4, // ← تقسيم العرض بالتساوي على 4 أعمدة
//                   height: 50,
//                   child: GestureDetector(
//                     onTap: () {
//                       onCategorySelected?.call(actualIndex);
//                       onCategoryPressed?.call(displayedRest[i]);
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: isSelected ? const Color(0xFF01547E) : null,
//                         gradient: isSelected
//                             ? null
//                             : const LinearGradient(
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 colors: [
//                                   Color(0xFFE4F8F6),
//                                   Color(0xFFC9F8FE),
//                                 ],
//                               ),
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: isSelected
//                               ? KTextColor
//                               : Colors.grey.shade300,
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           displayedRest[i],
//                           textAlign: TextAlign.center,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 7,
//                             fontWeight: FontWeight.w500,
//                             color:
//                                 isSelected ? Colors.white : KTextColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// //--------------------------------------------------->

// // import 'package:flutter/material.dart';
// // import 'package:advertising_app/constants.dart';

// // class CustomCategory extends StatelessWidget {
// //   final List<String> categories;
// //   final int selectedIndex;
// //   final Function(int)? onCategorySelected;
// //   final void Function(String category)? onCategoryPressed;

// //   const CustomCategory({
// //     super.key,
// //     required this.categories,
// //     this.selectedIndex = -1,
// //     this.onCategorySelected,
// //     this.onCategoryPressed,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     final isArabic = Directionality.of(context) == TextDirection.rtl;

// //     final firstRow = categories.take(4).toList();
// //     final rest = categories.skip(4).toList();

// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
// //       child: Column(
// //         crossAxisAlignment:
// //             isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
// //         children: [
// //           // الصف الأول من التصنيفات
// //           IntrinsicHeight(
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.start,
// //               children: List.generate(firstRow.length, (index) {
// //                 final globalIndex = index;
// //                 final isSelected = globalIndex == selectedIndex;

// //                 return Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 1),
// //                   child: GestureDetector(
// //                     onTap: () {
// //                       onCategorySelected?.call(globalIndex);
// //                       onCategoryPressed?.call(firstRow[index]);
// //                     },
// //                     child: Container(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 10, vertical: 5),
// //                       decoration: BoxDecoration(
// //                         color: isSelected ? const Color(0xFF01547E) : null,
// //                         gradient: isSelected
// //                             ? null
// //                             : const LinearGradient(
// //                                 begin: Alignment.topCenter,
// //                                 end: Alignment.bottomCenter,
// //                                 colors: [
// //                                   Color(0xFFE4F8F6),
// //                                   Color(0xFFC9F8FE),
// //                                 ],
// //                               ),
// //                         borderRadius: BorderRadius.circular(10),
// //                         border: Border.all(
// //                           color: isSelected ? KTextColor : Colors.grey.shade300,
// //                         ),
// //                       ),
// //                       child: IntrinsicWidth(
// //                         child: Center(
// //                           child: Text(
// //                             firstRow[index],
// //                             textAlign: TextAlign.center,
// //                             maxLines: 2,
// //                             overflow: TextOverflow.ellipsis,
// //                             style: TextStyle(
// //                               fontSize: 7,
// //                               fontWeight: FontWeight.w500,
// //                               color: isSelected ? Colors.white : KTextColor,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               }),
// //             ),
// //           ),

// //           const SizedBox(height: 5),

// //           // باقي التصنيفات في صفوف متعددة
// //           Wrap(
// //             spacing: 1,
// //             runSpacing: 1,
// //             children: List.generate(rest.length, (i) {
// //               final index = i + 4;
// //               final isSelected = index == selectedIndex;

// //               return GestureDetector(
// //                 onTap: () {
// //                   onCategorySelected?.call(index);
// //                   onCategoryPressed?.call(rest[i]);
// //                 },
// //                 child: Container(
// //                   padding:
// //                       const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
// //                   decoration: BoxDecoration(
// //                     color: isSelected ? const Color(0xFF01547E) : null,
// //                     gradient: isSelected
// //                         ? null
// //                         : const LinearGradient(
// //                             begin: Alignment.topCenter,
// //                             end: Alignment.bottomCenter,
// //                             colors: [
// //                               Color(0xFFE4F8F6),
// //                               Color(0xFFC9F8FE),
// //                             ],
// //                           ),
// //                     borderRadius: BorderRadius.circular(10),
// //                     border: Border.all(
// //                       color: isSelected ? KTextColor : Colors.grey.shade300,
// //                     ),
// //                   ),
// //                   child: IntrinsicWidth(
// //                     child: Center(
// //                       child: Text(
// //                         rest[i],
// //                         textAlign: TextAlign.center,
// //                         maxLines: 2,
// //                         overflow: TextOverflow.ellipsis,
// //                         style: TextStyle(
// //                           fontSize: 7,
// //                           fontWeight: FontWeight.w500,
// //                           color: isSelected ? Colors.white : KTextColor,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             }),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }

// //------------------------------------------------------->

// // import 'package:flutter/material.dart';
// // import 'package:advertising_app/constants.dart';

// // class CustomCategory extends StatelessWidget {
// //   final List<String> categories;
// //   final int selectedIndex;
// //   final Function(int)? onCategorySelected;
// //   final void Function(String category)? onCategoryPressed;

// //   const CustomCategory({
// //     super.key,
// //     required this.categories,
// //     this.selectedIndex = -1,
// //     this.onCategorySelected,
// //     this.onCategoryPressed,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     final textDirection = Directionality.of(context);
// //     final isRTL = textDirection == TextDirection.rtl;

// //     final firstRow = categories.take(4).toList();
// //     final rest = categories.skip(4).toList();

// //     // عكس العناصر لو RTL
// //     final displayedFirstRow = isRTL ? firstRow.reversed.toList() : firstRow;
// //     final displayedRest = isRTL ? rest.reversed.toList() : rest;

// //     return Directionality(
// //       textDirection: textDirection,
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
// //         child: Column(
// //           crossAxisAlignment:
// //               isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
// //           children: [
// //             IntrinsicHeight(
// //               child: Row(
// //                 mainAxisAlignment:
// //                     isRTL ? MainAxisAlignment.end : MainAxisAlignment.start,
// //                 children: List.generate(displayedFirstRow.length, (index) {
// //                   final actualIndex =
// //                       categories.indexOf(displayedFirstRow[index]);
// //                   final isSelected = actualIndex == selectedIndex;

// //                   return Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 1),
// //                     child: GestureDetector(
// //                       onTap: () {
// //                         onCategorySelected?.call(actualIndex);
// //                         onCategoryPressed?.call(displayedFirstRow[index]);
// //                       },
// //                       child: Container(
// //                         padding: const EdgeInsets.symmetric(
// //                             horizontal: 10, vertical: 5),
// //                         decoration: BoxDecoration(
// //                           color: isSelected ? const Color(0xFF01547E) : null,
// //                           gradient: isSelected
// //                               ? null
// //                               : const LinearGradient(
// //                                   begin: Alignment.topCenter,
// //                                   end: Alignment.bottomCenter,
// //                                   colors: [
// //                                     Color(0xFFE4F8F6),
// //                                     Color(0xFFC9F8FE),
// //                                   ],
// //                                 ),
// //                           borderRadius: BorderRadius.circular(8),
// //                           border: Border.all(
// //                             color:
// //                                 isSelected ? KTextColor : Colors.grey.shade300,
// //                           ),
// //                         ),
// //                         child: IntrinsicWidth(
// //                           child: Center(
// //                             child: Text(
// //                               displayedFirstRow[index],
// //                               textAlign: TextAlign.center,
// //                               maxLines: 2,
// //                               overflow: TextOverflow.ellipsis,
// //                               style: TextStyle(
// //                                 fontSize: 7,
// //                                 fontWeight: FontWeight.w500,
// //                                 color: isSelected ? Colors.white : KTextColor,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 }),
// //               ),
// //             ),
// //             const SizedBox(height: 5),
// //             Wrap(
// //               spacing: 2,
// //               runSpacing: 1,
// //               textDirection: textDirection, // يخلي الـ Wrap يتبع اتجاه اللغة
// //               children: List.generate(displayedRest.length, (i) {
// //                 final actualIndex = categories.indexOf(displayedRest[i]);
// //                 final isSelected = actualIndex == selectedIndex;

// //                 return GestureDetector(
// //                   onTap: () {
// //                     onCategorySelected?.call(actualIndex);
// //                     onCategoryPressed?.call(displayedRest[i]);
// //                   },
// //                   child: Container(
// //                     padding:
// //                         const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
// //                     decoration: BoxDecoration(
// //                       color: isSelected ? const Color(0xFF01547E) : null,
// //                       gradient: isSelected
// //                           ? null
// //                           : const LinearGradient(
// //                               begin: Alignment.topCenter,
// //                               end: Alignment.bottomCenter,
// //                               colors: [
// //                                 Color(0xFFE4F8F6),
// //                                 Color(0xFFC9F8FE),
// //                               ],
// //                             ),
// //                       borderRadius: BorderRadius.circular(8),
// //                       border: Border.all(
// //                         color: isSelected ? KTextColor : Colors.grey.shade300,
// //                       ),
// //                     ),
// //                     child: IntrinsicWidth(
// //                       child: Center(
// //                         child: Text(
// //                           displayedRest[i],
// //                           textAlign: TextAlign.center,
// //                           maxLines: 2,
// //                           overflow: TextOverflow.ellipsis,
// //                           style: TextStyle(
// //                             fontSize: 7,
// //                             fontWeight: FontWeight.w500,
// //                             color: isSelected ? Colors.white : KTextColor,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               }),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
