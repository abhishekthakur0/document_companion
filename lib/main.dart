import 'dart:async';

import 'package:document_companion/config/route_generator.dart';
import 'package:document_companion/modules/home/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/custom_key.dart';
import 'config/custom_theme.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CustomTheme currentTheme = CustomTheme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: Homepage.route,
      navigatorKey: CustomKey.navigatorKey,
      scaffoldMessengerKey: CustomKey.scaffoldMessengerKey,
      supportedLocales: AppLocalizationDelegate().supportedLocales,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
