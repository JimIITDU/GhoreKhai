import 'package:flutter/material.dart';
import 'screens/root_screen.dart';
import 'theme.dart';

void main() {
  runApp(const GhoreKhaiApp());
}

class GhoreKhaiApp extends StatelessWidget {
  const GhoreKhaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ghore Khai',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const RootScreen(),
    );
  }
}
