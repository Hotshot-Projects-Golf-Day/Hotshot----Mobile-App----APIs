import 'package:flutter/material.dart';
import 'package:upd8s/core/theme/app_colors.dart';

class AppToggleSwitch extends StatelessWidget {
  final String firstTitle;
  final String secondTitle;
  final bool isFirstSelected;
  final Function(bool) onChanged;

  /// 🎨 Custom Colors
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final Color? backgroundColor;

  const AppToggleSwitch({
    super.key,
    required this.firstTitle,
    required this.secondTitle,
    required this.isFirstSelected,
    required this.onChanged,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(6),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: backgroundColor ?? AppColor.whiteColor,
      ),
      child: Row(
        children: [
          _buildItem(
            title: firstTitle,
            isSelected: isFirstSelected,
            onTap: () => onChanged(true),
          ),
          _buildItem(
            title: secondTitle,
            isSelected: !isFirstSelected,
            onTap: () => onChanged(false),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? (selectedColor ?? AppColor.primary100)
                : (unselectedColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? (selectedTextColor ?? Colors.white)
                  : (unselectedTextColor ?? Colors.black54),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
