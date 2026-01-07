import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../pages/home_page.dart';
import '../pages/about_page.dart';
import '../pages/projects_page.dart';
import '../pages/skills_page.dart';
import '../pages/youtube_page.dart';
import '../pages/contact_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      HomePage(onNavigate: _navigate), // ✅ callback passed
      const AboutPage(),
      const ProjectsPage(),
      const SkillsPage(),
      const YouTubePage(),
      const ContactPage(),
    ];
  }

  void _navigate(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// ✅ HEADER (ONLY ONCE)
          Header(currentIndex: _currentIndex, onNavigate: _navigate),

          /// ✅ PAGE CONTENT
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _pages[_currentIndex],
            ),
          ),
        ],
      ),
    );
  }
}
