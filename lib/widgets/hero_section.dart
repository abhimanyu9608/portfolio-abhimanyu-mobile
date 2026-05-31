import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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
  late AnimationController _blinkCtrl;
  bool _showCursor = true;

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
    _blinkCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) {
          setState(() => _showCursor = !_showCursor);
          _blinkCtrl.reset();
          _blinkCtrl.forward();
        }
      });
    _blinkCtrl.forward();
  }

  @override
  void dispose() {
    _ring1Ctrl.dispose();
    _ring2Ctrl.dispose();
    _ring3Ctrl.dispose();
    _scanCtrl.dispose();
    _chipCtrl.dispose();
    _blinkCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 900;

    return Container(
      constraints: const BoxConstraints(minHeight: 700),
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.06,
        vertical: 100,
      ),
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
                Expanded(flex: 4, child: Center(child: _buildPhotoOrbit())),
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
                    fontSize: 12, color: AppTheme.green, letterSpacing: 0.1)),
            Text(
              _showCursor ? '_' : ' ',
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 12, color: AppTheme.green),
            ),
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

        // Role
        RichText(
          text: TextSpan(
            style: GoogleFonts.jetBrainsMono(
                fontSize: 13,
                color: AppTheme.textSecondary,
                letterSpacing: 0.04),
            children: [
              TextSpan(
                  text: 'Senior ', style: TextStyle(color: AppTheme.accent)),
              const TextSpan(text: 'Flutter & Android Developer'),
            ],
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

        // Stats
        Row(
          children: [
            _stat('8+', 'Years', AppTheme.accent),
            const SizedBox(width: 36),
            _stat('20+', 'Live Apps', AppTheme.green),
            const SizedBox(width: 36),
            _stat('50K+', 'Users', AppTheme.amber),
            const SizedBox(width: 36),
            _stat('4.4★', 'Rating', AppTheme.pink),
          ],
        ).animate().fadeIn(delay: 600.ms),
        const SizedBox(height: 36),

        // Buttons
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            GlowButton(
              label: '✉  Get In Touch',
              onTap: () => launchUrl(Uri.parse('mailto:abhik9608@gmail.com')),
            ),
            GlowButton(
              label: '↗  LinkedIn',
              primary: false,
              onTap: () => launchUrl(Uri.parse(
                  'https://linkedin.com/in/abhimanyu-kumar-1768bb110')),
            ),
          ],
        ).animate().fadeIn(delay: 700.ms),
      ],
    );
  }

  Widget _stat(String value, String label, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: GoogleFonts.jetBrainsMono(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: color,
                height: 1)),
        const SizedBox(height: 4),
        Text(label,
            style: GoogleFonts.jetBrainsMono(
                fontSize: 10, color: AppTheme.textMuted, letterSpacing: 0.1)),
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
          // Ring 3
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
          // Ring 2
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
          // Ring 1 with dots
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
                            color: AppTheme.accent.withOpacity(0.2), width: 1),
                      ),
                    ),
                    // Top dot
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
                    // Bottom dot
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

          // Photo
          _buildPhotoCircle(),

          // Floating chips
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
        // Glow ring
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
        // Photo
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
        // Scan line
        AnimatedBuilder(
          animation: _scanCtrl,
          builder: (_, __) {
            final progress = _scanCtrl.value;
            return Positioned(
              top: progress * 236,
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
        // Corner brackets
        ..._buildBrackets(),
        // Status badge
        Positioned(
          bottom: -10,
          right: -10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.green),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PulsingDot(color: AppTheme.green),
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
          top: offset, left: offset, child: _bracket(true, true, size, thick)),
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.surface.withOpacity(0.95),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(0.4), width: 1),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 12)
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 5,
                    height: 5,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: color)),
                const SizedBox(width: 5),
                Text(label,
                    style:
                        GoogleFonts.jetBrainsMono(fontSize: 10, color: color)),
              ],
            ),
          ),
        );
      },
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
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 2))
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
