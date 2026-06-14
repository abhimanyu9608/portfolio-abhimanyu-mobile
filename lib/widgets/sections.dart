import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'package:visibility_detector/visibility_detector.dart';

// ─── SKILLS ───────────────────────────────────────────────────────────────────
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final skills = AppData.skills;

    return Container(
      color: AppTheme.bg2,
      padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(number: '01', title: 'Technical Skills')
              .animate()
              .fadeIn()
              .slideY(begin: 0.3, end: 0),
          const SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: skills.asMap().entries.map((e) {
              return RevealOnScroll(
                delay: Duration(milliseconds: e.key * 80),
                child: SizedBox(
                  width: _cardWidth(w),
                  child: _SkillCard(data: e.value),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  double _cardWidth(double w) {
    if (w > 1100) return (w * 0.88 - 32) / 3;
    if (w > 700) return (w * 0.88 - 16) / 2;
    return w * 0.88;
  }
}

class _SkillCard extends StatefulWidget {
  final Map<String, dynamic> data;
  const _SkillCard({required this.data});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final featured = List<String>.from(widget.data['featured'] ?? []);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered ? AppTheme.border2 : AppTheme.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                      color: AppTheme.accent.withOpacity(0.08), blurRadius: 30)
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppTheme.accentDim,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: AppTheme.border),
              ),
              child: Center(
                child: Text(
                  widget.data['icon'] ?? '',
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.data['label'] ?? '',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 10,
                color: AppTheme.accent,
                letterSpacing: 0.12,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: (widget.data['tags'] as List<dynamic>).map((t) {
                return TechTag(
                  label: t.toString(),
                  featured: featured.contains(t.toString()),
                );
              }).toList(),
            ),
            if ((widget.data['progress'] as double?) != null) ...[
              const SizedBox(height: 14),
              _SkillProgressBar(progress: widget.data['progress'] as double),
            ],
          ],
        ),
      ),
    );
  }
}

class _SkillProgressBar extends StatefulWidget {
  final double progress;
  const _SkillProgressBar({required this.progress});

  @override
  State<_SkillProgressBar> createState() => _SkillProgressBarState();
}

