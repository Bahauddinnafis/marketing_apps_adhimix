import 'package:flutter/material.dart';
import 'package:marketing_apps/screens/home.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marketing Apps',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFEB0009),
          secondary: Color(0xFF840005),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
