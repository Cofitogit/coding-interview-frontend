import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/currency_option.dart';
import '../../../../core/theme/app_theme.dart';
import '../helpers/exchange_ui_helper.dart';
import '../state/exchange_animations_state.dart';
import '../state/exchange_state.dart';
import '../viewmodels/currency_options_provider.dart';
import '../viewmodels/exchange_animations_vm.dart';
import '../viewmodels/exchange_vm.dart';
import '../widgets/_index.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.surface,
      body: _ExchangeView(),
    );
  }
}

class _ExchangeView extends ConsumerWidget {
  const _ExchangeView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ExchangeAnimationsState animState = ref.watch(exchangeAnimationsViewModelProvider);
    final ExchangeState exchangeState = ref.watch(exchangeViewModelProvider);
    final ExchangeViewModel viewModel = ref.read(exchangeViewModelProvider.notifier);

    return Stack(
      children: <Widget>[
        /// hero background circle
        Positioned(
          right: -1000,
          top: -250,
          child: HeroCircle(size: animState.heroSize),
        ),

        /// message to welcome the user
        Center(
          child: AnimatedOpacity(
            duration: AppTheme.homeHeroDuration,
            opacity: animState.showWelcome ? 1 : 0,
            child: const WelcomeMessage(),
          ),
        ),

        /// exchange content
        Center(
          child: IgnorePointer(
            ignoring: !animState.showContent,
            child: _ExchangeContent(
              visible: animState.showContent,
              state: exchangeState,
              viewModel: viewModel,
            ),
          ),
        ),
      ],
    );
  }
}

class _ExchangeContent extends ConsumerWidget {
  const _ExchangeContent({
    required this.visible,
    required this.state,
    required this.viewModel,
  });

  final bool visible;
  final ExchangeState state;
  final ExchangeViewModel viewModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CurrencyOption? from = state.fromCurrency;
    final CurrencyOption? to = state.toCurrency;

    return AnimatedSwitcher(
      duration: AppTheme.homeContentDuration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.05),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
            child: child,
          ),
        );
      },
      child: visible && from != null && to != null
          ? Padding(
              key: const ValueKey<String>('exchange-content'),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: <Widget>[
                  ExchangeCard(
                    from: from,
                    to: to,
                    onSelectFrom: () => _handleSelectCurrency(context, ref, viewModel, state, isFrom: true),
                    onSelectTo: () => _handleSelectCurrency(context, ref, viewModel, state, isFrom: false),
                    onSwap: viewModel.swap,
                    amount: state.amount,
                    onAmountChanged: viewModel.updateAmount,
                    onExchange: viewModel.execute,
                    isExchangeEnabled: state.canExecute,
                    isExchangeLoading: state.isLoading,
                    error: state.errorMessage,
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(key: ValueKey<String>('exchange-content-hidden')),
    );
  }

  Future<void> _handleSelectCurrency(
    BuildContext context,
    WidgetRef ref,
    ExchangeViewModel viewModel,
    ExchangeState state, {
    required bool isFrom,
  }) async {
    final CurrencyOption? current = isFrom ? state.fromCurrency : state.toCurrency;
    final CurrencyKind kind = current?.kind ?? (isFrom ? CurrencyKind.crypto : CurrencyKind.fiat);

    final CurrencyOptions currencyOptions = ref.read(currencyOptionsProvider);
    final List<CurrencyOption> options = kind == CurrencyKind.crypto ? currencyOptions.crypto : currencyOptions.fiat;

    final CurrencyOption? selected = await ExchangeUIHelper.showCurrencySelector(
      context: context,
      options: options,
      title: kind == CurrencyKind.crypto ? 'Cripto' : 'Fiat',
      activeId: current?.id,
    );

    if (selected != null) {
      if (isFrom) {
        viewModel.selectFrom(selected);
      } else {
        viewModel.selectTo(selected);
      }
    }
  }
}
