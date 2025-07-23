import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../artist/upload_screen.dart'; // 🟢 Import screen

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      body: UploadScreen(), 
    );
  }
}
