import 'package:flutter_base_template/controllers/menu_app_controller.dart';
import 'package:flutter_base_template/l10n/language_provider.dart';
import 'package:flutter_base_template/screens/auth/login_or_register_screen.dart';
import 'package:flutter_base_template/services/auth_service.dart';
import 'package:flutter_base_template/services/dio_client.dart';
import 'package:flutter_base_template/services/local_storage_service.dart';

import 'package:flutter_base_template/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = LocalStorageService();
  await storage.init();

  // Uncomment the following lines to enable actual API calls
  // final AuthService authService = AuthService();
  // DioClient.refreshTokenCallback = authService.refreshToken;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(context)),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => MenuAppController()),
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      locale: languageProvider.currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: Provider.of<ThemeProvider>(context).themeData,
      themeMode: ThemeMode.system,
      navigatorKey: navigatorKey,
      home: LoginOrRegisterScreen(),
    );
  }
}
