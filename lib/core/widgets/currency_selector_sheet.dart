import 'package:flutter/material.dart';

import '../models/currency_option.dart';
import '../theme/app_theme.dart';
import 'currency_badge.dart';
import 'grab_handle.dart';

typedef CurrencySelected = void Function(CurrencyOption option);

class CurrencySelectorSheet extends StatelessWidget {
  const CurrencySelectorSheet({required this.options, this.onSelected, this.title, this.activeId, super.key});

  final List<CurrencyOption> options;
  final CurrencySelected? onSelected;
  final String? title;
  final String? activeId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const GrabHandle(),
            const SizedBox(height: 8),
            Center(
              child: Text(
                (title ?? 'Selecciona una opción').toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlack,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (BuildContext context, int index) {
                  final CurrencyOption option = options[index];
                  final bool selected = option.id == activeId;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CurrencyBadge(option: option, size: 24),
                    title: Text(option.code, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                    subtitle: Text(option.description, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
                    trailing: Icon(
                      selected ? Icons.radio_button_checked : Icons.radio_button_off,
                      color: selected ? AppColors.primary : AppColors.textDark,
                    ),
                    onTap: () {
                      onSelected?.call(option);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
