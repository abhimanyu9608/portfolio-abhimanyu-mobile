import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _ring1Ctrl;
  late AnimationController _ring2Ctrl;
  late AnimationController _ring3Ctrl;
  late AnimationController _scanCtrl;
  late AnimationController _chipCtrl;
  bool _statsVisible = false;

  @override
  void initState() {
    super.initState();
    _ring1Ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat();
    _ring2Ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 30))
          ..repeat(reverse: true);
    _ring3Ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 40))
          ..repeat();
    _scanCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
    _chipCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ring1Ctrl.dispose();
    _ring2Ctrl.dispose();
    _ring3Ctrl.dispose();
    _scanCtrl.dispose();
    _chipCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 900;

    return Container(
      constraints: const BoxConstraints(minHeight: 700),
      padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: 100),
      child: isMobile
          ? Column(
              children: [
                _buildPhotoOrbit(),
                const SizedBox(height: 48),
                _buildHeroText(isMobile),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 5, child: _buildHeroText(isMobile)),
                const SizedBox(width: 60),
                Expanded(
                    flex: 4, child: Center(child: _buildPhotoOrbit())),
              ],
            ),
    );
  }

  Widget _buildHeroText(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Terminal tag
        Row(
          children: [
            Text(r'$ ',
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 12, color: AppTheme.textMuted)),
            Text('whoami',
                style: GoogleFonts.jetBrainsMono(
                    fontSize: 12,
                    color: AppTheme.green,
                    letterSpacing: 0.1)),
          ],
        ).animate().fadeIn(duration: 400.ms),
        const SizedBox(height: 20),

        // Name
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, AppTheme.accent, AppTheme.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'Abhimanyu\nKumar',
            style: GoogleFonts.syne(
              fontSize: isMobile ? 44 : 64,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.0,
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .slideY(begin: 0.3, end: 0),
        const SizedBox(height: 12),

        // Typewriter role
        SizedBox(
          height: 22,
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Senior Flutter Developer',
                textStyle: GoogleFonts.jetBrainsMono(
                    fontSize: 13,
                    color: AppTheme.accent,
                    letterSpacing: 0.04),
                speed: const Duration(milliseconds: 70),
              ),
              TypewriterAnimatedText(
                'Android App Architect',
                textStyle: GoogleFonts.jetBrainsMono(
                    fontSize: 13,
                    color: AppTheme.green,
                    letterSpacing: 0.04),
                speed: const Duration(milliseconds: 70),
              ),
              TypewriterAnimatedText(
                'Mobile UI Engineer',
                textStyle: GoogleFonts.jetBrainsMono(
                    fontSize: 13,
                    color: AppTheme.amber,
                    letterSpacing: 0.04),
                speed: const Duration(milliseconds: 70),
              ),
              TypewriterAnimatedText(
                'Fintech App Specialist',
                textStyle: GoogleFonts.jetBrainsMono(
                    fontSize: 13,
                    color: AppTheme.purple,
                    letterSpacing: 0.04),
                speed: const Duration(milliseconds: 70),
              ),
            ],
            repeatForever: true,
            pause: const Duration(milliseconds: 1800),
            displayFullTextOnTap: false,
          ),
        ).animate().fadeIn(delay: 400.ms),
        const SizedBox(height: 24),

        // Desc
        Text(
          '8+ years engineering and shipping production mobile applications across fintech, digital identity, e-commerce, and entertainment. Clean architecture, zero compromises.',
          style: GoogleFonts.syne(
            fontSize: 15,
            color: AppTheme.textSecondary,
            height: 1.85,
          ),
          maxLines: 4,
        ).animate().fadeIn(delay: 500.ms),
        const SizedBox(height: 32),

        // Scroll-triggered counting stats
        VisibilityDetector(
          key: const Key('hero-stats'),
          onVisibilityChanged: (info) {
            if (info.visibleFraction > 0.5 && !_statsVisible) {
              setState(() => _statsVisible = true);
            }
          },
          child: Row(
            children: [
              _CountStat(
                  target: 8,
                  suffix: '+',
                  label: 'Years',
                  color: AppTheme.accent,
                  trigger: _statsVisible),
              const SizedBox(width: 36),
              _CountStat(
                  target: 20,
                  suffix: '+',
                  label: 'Live Apps',
                  color: AppTheme.green,
                  trigger: _statsVisible),
              const SizedBox(width: 36),
              _CountStat(
                  target: 50,
                  suffix: 'K+',
                  label: 'Users',
                  color: AppTheme.amber,
                  trigger: _statsVisible),
              const SizedBox(width: 36),
              _StaticStat(
                  value: '4.4★',
                  label: 'Rating',
                  color: AppTheme.pink,
                  trigger: _statsVisible),
            ],
          ),
        ).animate().fadeIn(delay: 600.ms),
        const SizedBox(height: 36),

        // Buttons
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            GlowButton(
              label: '✉  Get In Touch',
              onTap: () =>
                  launchUrl(Uri.parse('mailto:${AppData.email}')),
            ),
            GlowButton(
              label: '↗  LinkedIn',
              primary: false,
              onTap: () => launchUrl(Uri.parse(AppData.linkedin)),
            ),
          ],
        ).animate().fadeIn(delay: 700.ms),
      ],
    );
  }

  Widget _buildPhotoOrbit() {
    return SizedBox(
      width: 380,
      height: 380,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _ring3Ctrl,
            builder: (_, __) => Transform.rotate(
              angle: _ring3Ctrl.value * 2 * pi,
              child: Container(
                width: 380,
                height: 380,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppTheme.green.withOpacity(0.08), width: 1),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _ring2Ctrl,
            builder: (_, __) => Transform.rotate(
              angle: _ring2Ctrl.value * 2 * pi,
              child: Container(
                width: 330,
                height: 330,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppTheme.purple.withOpacity(0.12), width: 1),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _ring1Ctrl,
            builder: (_, __) => Transform.rotate(
              angle: _ring1Ctrl.value * 2 * pi,
              child: SizedBox(
                width: 290,
                height: 290,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppTheme.accent.withOpacity(0.2),
                            width: 1),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.accent,
                            boxShadow: [
                              BoxShadow(
                                  color: AppTheme.accent.withOpacity(0.6),
                                  blurRadius: 10)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.accent,
                            boxShadow: [
                              BoxShadow(
                                  color: AppTheme.accent.withOpacity(0.6),
                                  blurRadius: 10)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildPhotoCircle(),
          _chip('Flutter', AppTheme.accent, const Offset(200, 60), 0),
          _chip('50K+ Users', AppTheme.green, const Offset(220, 270), 1),
          _chip('Dart · Kotlin', AppTheme.amber, const Offset(-130, 100), 2),
          _chip('Noida, IN', AppTheme.pink, const Offset(-120, 260), 3),
          _chip('Clean Arch', AppTheme.purple, const Offset(40, -30), 4),
        ],
      ),
    );
  }

  Widget _buildPhotoCircle() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 248,
          height: 248,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: AppTheme.accent.withOpacity(0.25),
                  blurRadius: 40,
                  spreadRadius: 4),
            ],
          ),
        ),
        ClipOval(
          child: Container(
            width: 236,
            height: 236,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.accent, width: 2),
            ),
            child: Image.asset(
              'assets/images/profile.jpg',
              fit: BoxFit.cover,
              color: const Color(0x0D000000),
              colorBlendMode: BlendMode.darken,
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _scanCtrl,
          builder: (_, __) {
            return Positioned(
              top: _scanCtrl.value * 236,
              child: Container(
                width: 236,
                height: 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppTheme.accent.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        ..._buildBrackets(),
        Positioned(
          bottom: -10,
          right: -10,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.green),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _PulsingDot(color: AppTheme.green),
                const SizedBox(width: 6),
                Text('Available',
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 10, color: AppTheme.green)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildBrackets() {
    const size = 18.0;
    const thick = 2.0;
    const offset = 10.0;
    return [
      Positioned(
          top: offset,
          left: offset,
          child: _bracket(true, true, size, thick)),
      Positioned(
          top: offset,
          right: offset,
          child: _bracket(true, false, size, thick)),
      Positioned(
          bottom: offset,
          left: offset,
          child: _bracket(false, true, size, thick)),
      Positioned(
          bottom: offset,
          right: offset,
          child: _bracket(false, false, size, thick)),
    ];
  }

  Widget _bracket(bool top, bool left, double size, double thick) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _BracketPainter(top: top, left: left, thick: thick),
      ),
    );
  }

  Widget _chip(String label, Color color, Offset offset, int index) {
    return AnimatedBuilder(
      animation: _chipCtrl,
      builder: (_, __) {
        final bounce = sin(_chipCtrl.value * pi + index * 0.8) * 8;
        return Transform.translate(
          offset: Offset(offset.dx, offset.dy + bounce),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.surface.withOpacity(0.95),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: color.withOpacity(0.4), width: 1),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 12)
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: color)),
                const SizedBox(width: 5),
                Text(label,
                    style: GoogleFonts.jetBrainsMono(
                        fontSize: 10, color: color)),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Animated counting stat ─────────────────────────────────────────────────────
class _CountStat extends StatelessWidget {
  final int target;
  final String suffix;
  final String label;
  final Color color;
  final bool trigger;

  const _CountStat({
    required this.target,
    required this.suffix,
    required this.label,
    required this.color,
    required this.trigger,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: trigger ? target.toDouble() : 0),
          duration: const Duration(milliseconds: 1600),
          curve: Curves.easeOut,
          builder: (_, val, __) => Text(
            '${val.toInt()}$suffix',
            style: GoogleFonts.jetBrainsMono(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: color,
                height: 1),
          ),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: GoogleFonts.jetBrainsMono(
                fontSize: 10,
                color: AppTheme.textMuted,
                letterSpacing: 0.1)),
      ],
    );
  }
}