class _SkillProgressBarState extends State<_SkillProgressBar> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('skill_bar_${widget.progress}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('proficiency',
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 8, color: AppTheme.textMuted)),
              TweenAnimationBuilder<double>(
                tween: Tween(
                    begin: 0,
                    end: _visible ? widget.progress * 100 : 0),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOut,
                builder: (_, val, __) => Text(
                  '${val.toInt()}%',
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 8, color: AppTheme.accent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: AppTheme.bg3,
              borderRadius: BorderRadius.circular(2),
            ),
            child: TweenAnimationBuilder<double>(
              tween: Tween(
                  begin: 0, end: _visible ? widget.progress : 0),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOut,
              builder: (_, val, __) => FractionallySizedBox(
                widthFactor: val,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [AppTheme.accent, AppTheme.green]),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                          color: AppTheme.accent.withOpacity(0.4),
                          blurRadius: 6)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── EXPERIENCE ───────────────────────────────────────────────────────────────
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final exps = AppData.experience;

    return Container(
      color: AppTheme.bg,
      padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SectionHeader(number: '02', title: 'Experience')
              .animate()
              .fadeIn()
              .slideY(begin: 0.3, end: 0),
          const SizedBox(height: 40),
          ...exps.asMap().entries.map((e) {
            final isLast = e.key == exps.length - 1;
            return RevealOnScroll(
              delay: Duration(milliseconds: e.key * 100),
              slideFrom: const Offset(0.05, 0),
              child: _ExpItem(
                data: e.value,
                isFirst: e.key == 0,
                isLast: isLast,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ExpItem extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isFirst;
  final bool isLast;

  const _ExpItem({
    required this.data,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final isCurrent = data['current'] == true;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: dot + vertical line
        SizedBox(
          width: 30,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent ? AppTheme.accent : AppTheme.surface,
                  border: Border.all(color: AppTheme.accent, width: 2),
                  boxShadow: isCurrent
                      ? [
                          BoxShadow(
                            color: AppTheme.accent.withOpacity(0.5),
                            blurRadius: 12,
                          )
                        ]
                      : [],
                ),
              ),
              if (!isLast)
                Container(
                  width: 1,
                  height: 100,
                  color: AppTheme.border,
                ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Right: card
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: _ExpCard(data: data),
          ),
        ),
      ],
    );
  }
}

class _ExpCard extends StatefulWidget {
  final Map<String, dynamic> data;
  const _ExpCard({required this.data});

  @override
  State<_ExpCard> createState() => _ExpCardState();
}

class _ExpCardState extends State<_ExpCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tags = List<String>.from(widget.data['tags'] ?? []);
    final points = List<String>.from(widget.data['points'] ?? []);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hovered ? AppTheme.border2 : AppTheme.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Role + period
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.data['role'] ?? '',
                    style: GoogleFonts.syne(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.accentDim,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.border2),
                  ),
                  child: Text(
                    widget.data['period'] ?? '',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 10,
                      color: AppTheme.accent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Company
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.green,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '${widget.data['company']}'
                    '${widget.data['location'] != '' ? ' · ${widget.data['location']}' : ''}',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 11,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Bullet points
            ...points.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '\u25b8 ',
                        style: TextStyle(fontSize: 9, color: AppTheme.accent),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        p,
                        style: GoogleFonts.syne(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            // Tags
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: tags
                  .map(
                    (t) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppTheme.bg3,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: AppTheme.border),
                      ),
                      child: Text(
                        t,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 9,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── APPS ─────────────────────────────────────────────────────────────────────
class AppsSection extends StatelessWidget {
  const AppsSection({super.key});

  static const _accentColors = [
    AppTheme.accent,
    AppTheme.green,
    AppTheme.amber,
    AppTheme.pink,
    AppTheme.purple,
    AppTheme.accent,
    AppTheme.green,
    AppTheme.amber,
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final apps = AppData.apps;

    return Container(
      color: AppTheme.bg2,
      padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SectionHeader(number: '03', title: 'Live Applications')
              .animate()
              .fadeIn()
              .slideY(begin: 0.3, end: 0),
          const SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: apps.asMap().entries.map((e) {
              final color = _accentColors[e.key % _accentColors.length];
              return RevealOnScroll(
                delay: Duration(milliseconds: (e.key % 6) * 70),
                child: SizedBox(
                  width: _cardWidth(w),
                  child: _AppCard(data: e.value, accentColor: color),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  double _cardWidth(double w) {
    if (w > 1100) return (w * 0.88 - 32) / 3;
    if (w > 700) return (w * 0.88 - 16) / 2;
    return w * 0.88;
  }
}

class _AppCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final Color accentColor;
  const _AppCard({required this.data, required this.accentColor});

  @override
  State<_AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<_AppCard> {
  bool _hovered = false;
  double _tiltX = 0;
  double _tiltY = 0;

  void _onHover(PointerEvent event) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final local = box.globalToLocal(event.position);
    final size = box.size;
    setState(() {
      _tiltX = -(local.dy / size.height - 0.5) * 0.12;
      _tiltY = (local.dx / size.width - 0.5) * 0.12;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _tiltX = 0;
        _tiltY = 0;
      }),
      onHover: _onHover,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_tiltX)
          ..rotateY(_tiltY),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(24),
          transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? widget.accentColor.withOpacity(0.4)
                : AppTheme.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.4), blurRadius: 40)
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top colour bar on hover
            if (_hovered)
              Container(
                height: 2,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [widget.accentColor, Colors.transparent],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            // Icon + live badge
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: widget.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Center(
                    child: Text(
                      widget.data['icon'] ?? '',
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.green.withOpacity(0.25),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _PulsingDot(color: AppTheme.green),
                      const SizedBox(width: 4),
                      Text(
                        widget.data['rating'] == 'Live'
                            ? 'LIVE'
                            : 'LIVE \u00b7 ${widget.data['rating']}',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 9,
                          color: AppTheme.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.data['name'] ?? '',
              style: GoogleFonts.syne(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.data['desc'] ?? '',
              style: GoogleFonts.syne(
                fontSize: 12,
                color: AppTheme.textSecondary,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 14),
            const Divider(color: AppTheme.border, height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  widget.data['users'] ?? '',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    color: AppTheme.green,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.bg3,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Text(
                    'Android',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 9,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ),
              ],
            ),
            if ((widget.data['url'] as String? ?? '').isNotEmpty) ...[
              const SizedBox(height: 12),
              _PlayStoreButton(
                url: widget.data['url'] as String,
                accentColor: widget.accentColor,
              ),
            ],
          ],
        ),
        ),
      ),
    );
  }
}

class _PlayStoreButton extends StatefulWidget {
  final String url;
  final Color accentColor;
  const _PlayStoreButton({required this.url, required this.accentColor});

  @override
  State<_PlayStoreButton> createState() => _PlayStoreButtonState();
}

class _PlayStoreButtonState extends State<_PlayStoreButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(
          Uri.parse(widget.url),
          mode: LaunchMode.externalApplication,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.accentColor.withOpacity(0.12)
                : AppTheme.bg3,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: _hovered
                  ? widget.accentColor.withOpacity(0.5)
                  : AppTheme.border,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '▶',
                style: TextStyle(
                  fontSize: 9,
                  color: _hovered ? widget.accentColor : AppTheme.textMuted,
                ),
              ),
              const SizedBox(width: 7),
              Text(
                'View on Play Store',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  color: _hovered ? widget.accentColor : AppTheme.textMuted,
                  letterSpacing: 0.04,
                ),
              ),
            ],
          ),
        ),
      ),
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

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) => Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color,
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(_c.value * 0.8),
              blurRadius: 6,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── EDUCATION ────────────────────────────────────────────────────────────────
