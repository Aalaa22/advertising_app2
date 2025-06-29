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

//   double getResponsiveFontSize(BuildContext context,
//       {double min = 7, double max = 12}) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     double scaleFactor = (screenWidth + screenHeight) / 2;
//     double base = scaleFactor * 0.013;
//     return base.clamp(min, max);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final textDirection = Directionality.of(context);
//     final isRTL = textDirection == TextDirection.rtl;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final fontSize = getResponsiveFontSize(context);

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
//             Align(
//               alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
//               child: Row(
//                 mainAxisAlignment:
//                     isRTL ? MainAxisAlignment.end : MainAxisAlignment.start,
//                 children: List.generate(displayedFirstRow.length, (index) {
//                   final actualIndex =
//                       categories.indexOf(displayedFirstRow[index]);
//                   final isSelected = actualIndex == selectedIndex;

//                   return isRTL
//                       ? Expanded(
//                           child: GestureDetector(
//                             onTap: () {
//                               onCategorySelected?.call(actualIndex);
//                               onCategoryPressed?.call(displayedFirstRow[index]);
//                             },
//                             child: Container(
//                               height: 50,
//                               margin: const EdgeInsets.symmetric(horizontal: 1),
//                               decoration: BoxDecoration(
//                                 color:
//                                     isSelected ? const Color(0xFF01547E) : null,
//                                 gradient: isSelected
//                                     ? null
//                                     : const LinearGradient(
//                                         begin: Alignment.topCenter,
//                                         end: Alignment.bottomCenter,
//                                         colors: [
//                                           Color(0xFFE4F8F6),
//                                           Color(0xFFC9F8FE),
//                                         ],
//                                       ),
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(
//                                   color: isSelected
//                                       ? KTextColor
//                                       : Colors.grey.shade300,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   displayedFirstRow[index],
//                                   textAlign: TextAlign.center,
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                     fontSize: fontSize,
//                                     fontWeight: FontWeight.w400,
//                                     color:
//                                         isSelected ? Colors.white : KTextColor,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       : Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 1),
//                           child: GestureDetector(
//                             onTap: () {
//                               onCategorySelected?.call(actualIndex);
//                               onCategoryPressed?.call(displayedFirstRow[index]);
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 5),
//                               decoration: BoxDecoration(
//                                 color:
//                                     isSelected ? const Color(0xFF01547E) : null,
//                                 gradient: isSelected
//                                     ? null
//                                     : const LinearGradient(
//                                         begin: Alignment.topCenter,
//                                         end: Alignment.bottomCenter,
//                                         colors: [
//                                           Color(0xFFE4F8F6),
//                                           Color(0xFFC9F8FE),
//                                         ],
//                                       ),
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(
//                                   color: isSelected
//                                       ? KTextColor
//                                       : Colors.grey.shade300,
//                                 ),
//                               ),
//                               child: IntrinsicWidth(
//                                 child: Center(
//                                   child: Text(
//                                     displayedFirstRow[index],
//                                     textAlign: TextAlign.center,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       fontSize: fontSize,
//                                       fontWeight: FontWeight.w400,
//                                       color: isSelected
//                                           ? Colors.white
//                                           : KTextColor,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                 }),
//               ),
//             ),
//             const SizedBox(height: 5),
//             Align(
//               alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
//               child: Wrap(
//                 spacing: 0,
//                 runSpacing: 5,
//                 textDirection: textDirection,
//                 children: List.generate(displayedRest.length, (i) {
//                   final actualIndex = categories.indexOf(displayedRest[i]);
//                   final isSelected = actualIndex == selectedIndex;

//                   final child = Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
//                         color: isSelected ? KTextColor : Colors.grey.shade300,
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         displayedRest[i],
//                         textAlign: TextAlign.center,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: fontSize,
//                           fontWeight: FontWeight.w400,
//                           color: isSelected ? Colors.white : KTextColor,
//                         ),
//                       ),
//                     ),
//                   );

//                   return GestureDetector(
//                     onTap: () {
//                       onCategorySelected?.call(actualIndex);
//                       onCategoryPressed?.call(displayedRest[i]);
//                     },
//                     child: isRTL
//                         ? SizedBox(
//                             width: screenWidth / 4.2,
//                             height: 50,
//                             child: child,
//                           )
//                         : IntrinsicWidth(
//                             child: IntrinsicHeight(
//                               child: child,
//                             ),
//                           ),
//                   );
//                 }),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ************اهم كود *****************************************************

import 'package:flutter/material.dart';
import 'package:advertising_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  double getResponsiveFontSize(BuildContext context,
      {double min = 7, double max = 12}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double scaleFactor = (screenWidth + screenHeight) / 2;
    double base = scaleFactor * 0.019;
    return base.clamp(min, max);
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    final isRTL = textDirection == TextDirection.rtl;
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = 11.sp; // 2.8% of screen width
    //final fontSize = screenWidth * 0.02; // 2.8% of screen width

    final firstRow = categories.take(4).toList();
    final rest = categories.skip(4).toList();

    final displayedFirstRow = isRTL ? firstRow.reversed.toList() : firstRow;
    final displayedRest = isRTL ? rest.reversed.toList() : rest;

    return Directionality(
      textDirection: textDirection,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Expanded(
          child: Column(
            crossAxisAlignment:
                isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Align(
                alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
                child: isRTL
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                            List.generate(displayedFirstRow.length, (index) {
                          final actualIndex =
                              categories.indexOf(displayedFirstRow[index]);
                          final isSelected = actualIndex == selectedIndex;
          
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                onCategorySelected?.call(actualIndex);
                                onCategoryPressed?.call(displayedFirstRow[index]);
                              },
                              child: Container(
                                height: screenWidth * 0.12,
                                margin: const EdgeInsets.symmetric(horizontal: 1),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected ? const Color(0xFF01547E) : null,
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
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected
                                        ? KTextColor
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    displayedFirstRow[index],
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          isSelected ? Colors.white : KTextColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      )
                    : IntrinsicHeight(
                        child: Row(
                          children:
                              List.generate(displayedFirstRow.length, (index) {
                            final actualIndex =
                                categories.indexOf(displayedFirstRow[index]);
                            final isSelected = actualIndex == selectedIndex;
          
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 1),
                              child: GestureDetector(
                                onTap: () {
                                  onCategorySelected?.call(actualIndex);
                                  onCategoryPressed
                                      ?.call(displayedFirstRow[index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.027,
                                    vertical: screenWidth * 0.012,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF01547E)
                                        : null,
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
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isSelected
                                          ? KTextColor
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: IntrinsicWidth(
                                    child: Center(
                                      child: Text(
                                        displayedFirstRow[index],
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.w400,
                                          color: isSelected
                                              ? Colors.white
                                              : KTextColor,
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
              ),
              const SizedBox(height: 5),
              Align(
                alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
                child: Wrap(
                  spacing: 0,
                  runSpacing: 3,
                  textDirection: textDirection,
                  children: List.generate(displayedRest.length, (i) {
                    final actualIndex = categories.indexOf(displayedRest[i]);
                    final isSelected = actualIndex == selectedIndex;
          
                    final child = Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.025,
                        vertical:
                            isRTL ? screenWidth * 0.03 : screenWidth * 0.025,
                      ),
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
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? KTextColor : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          displayedRest[i],
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w400,
                            color: isSelected ? Colors.white : KTextColor,
                          ),
                        ),
                      ),
                    );
          
                    return GestureDetector(
                      onTap: () {
                        onCategorySelected?.call(actualIndex);
                        onCategoryPressed?.call(displayedRest[i]);
                      },
                      child: isRTL
                          ? SizedBox(
                              width: screenWidth / 4.4,
                              height: screenWidth * 0.15,
                              child: child,
                            )
                          : IntrinsicHeight(
                              child: IntrinsicWidth(child: child),
                            ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//--------************************************************-----------------------------

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

//     final firstRow = categories.take(4).toList();
//     final rest = categories.skip(4).toList();

//     return Directionality(
//       textDirection: textDirection,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//         child: Column(
//           crossAxisAlignment: textDirection == TextDirection.rtl
//               ? CrossAxisAlignment.end
//               : CrossAxisAlignment.start,
//           children: [
//             IntrinsicHeight(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: List.generate(firstRow.length, (index) {
//                   final globalIndex = index;
//                   final isSelected = globalIndex == selectedIndex;

//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 1),
//                     child: GestureDetector(
//                       onTap: () {
//                         onCategorySelected?.call(globalIndex);
//                         onCategoryPressed?.call(firstRow[index]);
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 5),
//                         decoration: BoxDecoration(
//                           color: isSelected ? const Color(0xFF01547E) : null,
//                           gradient: isSelected
//                               ? null
//                               : const LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Color(0xFFE4F8F6),
//                                     Color(0xFFC9F8FE),
//                                   ],
//                                 ),
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(
//                             color:
//                                 isSelected ? KTextColor : Colors.grey.shade300,
//                           ),
//                         ),
//                         child: IntrinsicWidth(
//                           child: Center(
//                             child: Text(
//                               firstRow[index],
//                               textAlign: TextAlign.center,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.w400,
//                                 color:
//                                     isSelected ? Colors.white : KTextColor,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//             const SizedBox(height: 5),
//             Wrap(
//               spacing: 1,
//               runSpacing: 1,
//               children: List.generate(rest.length, (i) {
//                 final index = i + 4;
//                 final isSelected = index == selectedIndex;

//                 return GestureDetector(
//                   onTap: () {
//                     onCategorySelected?.call(index);
//                     onCategoryPressed?.call(rest[i]);
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 8, vertical: 12),
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
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color:
//                             isSelected ? KTextColor : Colors.grey.shade300,
//                       ),
//                     ),
//                     child: IntrinsicWidth(
//                       child: Center(
//                         child: Text(
//                           rest[i],
//                           textAlign: TextAlign.center,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w400,
//                             color: isSelected ? Colors.white : KTextColor,
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



////--------------------------------------------------------------------------------

//اكتر حااجه صح يا الاء الكود اللي تحت 


//-------------------------------------------------
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
//             isRTL
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: List.generate(displayedFirstRow.length, (index) {
//                       final actualIndex =
//                           categories.indexOf(displayedFirstRow[index]);
//                       final isSelected = actualIndex == selectedIndex;

//                       return Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             onCategorySelected?.call(actualIndex);
//                             onCategoryPressed?.call(displayedFirstRow[index]);
//                           },
//                           child: Container(
//                             height: 50,
//                             margin: const EdgeInsets.symmetric(horizontal: 1),
//                             decoration: BoxDecoration(
//                               color: isSelected ? const Color(0xFF01547E) : null,
//                               gradient: isSelected
//                                   ? null
//                                   : const LinearGradient(
//                                       begin: Alignment.topCenter,
//                                       end: Alignment.bottomCenter,
//                                       colors: [
//                                         Color(0xFFE4F8F6),
//                                         Color(0xFFC9F8FE),
//                                       ],
//                                     ),
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: isSelected
//                                     ? KTextColor
//                                     : Colors.grey.shade300,
//                               ),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 displayedFirstRow[index],
//                                 textAlign: TextAlign.center,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w400,
//                                   color:
//                                       isSelected ? Colors.white : KTextColor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   )
//                 : IntrinsicHeight(
//                     child: Row(
//                       children: List.generate(displayedFirstRow.length, (index) {
//                         final actualIndex =
//                             categories.indexOf(displayedFirstRow[index]);
//                         final isSelected = actualIndex == selectedIndex;

//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 1),
//                           child: GestureDetector(
//                             onTap: () {
//                               onCategorySelected?.call(actualIndex);
//                               onCategoryPressed?.call(displayedFirstRow[index]);
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 5),
//                               decoration: BoxDecoration(
//                                 color: isSelected
//                                     ? const Color(0xFF01547E)
//                                     : null,
//                                 gradient: isSelected
//                                     ? null
//                                     : const LinearGradient(
//                                         begin: Alignment.topCenter,
//                                         end: Alignment.bottomCenter,
//                                         colors: [
//                                           Color(0xFFE4F8F6),
//                                           Color(0xFFC9F8FE),
//                                         ],
//                                       ),
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   color: isSelected
//                                       ? KTextColor
//                                       : Colors.grey.shade300,
//                                 ),
//                               ),
//                               child: IntrinsicWidth(
//                                 child: Center(
//                                   child: Text(
//                                     displayedFirstRow[index],
//                                     textAlign: TextAlign.center,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w400,
//                                       color: isSelected
//                                           ? Colors.white
//                                           : KTextColor,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//             const SizedBox(height: 5),
//             Wrap(
//               spacing: 2,
//               runSpacing: 5,
//               textDirection: textDirection,
//               children: List.generate(displayedRest.length, (i) {
//                 final actualIndex = categories.indexOf(displayedRest[i]);
//                 final isSelected = actualIndex == selectedIndex;

//                 final child = Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: isSelected ? const Color(0xFF01547E) : null,
//                     gradient: isSelected
//                         ? null
//                         : const LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Color(0xFFE4F8F6),
//                               Color(0xFFC9F8FE),
//                             ],
//                           ),
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: isSelected ? KTextColor : Colors.grey.shade300,
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       displayedRest[i],
//                       textAlign: TextAlign.center,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w400,
//                         color: isSelected ? Colors.white : KTextColor,
//                       ),
//                     ),
//                   ),
//                 );

//                 return GestureDetector(
//                   onTap: () {
//                     onCategorySelected?.call(actualIndex);
//                     onCategoryPressed?.call(displayedRest[i]);
//                   },
//                   child: isRTL
//   ? SizedBox(
//       width: (MediaQuery.of(context).size.width - 40) / 4,
//       height: 50,
//       child: child,
//     )
//   : IntrinsicHeight(
//       child: IntrinsicWidth(
//         child: child,
//       ),
//     ),);
//               }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



//--------------------------------------------------------------------------------------


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
//             Align(
//               alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
//               child: isRTL
//                   ? Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children:
//                           List.generate(displayedFirstRow.length, (index) {
//                         final actualIndex =
//                             categories.indexOf(displayedFirstRow[index]);
//                         final isSelected = actualIndex == selectedIndex;

//                         return Expanded(
//                           child: GestureDetector(
//                             onTap: () {
//                               onCategorySelected?.call(actualIndex);
//                               onCategoryPressed?.call(displayedFirstRow[index]);
//                             },
//                             child: Container(
//                               height: 50,
//                               margin: const EdgeInsets.symmetric(horizontal: 1),
//                               decoration: BoxDecoration(
//                                 color:
//                                     isSelected ? const Color(0xFF01547E) : null,
//                                 gradient: isSelected
//                                     ? null
//                                     : const LinearGradient(
//                                         begin: Alignment.topCenter,
//                                         end: Alignment.bottomCenter,
//                                         colors: [
//                                           Color(0xFFE4F8F6),
//                                           Color(0xFFC9F8FE),
//                                         ],
//                                       ),
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   color: isSelected
//                                       ? KTextColor
//                                       : Colors.grey.shade300,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   displayedFirstRow[index],
//                                   textAlign: TextAlign.center,
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                     fontSize: 11,
//                                     fontWeight: FontWeight.w400,
//                                     color:
//                                         isSelected ? Colors.white : KTextColor,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                     )
//                   : IntrinsicHeight(
//                       child: Row(
//                         children:
//                             List.generate(displayedFirstRow.length, (index) {
//                           final actualIndex =
//                               categories.indexOf(displayedFirstRow[index]);
//                           final isSelected = actualIndex == selectedIndex;

//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 1),
//                             child: GestureDetector(
//                               onTap: () {
//                                 onCategorySelected?.call(actualIndex);
//                                 onCategoryPressed
//                                     ?.call(displayedFirstRow[index]);
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 5),
//                                 decoration: BoxDecoration(
//                                   color: isSelected
//                                       ? const Color(0xFF01547E)
//                                       : null,
//                                   gradient: isSelected
//                                       ? null
//                                       : const LinearGradient(
//                                           begin: Alignment.topCenter,
//                                           end: Alignment.bottomCenter,
//                                           colors: [
//                                             Color(0xFFE4F8F6),
//                                             Color(0xFFC9F8FE),
//                                           ],
//                                         ),
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                     color: isSelected
//                                         ? KTextColor
//                                         : Colors.grey.shade300,
//                                   ),
//                                 ),
//                                 child: IntrinsicWidth(
//                                   child: Center(
//                                     child: Text(
//                                       displayedFirstRow[index],
//                                       textAlign: TextAlign.center,
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TextStyle(
//                                         fontSize: 11,
//                                         fontWeight: FontWeight.w400,
//                                         color: isSelected
//                                             ? Colors.white
//                                             : KTextColor,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//             ),
//             const SizedBox(height: 5),
//             Align(
//               alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
//               child: Wrap(
//                 spacing: 2,
//                 runSpacing: 5,
//                 textDirection: textDirection,
//                 children: List.generate(displayedRest.length, (i) {
//                   final actualIndex = categories.indexOf(displayedRest[i]);
//                   final isSelected = actualIndex == selectedIndex;

//                   final child = Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: isSelected ? KTextColor : Colors.grey.shade300,
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         displayedRest[i],
//                         textAlign: TextAlign.center,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.w400,
//                           color: isSelected ? Colors.white : KTextColor,
//                         ),
//                       ),
//                     ),
//                   );

//                   return GestureDetector(
//                     onTap: () {
//                       onCategorySelected?.call(actualIndex);
//                       onCategoryPressed?.call(displayedRest[i]);
//                     },
//                     child: isRTL
//                         ? SizedBox(
//                             width: (MediaQuery.of(context).size.width - 40) / 4,
//                             height: 50,
//                             child: child,
//                           )
//                         : IntrinsicHeight(
//                             child: IntrinsicWidth(child: child),
//                           ),
//                   );
//                 }),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



