import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YouTubePage extends StatelessWidget {
  const YouTubePage({super.key});

  static const List<Map<String, String>> videos = [
    {'id': 'ceV2V5lqm9M', 'title': 'DeepSnap using DeepSeek API'},
    {'id': 'yMWbYOioDU4', 'title': 'Printing Array Elements'},
    {'id': '1qLxrQ-_g5w', 'title': 'Hello World!'},
    {'id': 'qIEhHPTd0MY', 'title': 'My Portfolio Website'},
    {'id': 'IYlzet7yPis', 'title': 'FloatingIcon'},
    {'id': '_szqUbFCPlQ', 'title': 'FloatingIcon FullStack'},
    {'id': 'tlI58Wz49Kk', 'title': 'CRUD Operations Backend'},
  ];

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
                    'YouTube Videos',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Coding tutorials and project showcases.',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 56),

                  // 🔹 VIDEOS GRID
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isDesktop = constraints.maxWidth >= 900;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: videos.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isDesktop ? 2 : 1,
                          crossAxisSpacing: 32,
                          mainAxisSpacing: 32,
                          childAspectRatio: 16 / 10,
                        ),
                        itemBuilder: (context, index) {
                          final video = videos[index];
                          return _VideoCard(
                            videoId: video['id']!,
                            title: video['title']!,
                            onTap: () {
                              _openUrl(
                                'https://www.youtube.com/watch?v=${video['id']}',
                              );
                            },
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 64),

                  // 🔹 CTA BUTTONS
                  Wrap(
                    spacing: 24,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _openUrl(
                            'https://www.youtube.com/@kalepraveenraj6536',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: const Text(
                          'View More on YouTube',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          _openUrl('https://github.com/KalePraveenRaj');
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white70),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: const Text(
                          'GitHub Repo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
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
// 🔹 VIDEO CARD (REACT STYLE MATCH)
//////////////////////////////////////////////////

class _VideoCard extends StatelessWidget {
  final String videoId;
  final String title;
  final VoidCallback onTap;

  const _VideoCard({
    required this.videoId,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 20,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          children: [
            // 🔹 THUMBNAIL
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      'https://img.youtube.com/vi/$videoId/hqdefault.jpg',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // 🔹 PLAY OVERLAY
                  Positioned.fill(
                    child: Container(
                      color: Colors.black26,
                      child: const Center(
                        child: Icon(
                          Icons.play_circle_fill,
                          size: 64,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 TITLE
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