class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      color: AppTheme.bg,
      padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SectionHeader(number: '04', title: 'Education')
              .animate()
              .fadeIn()
              .slideY(begin: 0.3, end: 0),
          const SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: AppData.education.asMap().entries.map((e) {
              return SizedBox(
                width: _cardWidth(w),
                child: _EduCard(data: e.value)
                    .animate(delay: (e.key * 100).ms)
                    .fadeIn()
                    .slideY(begin: 0.3, end: 0),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  double _cardWidth(double w) {
    if (w > 900) return (w * 0.88 - 32) / 3;
    if (w > 600) return (w * 0.88 - 16) / 2;
    return w * 0.88;
  }
}

class _EduCard extends StatefulWidget {
  final Map<String, String> data;
  const _EduCard({required this.data});

  @override
  State<_EduCard> createState() => _EduCardState();
}

class _EduCardState extends State<_EduCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(22),
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered ? AppTheme.border2 : AppTheme.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.data['degree'] ?? '',
              style: GoogleFonts.syne(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.data['school'] ?? '',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 11,
                color: AppTheme.textMuted,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.data['score'] ?? '',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 14,
                color: AppTheme.accent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── CONTACT ──────────────────────────────────────────────────────────────────
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 800;

    return Container(
      color: AppTheme.bg2,
      padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SectionHeader(number: '05', title: 'Get In Touch')
              .animate()
              .fadeIn()
              .slideY(begin: 0.3, end: 0),
          const SizedBox(height: 48),
          if (isMobile) ...[
            _buildLinks(context),
            const SizedBox(height: 32),
            _buildAvailCard(context),
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildLinks(context)),
                const SizedBox(width: 48),
                Expanded(child: _buildAvailCard(context)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Actively looking for Senior Flutter & Android roles in Noida, Delhi NCR. "
          "8+ years, 20+ shipped apps, 50K+ users. Let's build something great.",
          style: GoogleFonts.syne(
            fontSize: 15,
            color: AppTheme.textSecondary,
            height: 1.85,
          ),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 32),
        _ContactLink(
          icon: '\u2709',
          label: 'abhik9608@gmail.com',
          url: 'mailto:abhik9608@gmail.com',
        ).animate(delay: 300.ms).fadeIn().slideX(begin: -0.1, end: 0),
        _ContactLink(
          icon: '\u260e',
          label: '+91 8766389395',
          url: 'tel:+918766389395',
        ).animate(delay: 380.ms).fadeIn().slideX(begin: -0.1, end: 0),
        _ContactLink(
          icon: 'in',
          label: 'linkedin/abhimanyu-kumar-1768bb110',
          url: 'https://linkedin.com/in/abhimanyu-kumar-1768bb110',
        ).animate(delay: 460.ms).fadeIn().slideX(begin: -0.1, end: 0),
        _ContactLink(
          icon: '\u{1F4CD}',
          label: 'Noida, Uttar Pradesh, India',
          url: '',
        ).animate(delay: 540.ms).fadeIn().slideX(begin: -0.1, end: 0),
      ],
    );
  }

  Widget _buildAvailCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _PulsingDot(color: AppTheme.green),
              const SizedBox(width: 8),
              Text(
                'Open to opportunities',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  color: AppTheme.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Senior / Lead Flutter Developer',
            style: GoogleFonts.syne(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Looking for product companies and MNCs with interesting mobile engineering challenges. '
            'Immediate joiner. Noida / Delhi NCR preferred.',
            style: GoogleFonts.syne(
              fontSize: 13,
              color: AppTheme.textSecondary,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              'Flutter / Dart',
              'Android Native',
              'Fintech',
              'Biometric / KYC',
              'BLoC \u00b7 Riverpod',
              'Team Lead',
            ]
                .map(
                  (t) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppTheme.bg3,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: Text(
                      t,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 10,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            child: GlowButton(
              label: '\u2709  Send a Message',
              onTap: () => launchUrl(Uri.parse('mailto:abhik9608@gmail.com')),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0);
  }
}

class _ContactLink extends StatefulWidget {
  final String icon, label, url;
  const _ContactLink({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

// ─── PROCESS ──────────────────────────────────────────────────────────────────
class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 800;
    final steps = AppData.process;

    return Container(
      color: AppTheme.bg2,
      padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          RevealOnScroll(
            child: const SectionHeader(number: '→', title: 'How I Build'),
          ),
          const SizedBox(height: 48),
          if (isMobile)
            Column(
              children: steps.asMap().entries.map((e) {
                return RevealOnScroll(
                  delay: Duration(milliseconds: e.key * 100),
                  child: _ProcessStep(
                      data: e.value, isLast: e.key == steps.length - 1),
                );
              }).toList(),
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: steps.asMap().entries.map((e) {
                return Expanded(
                  child: RevealOnScroll(
                    delay: Duration(milliseconds: e.key * 100),
                    child: _ProcessStep(
                        data: e.value,
                        isLast: e.key == steps.length - 1,
                        horizontal: true),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class _ProcessStep extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool isLast;
  final bool horizontal;

  const _ProcessStep(
      {required this.data, required this.isLast, this.horizontal = false});

  @override
  State<_ProcessStep> createState() => _ProcessStepState();
}

class _ProcessStepState extends State<_ProcessStep> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tags = List<String>.from(widget.data['tags'] ?? []);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Padding(
        padding: widget.horizontal
            ? const EdgeInsets.only(right: 12)
            : const EdgeInsets.only(bottom: 16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: _hovered ? AppTheme.surface2 : AppTheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered ? AppTheme.border2 : AppTheme.border,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                        color: AppTheme.accent.withOpacity(0.06),
                        blurRadius: 24)
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(widget.data['step'] ?? '',
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 10, color: AppTheme.accent)),
                  const Spacer(),
                  Text(widget.data['icon'] ?? '',
                      style: const TextStyle(fontSize: 20)),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.data['title'] ?? '',
                style: GoogleFonts.syne(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary),
              ),
              const SizedBox(height: 8),
              Text(
                widget.data['desc'] ?? '',
                style: GoogleFonts.syne(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                    height: 1.65),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: tags
                    .map((t) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppTheme.accentDim,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: AppTheme.border2),
                          ),
                          child: Text(t,
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 9, color: AppTheme.accent)),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── PHONE SHOWCASE ───────────────────────────────────────────────────────────
class PhoneShowcaseSection extends StatefulWidget {
  const PhoneShowcaseSection({super.key});

  @override
  State<PhoneShowcaseSection> createState() => _PhoneShowcaseSectionState();
}

class _PhoneShowcaseSectionState extends State<PhoneShowcaseSection>
    with TickerProviderStateMixin {
  late PageController _pageCtrl;
  late AnimationController _autoCtrl;
  int _currentPage = 0;

  static const _kCount = 5;
  static const _kColors = [
    Color(0xFF00D4FF),
    Color(0xFF00FF88),
    Color(0xFFFFAA00),
    Color(0xFFFF4488),
    Color(0xFFAA44FF),
  ];
  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController();
    _autoCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..addStatusListener((s) {
            if (s == AnimationStatus.completed && mounted) {
              final next = (_currentPage + 1) % _kCount;
              _pageCtrl.animateToPage(next,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
              setState(() => _currentPage = next);
              _autoCtrl.reset();
              _autoCtrl.forward();
            }
          });
    _autoCtrl.forward();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    _autoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 900;

    return Container(
      color: AppTheme.bg,
      padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: 80),
      child: isMobile
          ? Column(mainAxisSize: MainAxisSize.min, children: [
              _buildLabel(),
              const SizedBox(height: 48),
              _buildPhone(w),
            ])
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 5, child: _buildLabel()),
                const SizedBox(width: 40),
                Expanded(flex: 4, child: Center(child: _buildPhone(w))),
              ],
            ),
    );
  }

  Widget _buildLabel() {
    return RevealOnScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('// showcase',
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 11, color: AppTheme.accent, letterSpacing: 0.1)),
          const SizedBox(height: 12),
          ShaderMask(
            shaderCallback: (b) => const LinearGradient(
              colors: [Colors.white, AppTheme.accent],
            ).createShader(b),
            child: Text(
              'Apps That\nShip & Scale',
              style: GoogleFonts.syne(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.1),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '8 years of production mobile apps — fintech, digital identity, e-commerce, entertainment and enterprise.',
            style: GoogleFonts.syne(
                fontSize: 14,
                color: AppTheme.textSecondary,
                height: 1.8),
          ),
          const SizedBox(height: 24),
          // Dot indicators
          Row(
            children: List.generate(_kCount, (i) {
              return GestureDetector(
                onTap: () {
                  _pageCtrl.animateToPage(i,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                  setState(() => _currentPage = i);
                  _autoCtrl.reset();
                  _autoCtrl.forward();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(right: 8),
                  width: i == _currentPage ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == _currentPage
                        ? AppTheme.accent
                        : AppTheme.textMuted,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPhone(double w) {
    const phoneW = 240.0;
    const phoneH = 480.0;

    return RevealOnScroll(
      slideFrom: const Offset(0, 0.1),
      child: SizedBox(
        width: phoneW + 40,
        height: phoneH + 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Glow behind phone
            Container(
              width: phoneW,
              height: phoneH,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                boxShadow: [
                  BoxShadow(
                    color: _kColors[_currentPage].withOpacity(0.15),
                    blurRadius: 60,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
            // Phone body
            Container(
              width: phoneW,
              height: phoneH,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                color: AppTheme.surface,
                border: Border.all(
                  color: _kColors[_currentPage].withOpacity(0.35),
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(34),
                child: Column(
                  children: [
                    // Notch bar
                    Container(
                      height: 28,
                      color: AppTheme.surface2,
                      child: Center(
                        child: Container(
                          width: 60,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppTheme.bg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    // Screen
                    Expanded(
                      child: PageView.builder(
                        controller: _pageCtrl,
                        onPageChanged: (i) =>
                            setState(() => _currentPage = i),
                        itemCount: _kCount,
                        itemBuilder: (_, i) {
                          switch (i) {
                            case 0:
                              return const _DSCScreen();
                            case 1:
                              return const _ESignScreen();
                            case 2:
                              return const _OTPScreen();
                            case 3:
                              return const _FoodScreen();
                            default:
                              return const _TVScreen();
                          }
                        },
                      ),
                    ),
                    // Home bar
                    Container(
                      height: 24,
                      color: AppTheme.surface2,
                      child: Center(
                        child: Container(
                          width: 72,
                          height: 5,
                          decoration: BoxDecoration(
                            color: AppTheme.textMuted,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Side button
            Positioned(
              right: 10,
              top: 120,
              child: Container(
                  width: 3,
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppTheme.surface3,
                      borderRadius: BorderRadius.circular(2))),
            ),
          ],
        ),
      ),
    );
  }

}

// ──────────────────── Phone showcase: shared helpers ──────────────────────────

Widget _psStatusBar() => Padding(
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('9:41',
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 7, color: AppTheme.textMuted)),
          Row(children: [
            Icon(Icons.signal_cellular_alt,
                size: 8, color: AppTheme.textMuted),
            const SizedBox(width: 2),
            Icon(Icons.wifi, size: 8, color: AppTheme.textMuted),
            const SizedBox(width: 2),
            Icon(Icons.battery_full, size: 8, color: AppTheme.textMuted),
          ]),
        ],
      ),
    );

Widget _psHeader(String icon, String title, Color color) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [color.withOpacity(0.18), color.withOpacity(0.04)]),
      ),
      child: Row(children: [
        Text(icon, style: const TextStyle(fontSize: 13)),
        const SizedBox(width: 6),
        Text(title,
            style: GoogleFonts.syne(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary)),
        const Spacer(),
        CircleAvatar(
          radius: 9,
          backgroundColor: color.withOpacity(0.2),
          child: Text('A',
              style:
                  GoogleFonts.jetBrainsMono(fontSize: 7, color: color)),
        ),
      ]),
    );

Widget _psBottomNav(
        List<IconData> icons, int active, Color color) =>
    Container(
      height: 34,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        border: Border(top: BorderSide(color: AppTheme.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: icons
            .asMap()
            .entries
            .map((e) => Icon(e.value,
                size: 14,
                color: e.key == active ? color : AppTheme.textMuted))
            .toList(),
      ),
    );

// ──────────────────── Screen 1: Capricorn DSC Portal ─────────────────────────

class _DSCScreen extends StatelessWidget {
  const _DSCScreen();

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF00D4FF);
    return Container(
      color: AppTheme.bg,
      child: Column(
        children: [
          _psStatusBar(),
          _psHeader('📋', 'DSC Portal', color),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status card
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: color.withOpacity(0.3)),
                    ),
                    child: Row(children: [
                      Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.green)),
                      const SizedBox(width: 6),
                      Text('DSC Status',
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 7.5,
                              color: AppTheme.textMuted)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: AppTheme.greenDim,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('Active ✓',
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 7,
                                color: AppTheme.green)),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  Text('Application Progress',
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 7, color: AppTheme.textMuted)),
                  const SizedBox(height: 7),
                  // Stepper
                  Row(children: [
                    _step('Doc', color),
                    Expanded(
                        child: Container(
                            height: 1,
                            margin: const EdgeInsets.only(bottom: 12),
                            color: color.withOpacity(0.5))),
                    _step('KYC', color),
                    Expanded(
                        child: Container(
                            height: 1,
                            margin: const EdgeInsets.only(bottom: 12),
                            color: color.withOpacity(0.5))),
                    _step('Pay', color),
                    Expanded(
                        child: Container(
                            height: 1,
                            margin: const EdgeInsets.only(bottom: 12),
                            color: color.withOpacity(0.5))),
                    _step('DSC', color),
                  ]),
                  const SizedBox(height: 10),
                  // Payment card
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.surface2,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Payment Summary',
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 7,
                                color: AppTheme.textMuted)),
                        const SizedBox(height: 3),
                        Text('₹ 1,200.00',
                            style: GoogleFonts.syne(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textPrimary)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                color: color.withOpacity(0.3)),
                          ),
                          child: Text('via RazorPay',
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 7, color: color)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // CTA
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [color, color.withOpacity(0.7)]),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                        child: Text('View Certificate  →',
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.bg))),
                  ),
                ],
              ),
            ),
          ),
          _psBottomNav([
            Icons.home_rounded,
            Icons.badge_rounded,
            Icons.payment_rounded,
            Icons.person_rounded
          ], 1, color),
        ],
      ),
    );
  }

  Widget _step(String label, Color color) => Column(children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: Border.all(color: color)),
          child: const Icon(Icons.check, size: 10, color: AppTheme.bg),
        ),
        const SizedBox(height: 2),
        Text(label,
            style: GoogleFonts.jetBrainsMono(fontSize: 6, color: color)),
      ]);
}

