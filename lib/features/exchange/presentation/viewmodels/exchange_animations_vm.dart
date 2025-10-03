import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/theme/app_theme.dart';
import '../state/exchange_animations_state.dart';

part 'exchange_animations_vm.g.dart';

@riverpod
class ExchangeAnimationsViewModel extends _$ExchangeAnimationsViewModel {
  @override
  ExchangeAnimationsState build() {
    _init();
    return const ExchangeAnimationsState(heroSize: AppTheme.homeHeroInitialSize);
  }

  Future<void> _init() async {
    await Future<void>.delayed(AppTheme.homeHeroDuration ~/ 2);

    state = state.copyWith(heroSize: AppTheme.homeHeroFinalSize);
    state = state.copyWith(showWelcome: false);

    await Future<void>.delayed(AppTheme.homeWelcomeDuration);

    await Future<void>.delayed(AppTheme.homeContentDelay);

    state = state.copyWith(showContent: true);
  }
}

