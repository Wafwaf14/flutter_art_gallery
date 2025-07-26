import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
  supportedLocales: const [
    Locale('en'),
    Locale('ar'),
    Locale('fr'),
  ],
  path: 'assets/lang', 
  fallbackLocale: Locale('en'),
  child: MyApp(),
)

  );
}
