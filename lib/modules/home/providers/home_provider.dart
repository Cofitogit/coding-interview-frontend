import 'dart:async';

import '../../../core/providers/base_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../models/home_state.dart';

class HomeProvider extends BaseProvider {
  HomeProvider() {
    _init();
  }

  HomeState _homeState = const HomeState(heroSize: AppTheme.homeHeroInitialSize);

  HomeState get homeState => _homeState;

  double get heroSize => _homeState.heroSize;
  bool get showWelcome => _homeState.showWelcome;
  bool get showContent => _homeState.showContent;

  Future<void> _init() async {
    markLoading();

    await Future<void>.delayed(AppTheme.homeHeroDuration ~/ 2);
    if (isDisposed) {
      return;
    }
    
    _updateState(_homeState.copyWith(heroSize: AppTheme.homeHeroFinalSize));

    _updateState(_homeState.copyWith(showWelcome: false));

    await Future<void>.delayed(AppTheme.homeWelcomeDuration);
    if (isDisposed) {
      return;
    }

    await Future<void>.delayed(AppTheme.homeContentDelay);
    if (isDisposed) {
      return;
    }

    _updateState(_homeState.copyWith(showContent: true));
    markInitialized();
  }

  void _updateState(HomeState newState) {
    _homeState = newState;
    notifyListeners();
  }
}
