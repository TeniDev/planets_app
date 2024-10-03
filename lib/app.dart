import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/constants.dart';
import 'core/router/router.dart';
import 'core/theme/theme.dart';
import 'gen/l10n.dart';
import 'providers/providers.dart';

class PlanetsApp extends ConsumerWidget {
  const PlanetsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(routerProvider);
    final locale = ref.watch(sessionProvider.select((state) => state.locale));

    // TODO: Implement dark mode
    final isDarkMode = ref.watch(sessionProvider.select((state) => state.isDarkMode));

    return MaterialApp.router(
      title: AppConstants.appName,
      theme: AppTheme(isDarkmode: isDarkMode).getTheme(),
      localizationsDelegates: const [
        IntlTranslations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: locale,
      supportedLocales: IntlTranslations.delegate.supportedLocales,
      routerConfig: appRouter,
    );
  }
}
