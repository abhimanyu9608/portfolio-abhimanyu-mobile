import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class CodeMarquee extends StatefulWidget {
  const CodeMarquee({super.key});

  @override
  State<CodeMarquee> createState() => _CodeMarqueeState();
}

class _CodeMarqueeState extends State<CodeMarquee>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  static const _snippets = [
    {'text': 'class AbhimanyuKumar extends', 'type': 'kw'},
    {'text': 'FlutterDeveloper', 'type': 'fn'},
    {'text': 'final experience =', 'type': 'kw'},
    {'text': '8', 'type': 'num'},
    {'text': '// years', 'type': 'comment'},
    {'text': 'runApp(CapricornApp())', 'type': 'fn'},
    {'text': '// 50K+ users', 'type': 'comment'},
    {'text': 'await RazorPay.init(config)', 'type': 'kw'},
    {'text': 'BlocProvider.of<AuthBloc>(context).add(BiometricAuth())', 'type': 'fn'},
    {'text': 'final apps = List.generate(20, (_) => PlayStoreApp())', 'type': 'kw'},
    {'text': 'flutter run --release', 'type': 'comment'},
    {'text': '@override Widget build(BuildContext context)', 'type': 'kw'},
    {'text': 'Navigator.pushNamed(context, Routes.eSign)', 'type': 'fn'},
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
    _anim = Tween(begin: 0.0, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Color _color(String type) {
    switch (type) {
      case 'kw': return AppTheme.accent;
      case 'fn': return AppTheme.green;
      case 'num': return AppTheme.pink;
      case 'comment': return AppTheme.amber;
      default: return AppTheme.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.surface,
      height: 44,
      child: Stack(
        children: [
          // Left fade
          Positioned(left: 0, top: 0, bottom: 0, width: 80,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.surface, AppTheme.surface.withOpacity(0)],
                ),
              ),
            ),
          ),
          // Marquee
          AnimatedBuilder(
            animation: _anim,
            builder: (context, _) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        child: Row(
                          children: [
                            Transform.translate(
                              offset: Offset(-_anim.value * 1200, 0),
                              child: Row(
                                children: [
                                  ..._snippets.map((s) => _snippet(s)),
                                  ..._snippets.map((s) => _snippet(s)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          // Right fade
          Positioned(right: 0, top: 0, bottom: 0, width: 80,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [AppTheme.surface.withOpacity(0), AppTheme.surface],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _snippet(Map<String, String> s) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            s['text'] ?? '',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12,
              color: _color(s['type'] ?? ''),
            ),
          ),
          const SizedBox(width: 24),
          Container(width: 1, height: 14, color: AppTheme.border2),
        ],
      ),
    );
  }
}
