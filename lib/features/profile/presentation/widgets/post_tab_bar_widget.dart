import 'package:flutter/material.dart';
import 'package:upd8s/core/theme/app_colors.dart';

class PostTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const PostTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _tabItem(context, "All Post", 0),
            _tabItem(context, "Bookmarks", 1),
          ],
        ),

        Stack(
          children: [
            Container(
              height: 0.8,
              width: double.infinity,
              color: AppColor.natural10,
            ),

            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              alignment: selectedIndex == 0
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                height: 2,
                width: MediaQuery.of(context).size.width / 2,
                color: AppColor.secondary100,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _tabItem(BuildContext context, String title, int index) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColor.blackColor : AppColor.natural40,
            ),
          ),
        ),
      ),
    );
  }
}
