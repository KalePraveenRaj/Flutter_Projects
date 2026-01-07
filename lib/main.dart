import 'package:flutter/material.dart';
import 'package:flutter_application_1/AppShell/App_Shell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kale Praveen Raj | Full Stack Developer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 1, 10, 29),
        ),
      ),
      home: const AppShell(), // ✅ IMPORTANT
    );
  }
}
