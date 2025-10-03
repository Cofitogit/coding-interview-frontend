import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_theme.dart';

class AmountField extends StatefulWidget {
  const AmountField({
    required this.currencyLabel,
    required this.amount,
    required this.onChanged,
    super.key,
  });

  final String currencyLabel;
  final String amount;
  final ValueChanged<String> onChanged;

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.amount);
  }

  @override
  void didUpdateWidget(AmountField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.amount != oldWidget.amount &&
        widget.amount != _controller.text) {
      _controller.text = widget.amount;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Row(
        children: <Widget>[
          Text(
            widget.currencyLabel,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '0.00',
                hintStyle: TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: <TextInputFormatter>[
                TextInputFormatter.withFunction((
                  TextEditingValue oldValue,
                  TextEditingValue newValue,
                ) {
                  // Replace comma with dot for decimals
                  return newValue.copyWith(
                    text: newValue.text.replaceAll(',', '.'),
                  );
                }),
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
