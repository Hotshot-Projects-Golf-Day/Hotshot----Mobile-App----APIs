import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final bool isVisible;

  const AppLoader({super.key, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox();

    return Container(
      color: Colors.black.withOpacity(0.4),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const SizedBox(
              width: 90,
              height: 90,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
              ),
            ),

            Image.asset("assets/images/loader_logo.png", width: 45, height: 45),
          ],
        ),
      ),
    );
  }
}
