import 'package:flutter/material.dart';
import 'package:calculadora/calculadora/calculadora.dart';
import 'package:calculadora/config/config/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme(),
      home: const Calculadora(),
    );
  }
}
