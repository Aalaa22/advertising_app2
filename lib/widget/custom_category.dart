import 'package:advertising_app/constants.dart';
import 'package:flutter/material.dart';

class CustomCategory extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const CustomCategory({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = (screenWidth - 50) / 4;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.start,
        children: List.generate(categories.length, (index) {
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onCategorySelected(index),
            child: Container(
              width: buttonWidth,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 6),
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
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? KTextColor : Colors.grey.shade300,
                ),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : KTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
