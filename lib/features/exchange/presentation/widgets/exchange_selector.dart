import 'package:flutter/material.dart';

import '../../../../core/models/currency_option.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/currency_badge.dart';
import 'chip_label.dart';

class ExchangeSelector extends StatefulWidget {
  const ExchangeSelector({
    required this.from,
    required this.to,
    required this.onSelectFrom,
    required this.onSelectTo,
    this.onSwap,
    super.key,
  });

  final CurrencyOption from;
  final CurrencyOption to;
  final VoidCallback onSelectFrom;
  final VoidCallback onSelectTo;
  final VoidCallback? onSwap;

  @override
  State<ExchangeSelector> createState() => _ExchangeSelectorState();
}

class _ExchangeSelectorState extends State<ExchangeSelector> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleSwap() async {
    if (widget.onSwap == null) {
      return;
    }

    // Animate the button (shrink and grow)
    await _animationController.forward();
    widget.onSwap!();
    await _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.primary, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // AnimatedSwitcher for the "from" chip
              Flexible(
                flex: 5,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: _SelectorChip(
                    key: ValueKey<String>(widget.from.id),
                    align: MainAxisAlignment.start,
                    option: widget.from,
                    onTap: widget.onSelectFrom,
                  ),
                ),
              ),
              const Spacer(flex: 2),
              // AnimatedSwitcher for the "to" chip
              Flexible(
                flex: 5,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: _SelectorChip(
                    key: ValueKey<String>(widget.to.id),
                    align: MainAxisAlignment.end,
                    option: widget.to,
                    onTap: widget.onSelectTo,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Central button with scale animation
        ScaleTransition(
          scale: _scaleAnimation,
          child: InkWell(
            onTap: _handleSwap,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(30)),
              child: const Icon(Icons.compare_arrows, color: AppColors.cardBackground, size: 35),
            ),
          ),
        ),
        const Positioned(top: 6, left: 28, child: ChipLabel(text: 'TENGO')),
        const Positioned(top: 6, right: 28, child: ChipLabel(text: 'QUIERO')),
      ],
    );
  }
}

class _SelectorChip extends StatelessWidget {
  const _SelectorChip({required this.option, required this.onTap, required this.align, super.key});

  final CurrencyOption option;
  final VoidCallback onTap;
  final MainAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Row(
        mainAxisAlignment: align,
        spacing: 8,
        children: <Widget>[
          Flexible(child: CurrencyBadge(option: option, size: 24)),
          Text(option.code, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          const Icon(Icons.keyboard_arrow_down, color: AppColors.textDark),
        ],
      ),
    );
  }
}
