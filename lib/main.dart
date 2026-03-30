import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:upd8s/core/constants/dimensions.dart';
import 'package:upd8s/core/localization/localization_bloc.dart';
import 'package:upd8s/core/theme/app_theme.dart';
import 'package:upd8s/core/theme/theme_bloc.dart';
import 'package:upd8s/l10n/app_localizations.dart';
import 'package:upd8s/routes/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocalizationBloc()),
        BlocProvider(create: (_) => ThemeBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, Locale>(
      builder: (context, locale) {
        return BlocBuilder<ThemeBloc, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: "Upd8s",
              routerConfig: appRouter,

              builder: (context, child) {
                Dimensions.init(context);
                return child!;
              },
              locale: locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              theme: AppTheme.lightTheme,
              themeMode: themeMode,
            );
          },
        );
      },
    );
  }
}
