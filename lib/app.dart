import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'screens/home/home_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
      return MaterialApp(
  debugShowCheckedModeBanner: false,
  localizationsDelegates: context.localizationDelegates,
  supportedLocales: context.supportedLocales,
  locale: context.locale,
  builder: (context, child) {
    return HomePage(); // ⬅️ كلاس جديدة خاصة بالصفحة الرئيسية
  },
);

  }
}
