import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class HomeWelcomeMessage extends StatelessWidget {
  const HomeWelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '¡Bienvenido!',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.surface),
        ),
        SizedBox(height: 12),
        /// TODO: replace with the user name
        Text('Usuario', style: TextStyle(fontSize: 18, color: AppColors.surface)),
      ],
    );
  }
}