// ──────────────────── Screen 2: eSign.Digital ────────────────────────────────

class _ESignScreen extends StatelessWidget {
  const _ESignScreen();

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF00FF88);
    return Container(
      color: AppTheme.bg,
      child: Column(
        children: [
          _psStatusBar(),
          _psHeader('✍️', 'eSign.Digital', color),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Document preview
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AGREEMENT.pdf',
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 7, color: color)),
                        const SizedBox(height: 7),
                        ...[0.95, 0.80, 0.90, 0.65, 0.85, 0.70]
                            .map((w) => Container(
                                  height: 5,
                                  margin:
                                      const EdgeInsets.only(bottom: 4),
                                  child: FractionallySizedBox(
                                    widthFactor: w,
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppTheme.textMuted
                                            .withOpacity(0.25),
                                        borderRadius:
                                            BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Aadhaar badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(6),
                      border:
                          Border.all(color: color.withOpacity(0.4)),
                    ),
                    child: Row(children: [
                      const Text('🇮🇳',
                          style: TextStyle(fontSize: 10)),
                      const SizedBox(width: 5),
                      Text('AADHAAR VERIFIED ✓',
                          style: GoogleFonts.jetBrainsMono(
                              fontSize: 7.5,
                              fontWeight: FontWeight.w700,
                              color: color)),
                    ]),
                  ),
                  const SizedBox(height: 8),
                  Text('Sign with',
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 7, color: AppTheme.textMuted)),
                  const SizedBox(height: 5),
                  Row(children: [
                    _authChip('Face ID', '👁', color, true),
                    const SizedBox(width: 5),
                    _authChip('Finger', '⌤', color, false),
                    const SizedBox(width: 5),
                    _authChip('IRIS', '◉', color, false),
                  ]),
                  const Spacer(),
                  // Sign CTA
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [color, color.withOpacity(0.7)]),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: color.withOpacity(0.3),
                            blurRadius: 12)
                      ],
                    ),
                    child: Center(
                        child: Text('✍  Sign Document',
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.bg))),
                  ),
                ],
              ),
            ),
          ),
          _psBottomNav([
            Icons.home_rounded,
            Icons.description_rounded,
            Icons.history_rounded,
            Icons.person_rounded
          ], 1, color),
        ],
      ),
    );
  }

  Widget _authChip(
      String label, String icon, Color color, bool active) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: active
              ? color.withOpacity(0.15)
              : AppTheme.surface2,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: active
                  ? color.withOpacity(0.5)
                  : AppTheme.border),
        ),
        child: Column(children: [
          Text(icon,
              style: TextStyle(
                  fontSize: 12,
                  color:
                      active ? color : AppTheme.textMuted)),
          const SizedBox(height: 2),
          Text(label,
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 5.5,
                  color: active ? color : AppTheme.textMuted)),
        ]),
      ),
    );
  }
}

