import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String number;
  final String title;

  const SectionHeader({super.key, required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '// $number',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 12,
            color: AppTheme.accent,
            letterSpacing: 0.12,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: GoogleFonts.syne(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.border2, Colors.transparent],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TechTag extends StatefulWidget {
  final String label;
  final bool featured;

  const TechTag({super.key, required this.label, this.featured = false});

  @override
  State<TechTag> createState() => _TechTagState();
}

class _TechTagState extends State<TechTag> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: _hovered || widget.featured
              ? AppTheme.accentDim
              : AppTheme.bg3,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: _hovered || widget.featured
                ? AppTheme.border2
                : AppTheme.border,
          ),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 10,
            color: _hovered || widget.featured
                ? AppTheme.accent
                : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}

class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Offset slideFrom;
  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.slideFrom = const Offset(0, 0.12),
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: widget.slideFrom, end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('reveal_${widget.hashCode}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.08 && !_triggered) {
          _triggered = true;
          Future.delayed(widget.delay, () {
            if (mounted) _ctrl.forward();
          });
        }
      },
      child: FadeTransition(
        opacity: _opacity,
        child: SlideTransition(position: _slide, child: widget.child),
      ),
    );
  }
}

class GlowButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool primary;

  const GlowButton({
    super.key,
    required this.label,
    this.onTap,
    this.primary = true,
  });

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13),
          decoration: BoxDecoration(
            color: widget.primary
                ? (_hovered ? const Color(0xFF33DDFF) : AppTheme.accent)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: widget.primary
                ? null
                : Border.all(
                    color: _hovered ? AppTheme.accent : AppTheme.border2,
                  ),
            boxShadow: widget.primary
                ? [
                    BoxShadow(
                      color: AppTheme.accent.withOpacity(_hovered ? 0.5 : 0.3),
                      blurRadius: _hovered ? 40 : 20,
                    )
                  ]
                : null,
          ),
          child: Transform.translate(
            offset: Offset(0, _hovered ? -2 : 0),
            child: Text(
              widget.label,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: widget.primary
                    ? AppTheme.bg
                    : (_hovered ? AppTheme.accent : AppTheme.textPrimary),
                letterSpacing: 0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
