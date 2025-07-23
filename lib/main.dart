import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'services/firebase_initializer.dart';
import 'app.dart';
import 'package:provider/provider.dart';
import 'providers/upload_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Fix for your error
  await FirebaseInitializer.initialize();
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
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UploadProvider()),
      ],
      child: const MyApp(),
    ),
  ),
);

}
