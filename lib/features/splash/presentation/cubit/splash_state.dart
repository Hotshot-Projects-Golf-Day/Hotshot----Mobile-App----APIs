import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  final bool isLoading;
  final bool videoFinished;

  const SplashState({
    this.isLoading = true,
    this.videoFinished = false,
  });

  SplashState copyWith({
    bool? isLoading,
    bool? videoFinished,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      videoFinished: videoFinished ?? this.videoFinished,
    );
  }

  @override
  List<Object?> get props => [isLoading, videoFinished];
}