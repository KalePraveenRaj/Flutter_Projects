import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _downloadResume() async {
    final Uri url = Uri.parse('Praveen_Raj_Resume.pdf');
    await launchUrl(url, mode: LaunchMode.externalApplication);
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
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),

                  const SizedBox(height: 32),

                  const Text(
                    'About Me',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "I'm a passionate Full Stack Developer creating responsive, "
                    "accessible, and high-performance applications. I specialize "
                    "in Java, SQL, and desktop and web application development, "
                    "with a strong focus on optimizing user experiences and "
                    "integrating modern technologies like blockchain.\n\n"
                    "My goal is to build efficient, scalable software while "
                    "continuously exploring innovative technologies to push "
                    "the boundaries of modern applications.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.8,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 48),

                  ElevatedButton.icon(
                    onPressed: _downloadResume,
                    icon: const Icon(Icons.download),
                    label: const Text('Download Resume'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF011A4E),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 36,
                        vertical: 16,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
