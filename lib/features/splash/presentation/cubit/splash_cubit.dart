import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  Future<void> checkAppStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(isLoading: false));
  }

  void videoCompleted() {
    emit(state.copyWith(videoFinished: true));
  }
}