import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  static const List<Map<String, String>> skills = [
    {'name': 'Java', 'icon': 'assets/skills/java.svg'},
    {'name': 'Python', 'icon': 'assets/skills/python.svg'},
    {'name': 'Spring Boot', 'icon': 'assets/skills/springboot.svg'},
    {'name': 'Electron', 'icon': 'assets/skills/electron.svg'},
    {'name': 'Node.js', 'icon': 'assets/skills/nodedotjs.svg'},
    {'name': 'Express.js', 'icon': 'assets/skills/express.svg'},
    {'name': 'Firebase', 'icon': 'assets/skills/firebase.svg'},
    {'name': 'Flutter', 'icon': 'assets/skills/flutter.svg'},
    {'name': 'Dart', 'icon': 'assets/skills/dart.svg'},
    {'name': 'JavaScript', 'icon': 'assets/skills/javascript.svg'},
    {'name': 'React', 'icon': 'assets/skills/react.svg'},
    {'name': 'Next.js', 'icon': 'assets/skills/nextdotjs.svg'},
    {'name': 'CSS', 'icon': 'assets/skills/css.svg'},
    {'name': 'Tailwind CSS', 'icon': 'assets/skills/tailwindcss.svg'},
    {'name': 'MySQL', 'icon': 'assets/skills/mysql.svg'},
    {'name': 'Supabase', 'icon': 'assets/skills/supabase.svg'},
    {'name': 'MongoDB', 'icon': 'assets/skills/mongodb.svg'},
    {'name': 'Git', 'icon': 'assets/skills/git.svg'},
    {'name': 'GitHub', 'icon': 'assets/skills/github.svg'},
    {'name': 'GraphQL', 'icon': 'assets/skills/graphql.svg'},
    {'name': 'Docker', 'icon': 'assets/skills/docker.svg'},
    {'name': 'Kubernetes', 'icon': 'assets/skills/kubernetes.svg'},
    {'name': 'AWS', 'icon': 'assets/skills/aws.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF011A4E), Color(0xFF0A3D91)],
        ),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
              child: Column(
                children: [
                  // 🔹 TITLE
                  const Text(
                    'Skills',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 48),

                  // 🔹 SKILLS GRID
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;

                      int columns = 2;
                      if (width >= 1200) {
                        columns = 6;
                      } else if (width >= 900) {
                        columns = 5;
                      } else if (width >= 700) {
                        columns = 4;
                      } else if (width >= 500) {
                        columns = 3;
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: skills.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                        ),
                        itemBuilder: (context, index) {
                          final skill = skills[index];
                          return _SkillCard(
                            name: skill['name']!,
                            iconPath: skill['icon']!,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////
// 🔹 SKILL CARD (REACT STYLE MATCH)
//////////////////////////////////////////////////

class _SkillCard extends StatelessWidget {
  final String name;
  final String iconPath;

  const _SkillCard({required this.name, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath, width: 48, height: 48),
          const SizedBox(height: 12),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
