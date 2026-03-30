import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:upd8s/core/constants/app_images.dart';
import 'package:video_player/video_player.dart';

import 'package:upd8s/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:upd8s/features/splash/presentation/cubit/splash_state.dart';
import 'package:upd8s/routes/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    final cubit = context.read<SplashCubit>();
    cubit.checkAppStatus();

    // _controller = VideoPlayerController.asset(AppAssets.splashVideo)
    //   ..initialize().then((_) {
    //     setState(() {});
    //     _controller.play();
    //   });

    _controller = VideoPlayerController.asset(AppAssets.splashVideo)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();

        Future.delayed(_controller.value.duration, () {
          cubit.videoCompleted();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (!state.isLoading && state.videoFinished) {
            if (state.hasToken) {
              context.go(AppRoute.home.path);
            } else {
              context.go(AppRoute.login.path);
            }
          }
        },
        child: _controller.value.isInitialized
            ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : SizedBox.expand(
                child: SvgPicture.asset(AppAssets.splashSvg, fit: BoxFit.cover),
              ),
      ),
    );
  }
}
