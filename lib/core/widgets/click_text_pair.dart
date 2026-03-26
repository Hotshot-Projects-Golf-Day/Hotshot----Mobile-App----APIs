import 'package:flutter/material.dart';
import 'package:upd8s/core/theme/app_colors.dart';


class ClickableTextPair extends StatelessWidget {
  final String normalText;
  final String firstClickable;
  final String secondClickable;
  final VoidCallback onFirstClick;
  final VoidCallback onSecondClick;
  final TextStyle? normalStyle;
  final TextStyle? clickableStyle;
  final String connectorText;

  const ClickableTextPair({
    super.key,
    required this.normalText,
    required this.firstClickable,
    required this.secondClickable,
    required this.onFirstClick,
    required this.onSecondClick,
    this.normalStyle,
    this.clickableStyle,
    this.connectorText = " and ",
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final normalTextStyle =
        normalStyle ??
        theme.textTheme.bodySmall ??
        const TextStyle(fontSize: 14);

    final clickableTextStyle =
        clickableStyle ??
        theme.textTheme.bodySmall?.copyWith(
          // color: theme.colorScheme.primary,
          color: AppColor.primary100,
          fontWeight: FontWeight.w600,
        ) ??
        const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: normalText, style: normalTextStyle),

          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: InkWell(
              onTap: onFirstClick,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                child: Text(firstClickable, style: clickableTextStyle),
              ),
            ),
          ),

          if (secondClickable.trim().isNotEmpty) ...[
            TextSpan(text: connectorText, style: normalTextStyle),

            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: InkWell(
                onTap: onSecondClick,
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2,
                    vertical: 2,
                  ),
                  child: Text(secondClickable, style: clickableTextStyle),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
