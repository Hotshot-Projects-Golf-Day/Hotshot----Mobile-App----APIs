import 'package:flutter/material.dart';
import 'package:upd8s/core/theme/app_colors.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/custom_app_bar.dart';

class LegalContentScreen extends StatefulWidget {
  final String title;
  final String content;

  /// Optional toggle titles and content
  final String? title2;
  final String? content2;

  const LegalContentScreen({
    super.key,
    required this.title,
    required this.content,
    this.title2,
    this.content2,
  });

  @override
  State<LegalContentScreen> createState() => _LegalContentScreenState();
}

class _LegalContentScreenState extends State<LegalContentScreen> {
  bool isFirstSelected = true;

  bool get showToggle => widget.title2 != null && widget.content2 != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppBackground(
          child: Column(
            children: [
              CustomAppBarWidget(title: widget.title, showBackButton: true),

              if (showToggle) ...[
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(6),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColor.whiteColor,
                  ),
                  child: Row(
                    children: [
                      _toggleButton(
                        title: widget.title,
                        isSelected: isFirstSelected,
                        onTap: () => setState(() => isFirstSelected = true),
                      ),
                      _toggleButton(
                        title: widget.title2!,
                        isSelected: !isFirstSelected,
                        onTap: () => setState(() => isFirstSelected = false),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    showToggle
                        ? (isFirstSelected ? widget.content : widget.content2!)
                        : widget.content,
                    style: const TextStyle(
                      fontFamily: 'Aptos',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.4,
                      letterSpacing: -0.065,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toggleButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColor.primary100 : AppColor.whiteColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
