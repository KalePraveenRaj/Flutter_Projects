import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final messageCtrl = TextEditingController();

  Future<void> _openUrl(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;

    final uri = Uri(
      scheme: 'mailto',
      path: 'kalepraveenraj@gmail.com',
      query: Uri.encodeQueryComponent(
        'subject=Contact from Portfolio\n'
        'body='
        'Name: ${nameCtrl.text}\n'
        'Email: ${emailCtrl.text}\n'
        'Phone: ${phoneCtrl.text}\n\n'
        '${messageCtrl.text}',
      ),
    );

    await launchUrl(uri, mode: LaunchMode.externalApplication);
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
                    'Contact',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 64),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isDesktop = constraints.maxWidth >= 900;

                      if (!isDesktop) {
                        return Column(
                          children: [
                            _leftBox(),
                            const SizedBox(height: 32),
                            _rightBox(),
                          ],
                        );
                      }

                      return IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: _leftBox()),
                            const SizedBox(width: 32),
                            Expanded(child: _rightBox()),
                          ],
                        ),
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

  // =========================================================
  // 🔹 COMMON BOX STYLE
  // =========================================================
  Widget _box({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 28,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: child,
    );
  }

  // =========================================================
  // 🔹 LEFT BOX – SOCIAL + INFO
  // =========================================================
  Widget _leftBox() {
    return _box(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              children: [
                TextSpan(text: "I'M ALSO ON "),
                TextSpan(
                  text: 'SOCIAL NETWORKS',
                  style: TextStyle(color: Colors.cyan),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 🔹 SOCIAL ICONS
          Wrap(
            spacing: 28,
            children: [
              _socialIcon(
                FontAwesomeIcons.github,
                'https://github.com/kalepraveenraj',
              ),
              _socialIcon(
                FontAwesomeIcons.linkedin,
                'https://linkedin.com/in/kale-praveen-raj-7b2178130',
              ),
              _socialIcon(
                FontAwesomeIcons.youtube,
                'https://www.youtube.com/@kalepraveenraj6536',
              ),
              _socialIcon(
                FontAwesomeIcons.instagram,
                'https://www.instagram.com/praveen_raj_kale_1729/',
              ),
              _socialIcon(
                FontAwesomeIcons.facebook,
                'https://www.facebook.com/praveen.raj.135388/',
              ),
              _socialIcon(
                FontAwesomeIcons.twitter,
                'https://twitter.com/kalepraveenraj',
              ),
            ],
          ),

          const SizedBox(height: 32),
          const Divider(color: Colors.white30),
          const SizedBox(height: 24),

          _infoRow(
            FontAwesomeIcons.house,
            'Address',
            'Hyderabad, Telangana, India',
          ),
          _infoRow(FontAwesomeIcons.phone, "Let's Talk", '+91 85000 58880'),
          _infoRow(
            FontAwesomeIcons.envelope,
            'E-Mail',
            'kalepraveenraj@gmail.com',
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return IconButton(
      onPressed: () => _openUrl(url),
      icon: FaIcon(icon),
      iconSize: 24,
      color: Colors.white70,
      hoverColor: Colors.white,
      tooltip: url,
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FaIcon(icon, color: Colors.white),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(value, style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  // =========================================================
  // 🔹 RIGHT BOX – CONTACT FORM
  // =========================================================
  Widget _rightBox() {
    return _box(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              'GET IN TOUCH',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 28),

            _input(nameCtrl, 'Full Name *'),
            _input(emailCtrl, 'Email *', isEmail: true),
            _input(phoneCtrl, 'Phone Number *'),
            _input(messageCtrl, 'Message *', maxLines: 4),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: _sendEmail,
              icon: const FaIcon(FontAwesomeIcons.paperPlane),
              label: const Text('SEND'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(
    TextEditingController controller,
    String hint, {
    bool isEmail = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        validator: (value) =>
            value == null || value.isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white54),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.cyan),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