// ──────────────────── Screen 3: AuthTech OTP (animated) ──────────────────────

class _OTPScreen extends StatefulWidget {
  const _OTPScreen();

  @override
  State<_OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<_OTPScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  static const _accounts = [
    ['G', 'Google (Work)', '483 291'],
    ['A', 'Anthropic', '716 834'],
    ['M', 'Microsoft', '952 047'],
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 30))
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFFFAA00);
    return Container(
      color: AppTheme.bg,
      child: Column(
        children: [
          _psStatusBar(),
          _psHeader('🔐', 'AuthTech', color),
          // Animated OTP ring
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (_, __) {
                final progress = 1.0 - (_ctrl.value % 1.0);
                return CustomPaint(
                  size: const Size(86, 86),
                  painter: _OTPRingPainter(progress, color),
                  child: SizedBox(
                    width: 86,
                    height: 86,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('483 291',
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: color,
                                  letterSpacing: 3)),
                          Text('${(progress * 30).toInt()}s',
                              style: GoogleFonts.jetBrainsMono(
                                  fontSize: 7,
                                  color: AppTheme.textMuted)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Account list
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: _accounts
                    .map((a) => Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: AppTheme.surface,
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: AppTheme.border),
                          ),
                          child: Row(children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: color.withOpacity(0.15),
                                border: Border.all(
                                    color: color.withOpacity(0.3)),
                              ),
                              child: Center(
                                  child: Text(a[0],
                                      style: GoogleFonts.jetBrainsMono(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                          color: color))),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Text(a[1],
                                    style: GoogleFonts.jetBrainsMono(
                                        fontSize: 7.5,
                                        color:
                                            AppTheme.textSecondary))),
                            Text(a[2],
                                style: GoogleFonts.jetBrainsMono(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.textPrimary,
                                    letterSpacing: 2)),
                          ]),
                        ))
                    .toList(),
              ),
            ),
          ),
          _psBottomNav([
            Icons.lock_rounded,
            Icons.add_circle_outline_rounded,
            Icons.settings_rounded,
          ], 0, color),
        ],
      ),
    );
  }
}

