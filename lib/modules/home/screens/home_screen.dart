import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../providers/_index.dart';
import '../widgets/_index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<ExchangeProvider>(create: (_) => ExchangeProvider()),
      ],
      child: const Scaffold(backgroundColor: AppColors.surface, body: _HomeView()),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final ExchangeProvider exchange = context.watch<ExchangeProvider>();
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider provider, _) {
        return Stack(
          children: <Widget>[
            /// hero background circle
            Positioned(
              right: -1000,
              top: -250,
              child: HeroCircle(size: provider.heroSize),
            ),

            /// message to welcome the user
            Center(
              child: AnimatedOpacity(
                duration: AppTheme.homeHeroDuration,
                opacity: provider.showWelcome ? 1 : 0,
                child: const HomeWelcomeMessage(),
              ),
            ),

            /// content of the challenge (exchange card, stats, etc.)
            Center(
              child: IgnorePointer(
                ignoring: !provider.showContent,
                child: Content(
                  visible: provider.showContent,
                  exchangeProvider: exchange,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
