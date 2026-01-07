import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  Future<void> _openUrl(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

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
                    'Projects',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 56),

                  // 🔹 PROJECTS GRID
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isDesktop = constraints.maxWidth >= 900;

                      return GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isDesktop ? 2 : 1,
                          crossAxisSpacing: 32,
                          mainAxisSpacing: 32,
                          childAspectRatio: 0.75,
                        ),
                        children: [
                          ProjectCard(
                            image: 'assets/projects/deepSnap.jpg',
                            title: 'DeepSnap',
                            description:
                                'Developed to extract text from images using ElectronJS.',
                            github:
                                'https://github.com/KalePraveenRaj/DeepSnap',
                            live: 'https://kalepraveenraj.github.io/portfolio/',
                            onOpen: _openUrl,
                          ),
                          ProjectCard(
                            image: 'assets/projects/floatingIcon.png',
                            title: 'FloatingIcon',
                            description:
                                'Developed using React and Spring to showcase CRUD operations.',
                            github:
                                'https://github.com/KalePraveenRaj/FloatingIcon',
                            live: 'https://kalepraveenraj.github.io/portfolio/',
                            onOpen: _openUrl,
                          ),
                          ProjectCard(
                            image: 'assets/projects/portfolio.jpg',
                            title: 'Portfolio Website',
                            description:
                                'A responsive personal portfolio website to showcase skills and projects.',
                            github:
                                'https://github.com/KalePraveenRaj/portfolio',
                            live: 'https://kalepraveenraj.github.io/portfolio/',
                            onOpen: _openUrl,
                          ),
                          ProjectCard(
                            image: 'assets/projects/swaggerOpenAPI.jpg',
                            title: 'CRUD Using Spring Boot',
                            description:
                                'Swagger + Spring Boot CRUD backend project.',
                            github:
                                'https://github.com/KalePraveenRaj/CrudOperationsSpringBoot',
                            live: 'https://kalepraveenraj.github.io/portfolio/',
                            onOpen: _openUrl,
                          ),
                        ],
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
// 🔹 PROJECT CARD (OVERFLOW SAFE)
//////////////////////////////////////////////////

class ProjectCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String github;
  final String live;
  final Function(String) onOpen;

  const ProjectCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.github,
    required this.live,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 24,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),

          const SizedBox(height: 16),

          // TITLE
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          // DESCRIPTION
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 18),

          // ACTION ICONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => onOpen(github),
                icon: const FaIcon(FontAwesomeIcons.github),
                color: Colors.white70,
              ),
              IconButton(
                onPressed: () => onOpen(live),
                icon: const FaIcon(FontAwesomeIcons.globe),
                color: Colors.white70,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