class _OTPRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  const _OTPRingPainter(this.progress, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2 - 5;
    canvas.drawCircle(
        c,
        r,
        Paint()
          ..color = AppTheme.border
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5);
    canvas.drawArc(
        Rect.fromCircle(center: c, radius: r),
        -3.14159 / 2,
        2 * 3.14159 * progress,
        false,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(_OTPRingPainter old) =>
      old.progress != progress;
}

// ──────────────────── Screen 4: My Menu – Food Ordering ──────────────────────

class _FoodScreen extends StatelessWidget {
  const _FoodScreen();

  static const _cats = [
    ['🍕', 'Pizza'],
    ['🍜', 'Noodles'],
    ['🌮', 'Tacos'],
    ['🍛', 'Curry'],
    ['🍣', 'Sushi'],
  ];
  static const _restaurants = [
    ['Spice Garden', '4.6', '1.2 km', '20 min'],
    ['The Food Hub', '4.4', '0.8 km', '15 min'],
  ];

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFFF4488);
    return Container(
      color: AppTheme.bg,
      child: Column(
        children: [
          _psStatusBar(),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                color.withOpacity(0.18),
                color.withOpacity(0.04)
              ]),
            ),
            child: Row(children: [
              const Text('🍽️', style: TextStyle(fontSize: 13)),
              const SizedBox(width: 6),
              Text('My Menu',
                  style: GoogleFonts.syne(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary)),
              const Spacer(),
              Icon(Icons.location_on_rounded, size: 10, color: color),
              Text('Noida',
                  style: GoogleFonts.jetBrainsMono(
                      fontSize: 7.5, color: color)),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category chips
                  SizedBox(
                    height: 52,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _cats.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 6),
                      itemBuilder: (_, i) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: i == 0
                              ? color.withOpacity(0.12)
                              : AppTheme.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: i == 0
                                  ? color.withOpacity(0.5)
                                  : AppTheme.border),
                        ),
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(_cats[i][0],
                                style:
                                    const TextStyle(fontSize: 14)),
                            Text(_cats[i][1],
                                style: GoogleFonts.jetBrainsMono(
                                    fontSize: 6,
                                    color: i == 0
                                        ? color
                                        : AppTheme.textMuted)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Nearby',
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 7.5,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textSecondary)),
                  const SizedBox(height: 6),
                  ..._restaurants
                      .map((r) => Container(
                            margin: const EdgeInsets.only(bottom: 7),
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              color: AppTheme.surface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: AppTheme.border),
                            ),
                            child: Row(children: [
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.12),
                                  borderRadius:
                                      BorderRadius.circular(6),
                                ),
                                child: const Center(
                                    child: Text('🏪',
                                        style:
                                            TextStyle(fontSize: 16))),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(r[0],
                                        style: GoogleFonts.syne(
                                            fontSize: 9,
                                            fontWeight:
                                                FontWeight.w700,
                                            color: AppTheme
                                                .textPrimary)),
                                    Row(children: [
                                      Icon(Icons.star_rounded,
                                          size: 9,
                                          color: const Color(
                                              0xFFFFAA00)),
                                      const SizedBox(width: 2),
                                      Text(
                                          '${r[1]} · ${r[2]} · ${r[3]}',
                                          style: GoogleFonts
                                              .jetBrainsMono(
                                                  fontSize: 6.5,
                                                  color: AppTheme
                                                      .textMuted)),
                                    ]),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 3),
                                decoration: BoxDecoration(
                                  color:
                                      color.withOpacity(0.12),
                                  borderRadius:
                                      BorderRadius.circular(5),
                                  border: Border.all(
                                      color:
                                          color.withOpacity(0.3)),
                                ),
                                child: Text('Order',
                                    style: GoogleFonts.jetBrainsMono(
                                        fontSize: 6.5,
                                        fontWeight: FontWeight.w700,
                                        color: color)),
                              ),
                            ]),
                          ))
                      .toList(),
                  const SizedBox(height: 2),
                  Container(
                    height: 28,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [color, color.withOpacity(0.7)]),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                        child: Text('⊡  Scan Table QR',
                            style: GoogleFonts.jetBrainsMono(
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                                color: Colors.white))),
                  ),
                ],
              ),
            ),
          ),
          _psBottomNav([
            Icons.home_rounded,
            Icons.search_rounded,
            Icons.receipt_long_rounded,
            Icons.person_rounded
          ], 0, color),
        ],
      ),
    );
  }
}

