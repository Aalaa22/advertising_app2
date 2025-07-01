import 'package:flutter/material.dart';
import 'package:advertising_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCategoryGrid extends StatelessWidget {
  final List<String> categories;
  final void Function(int index)? onTap; // للـ Favorite
  final void Function(String title)? onCategoryPressed; // للـ Home
  final int? selectedIndex;

  const CustomCategoryGrid({
    super.key,
    required this.categories,
    this.onTap,
    this.onCategoryPressed,
    this.selectedIndex,
  });

  double getResponsiveFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    debugPrint('📱 screen width: $screenWidth');
    
    return screenWidth > 600
        ? 14
        : screenWidth > 390
            ? 11
        : screenWidth > 400
            ? 12
            : 7;
  }

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    final fontSize = getResponsiveFontSize(context);

    // نقسم العناصر إلى صفوف
    final rows = <List<String>>[];
    for (int i = 0; i < categories.length; i += 4) {
      rows.add(categories.skip(i).take(4).toList());
    }

    return Column(
      children: rows.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: row.asMap().entries.map((entry) {
              final index = entry.key;
              final title = entry.value;

              final globalIndex = categories.indexOf(title);
              final isSelected =
                  selectedIndex != null && globalIndex == selectedIndex;
              final isWide = title.contains('Electronics');
              final flex = isWide ? 2 : 1;
              
              return Flexible(
                flex: flex,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: GestureDetector(
                    onTap: () {
                      onTap?.call(globalIndex);
                      onCategoryPressed?.call(title);
                    },
                    child: Container(
                      height: 35,
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
                          color: isSelected
                              ? const Color(0xFF01547E)
                              : Colors.grey.shade300,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.07),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF01547E),
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

