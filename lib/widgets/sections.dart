import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

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
              return SizedBox(
                width: _cardWidth(w),
                child: _SkillCard(data: e.value)
                    .animate(delay: (e.key * 80).ms)
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.3, end: 0),
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
          ],
        ),
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
            return _ExpItem(
              data: e.value,
              isFirst: e.key == 0,
              isLast: isLast,
            )
                .animate(delay: (e.key * 100).ms)
                .fadeIn(duration: 500.ms)
                .slideX(begin: 0.1, end: 0);
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
              return SizedBox(
                width: _cardWidth(w),
                child: _AppCard(data: e.value, accentColor: color)
                    .animate(delay: (e.key * 70).ms)
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.3, end: 0),
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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
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
          ],
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
