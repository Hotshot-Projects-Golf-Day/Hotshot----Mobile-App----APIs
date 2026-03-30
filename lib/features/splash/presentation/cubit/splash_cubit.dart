import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upd8s/core/helper/secure_storage.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  Future<void> checkAppStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await SecureStorage.instance.getToken();

    emit(state.copyWith(
      isLoading: false,
      hasToken: token != null && token.isNotEmpty,
    ));
  }

  void videoCompleted() {
    emit(state.copyWith(videoFinished: true));
  }
}