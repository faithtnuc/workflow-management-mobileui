import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'controllers/language_controller.dart';
import 'l10n/app_localizations.dart';
import 'theme/app_theme.dart';
import 'widgets/main_scaffold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: LanguageController.instance,
      builder: (context, locale, child) {
        return MaterialApp(
          title: 'Workflow Mobile',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const MainScaffold(),
        );
      },
    );
  }
}
