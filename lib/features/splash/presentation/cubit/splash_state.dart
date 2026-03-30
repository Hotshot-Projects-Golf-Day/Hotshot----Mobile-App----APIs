class SplashState {
  final bool isLoading;
  final bool videoFinished;
  final bool hasToken;

  const SplashState({
    this.isLoading = true,
    this.videoFinished = false,
    this.hasToken = false,
  });

  SplashState copyWith({bool? isLoading, bool? videoFinished, bool? hasToken}) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      videoFinished: videoFinished ?? this.videoFinished,
      hasToken: hasToken ?? this.hasToken,
    );
  }
}
