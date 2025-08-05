// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled3/screens/gallery_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      title: 'Art Gallery',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Britney',
      ),
      home: const GalleryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}