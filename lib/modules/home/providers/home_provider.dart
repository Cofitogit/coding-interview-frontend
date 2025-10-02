import 'dart:async';

import '../../../core/providers/base_provider.dart';
import '../../../core/theme/app_theme.dart';

class HomeProvider extends BaseProvider {
  HomeProvider() {
    _init();
  }

  double _heroSize = AppTheme.homeHeroInitialSize;
  bool _showWelcome = true;
  bool _showContent = false;

  double get heroSize => _heroSize;

  bool get showWelcome => _showWelcome;

  bool get showContent => _showContent;

  Future<void> _init() async {
    markLoading();

    await Future<void>.delayed(AppTheme.homeHeroDuration ~/ 2);
    if (isDisposed) {
      return;
    }
    _heroSize = AppTheme.homeHeroFinalSize;
    notifyListeners();

    _showWelcome = false;
    notifyListeners();
    
    await Future<void>.delayed(AppTheme.homeWelcomeDuration);
    if (isDisposed) {
      return;
    }

    await Future<void>.delayed(AppTheme.homeContentDelay);
    if (isDisposed) {
      return;
    }
    _showContent = true;
    notifyListeners();
    markInitialized();
  }
}
