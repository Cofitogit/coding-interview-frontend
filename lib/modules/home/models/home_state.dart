/// Immutable state for the home screen animations.
class HomeState {
  const HomeState({
    required this.heroSize,
    this.showWelcome = true,
    this.showContent = false,
  });

  final double heroSize;
  final bool showWelcome;
  final bool showContent;

  HomeState copyWith({
    double? heroSize,
    bool? showWelcome,
    bool? showContent,
  }) {
    return HomeState(
      heroSize: heroSize ?? this.heroSize,
      showWelcome: showWelcome ?? this.showWelcome,
      showContent: showContent ?? this.showContent,
    );
  }
}

