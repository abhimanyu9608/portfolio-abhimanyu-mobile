import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class NavBar extends StatefulWidget {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;

  const NavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _activeIndex = -1;
  bool _hireHovered = false;

  final _navItems = ['skills', 'experience', 'apps', 'education', 'contact'];

  void _scrollTo(int index) {
    final key = widget.sectionKeys[index];
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      color: AppTheme.bg.withOpacity(0.85),
      child: ClipRect(
        child: BackdropFilter(
          filter: ColorFilter.mode(Colors.transparent, BlendMode.srcOver),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppTheme.border)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                // Logo
                Text(
                  '{ AK.dev }',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.accent,
                    letterSpacing: 0.08,
                  ),
                ),
                const Spacer(),
                // Nav links (hidden on small screens)
                if (MediaQuery.of(context).size.width > 700)
                  ..._navItems.asMap().entries.map((e) {
                    return _NavLink(
                      label: e.value,
                      active: _activeIndex == e.key,
                      onTap: () {
                        setState(() => _activeIndex = e.key);
                        _scrollTo(e.key);
                      },
                    );
                  }),
                const SizedBox(width: 24),
                // Hire button
                MouseRegion(
                  onEnter: (_) => setState(() => _hireHovered = true),
                  onExit: (_) => setState(() => _hireHovered = false),
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => launchUrl(Uri.parse('mailto:abhik9608@gmail.com')),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                      decoration: BoxDecoration(
                        color: _hireHovered ? AppTheme.accent : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppTheme.accent),
                      ),
                      child: Text(
                        './hire_me',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          color: _hireHovered ? AppTheme.bg : AppTheme.accent,
                          letterSpacing: 0.08,
                        ),
                      ),
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

class _NavLink extends StatefulWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.active, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final highlighted = _hovered || widget.active;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.only(right: 28),
          padding: const EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: highlighted ? AppTheme.accent : Colors.transparent,
                width: 1,
              ),
            ),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 11,
              color: highlighted ? AppTheme.accent : AppTheme.textSecondary,
              letterSpacing: 0.06,
            ),
          ),
        ),
      ),
    );
  }
}
