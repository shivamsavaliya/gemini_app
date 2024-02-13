import 'package:flutter/material.dart';
import 'package:gemini_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey,
        primaryColor: Colors.grey.shade600,
      ),
      home: const HomePage(),
    );
  }
}