// ──────────────────── Screen 5: SDSS – Android TV Signage ────────────────────

class _TVScreen extends StatelessWidget {
  const _TVScreen();

  static const _schedule = [
    ['10:45 PM', 'Brand_Promo_HD.mp4', '2:30'],
    ['10:48 PM', 'Product_Launch.mp4', '1:45'],
    ['10:50 PM', 'Awareness_Loop.mp4', '3:00'],
  ];

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFFAA44FF);
    return Container(
      color: AppTheme.bg,
      child: Column(
        children: [
          _psStatusBar(),
          _psHeader('🖥️', 'SDSS · Signage', color),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Now playing
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        color.withOpacity(0.2),
                        color.withOpacity(0.05)
                      ]),
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: color.withOpacity(0.4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                                color: color,
                                borderRadius:
                                    BorderRadius.circular(3)),
                            child: Text('▶ LIVE',
                                style: GoogleFonts.jetBrainsMono(
                                    fontSize: 6.5,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                              child: Text(
                                  'Store_Campaign_V2.mp4',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.jetBrainsMono(
                                      fontSize: 7.5,
                                      color:
                                          AppTheme.textPrimary))),
                        ]),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: 0.63,
                            minHeight: 5,
                            backgroundColor: AppTheme.surface2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(color),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text('1:32',
                                  style: GoogleFonts.jetBrainsMono(
                                      fontSize: 6.5,
                                      color: AppTheme.textMuted)),
                              Text('63%',
                                  style: GoogleFonts.jetBrainsMono(
                                      fontSize: 6.5, color: color)),
                              Text('2:28',
                                  style: GoogleFonts.jetBrainsMono(
                                      fontSize: 6.5,
                                      color: AppTheme.textMuted)),
                            ]),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Up Next',
                      style: GoogleFonts.jetBrainsMono(
                          fontSize: 7.5,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textSecondary)),
                  const SizedBox(height: 6),
                  ..._schedule
                      .map((s) => Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppTheme.surface,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: AppTheme.border),
                            ),
                            child: Row(children: [
                              SizedBox(
                                width: 38,
                                child: Text(s[0],
                                    style: GoogleFonts.jetBrainsMono(
                                        fontSize: 6, color: color)),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                  child: Text(s[1],
                                      overflow:
                                          TextOverflow.ellipsis,
                                      style: GoogleFonts.jetBrainsMono(
                                          fontSize: 7,
                                          color: AppTheme
                                              .textSecondary))),
                              Text(s[2],
                                  style: GoogleFonts.jetBrainsMono(
                                      fontSize: 6.5,
                                      color: AppTheme.textMuted)),
                            ]),
                          ))
                      .toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactLinkState extends State<_ContactLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: widget.url.isNotEmpty
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: widget.url.isNotEmpty
              ? () => launchUrl(Uri.parse(widget.url))
              : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            transform: Matrix4.translationValues(_hovered ? 6 : 0, 0, 0),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _hovered ? AppTheme.accent : AppTheme.border,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppTheme.accentDim,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Center(
                    child: Text(
                      widget.icon,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        color: AppTheme.accent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    widget.label,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 11,
                      color:
                          _hovered ? AppTheme.accent : AppTheme.textSecondary,
                      letterSpacing: 0.04,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
