import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  final int currentIndex;
  final Function(int) onNavigate;

  const Header({
    super.key,
    required this.currentIndex,
    required this.onNavigate,
  });

  static const List<String> menuItems = [
    'About',
    'Projects',
    'Skills',
    'YouTube',
    'Contact',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: const Color(0xFF011A4E),
      child: Container(
        height: 80,
        width: double.infinity,
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                /// LOGO + NAME → HOME (index 0)
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => onNavigate(0),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(4),
                          color: const Color(0xFF011A4E),
                          child: Transform.scale(
                            scale: 1.8, // 🔍 ZOOM LEVEL (try 1.4 – 1.8)
                            child: SvgPicture.asset(
                              'assets/logo.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),
                      const Text(
                        'Kale Praveen Raj',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                /// MENU ITEMS (start from index 1)
                for (int i = 0; i < menuItems.length; i++)
                  _NavItem(
                    title: menuItems[i],
                    isActive: currentIndex == i + 1,
                    onTap: () => onNavigate(i + 1),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: isActive ? Colors.white : Colors.white70,
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          decoration: isActive ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}
