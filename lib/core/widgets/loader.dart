import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AbsorbPointer(
        absorbing: true,
        child: Container(
          color: Colors.black.withOpacity(0.2),
          child: const Center(child: _LoaderBody()),
        ),
      ),
    );
  }
}

class _LoaderBody extends StatelessWidget {
  const _LoaderBody();

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.twistingDots(
      leftDotColor: Colors.black,
      rightDotColor: Colors.pink,
      size: 50,
    );
  }
}
