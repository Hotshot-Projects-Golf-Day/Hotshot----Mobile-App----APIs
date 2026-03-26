import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({
    super.key,
    this.title,
    this.showBackButton = true,
    this.centerTitle = false,
    this.actions,
    this.backgroundColor = Colors.transparent,
    this.leadingIcon, // ✅ NEW
  });

  final String? title;
  final bool showBackButton;
  final bool centerTitle;
  final List<Widget>? actions;
  final Color backgroundColor;
  final IconData? leadingIcon; // ✅ NEW

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: kToolbarHeight,
      child: Row(
        children: [
          if (showBackButton)
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                leadingIcon ?? Icons.arrow_back, // ✅ default fallback
                color: Colors.black,
              ),
            ),

          if (showBackButton) const SizedBox(width: 16),

          Expanded(
            child: Container(
              alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
              child: Text(
                title ?? "",
                textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                style: const TextStyle(
                  fontFamily: 'Aptos',
                  fontWeight: FontWeight.w700,
                  fontSize: 21,
                  height: 1.4,
                  letterSpacing: -0.21,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          if (actions != null) ...actions!,
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final bool centerTitle;
  final List<Widget>? actions;
  final Color backgroundColor;
  final double elevation;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBackButton = false,
    this.centerTitle = false,
    this.actions,
    this.backgroundColor = const Color(0xFF1F3442),
    this.elevation = 0,
  });

  bool get _isDarkBackground =>
      ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    final bool canPop = context.canPop();
    final Color contentColor = _isDarkBackground ? Colors.white : Colors.black;

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      titleSpacing: showBackButton ? 8 : 16,
      leadingWidth: showBackButton && canPop ? 48 : 0,

      systemOverlayStyle: _isDarkBackground
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,

      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                color: contentColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            )
          : null,

      leading: showBackButton && canPop
          ? IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.arrow_back, color: contentColor),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
            )
          : null,

      actions: actions
          ?.map(
            (e) => IconTheme(
              data: IconThemeData(color: contentColor),
              child: e,
            ),
          )
          .toList(),

      surfaceTintColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