class _StaticStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final bool trigger;

  const _StaticStat(
      {required this.value,
      required this.label,
      required this.color,
      required this.trigger});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedOpacity(
          opacity: trigger ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 800),
          child: Text(
            value,
            style: GoogleFonts.jetBrainsMono(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: color,
                height: 1),
          ),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: GoogleFonts.jetBrainsMono(
                fontSize: 10,
                color: AppTheme.textMuted,
                letterSpacing: 0.1)),
      ],
    );
  }
}

class _PulsingDot extends StatefulWidget {
  final Color color;
  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _a = Tween(begin: 0.3, end: 1.0).animate(_c);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _a,
      builder: (_, __) => Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
          boxShadow: [
            BoxShadow(
                color: widget.color.withOpacity(_a.value * 0.6),
                blurRadius: 8,
                spreadRadius: 1)
          ],
        ),
      ),
    );
  }
}

class _BracketPainter extends CustomPainter {
  final bool top, left;
  final double thick;
  const _BracketPainter(
      {required this.top, required this.left, required this.thick});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.accent
      ..strokeWidth = thick
      ..style = PaintingStyle.stroke;
    final path = Path();
    if (top && left) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    }
    if (top && !left) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    }
    if (!top && left) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    }
    if (!top && !left) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BracketPainter old) => false;
}
