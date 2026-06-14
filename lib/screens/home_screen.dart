import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/matrix_background.dart';
import '../widgets/hero_section.dart';
import '../widgets/code_marquee.dart';
import '../widgets/nav_bar.dart';
import '../widgets/sections.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollCtrl = ScrollController();
  final _skillsKey = GlobalKey();
  final _expKey = GlobalKey();
  final _appsKey = GlobalKey();
  final _eduKey = GlobalKey();
  final _contactKey = GlobalKey();

  double _scrollProgress = 0.0;
  int _activeNavIndex = -1;

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_onScroll);
  }

  void _onScroll() {
    final pos = _scrollCtrl.position;
    final progress =
        pos.maxScrollExtent > 0 ? pos.pixels / pos.maxScrollExtent : 0.0;
    setState(() {
      _scrollProgress = progress.clamp(0.0, 1.0);
      _activeNavIndex = _computeActiveSection();
    });
  }

  int _computeActiveSection() {
    final keys = [_skillsKey, _expKey, _appsKey, _eduKey, _contactKey];
    int active = -1;
    for (int i = 0; i < keys.length; i++) {
      final ctx = keys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final top = box.localToGlobal(Offset.zero).dy;
      if (top <= 140) active = i;
    }
    return active;
  }

  @override
  void dispose() {
    _scrollCtrl.removeListener(_onScroll);
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Stack(
        children: [
          // Matrix + grid background
          const Positioned.fill(child: MatrixBackground()),
          Positioned.fill(child: CustomPaint(painter: GridPainter())),

          // Scanline overlay
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.05),
                      Colors.transparent,
                      Colors.black.withOpacity(0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Main content
          Column(
            children: [
              NavBar(
                scrollController: _scrollCtrl,
                sectionKeys: [
                  _skillsKey,
                  _expKey,
                  _appsKey,
                  _eduKey,
                  _contactKey
                ],
                activeIndex: _activeNavIndex,
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollCtrl,
                  child: Column(
                    children: [
                      const HeroSection(),
                      const CodeMarquee(),
                      const PhoneShowcaseSection(),
                      const ProcessSection(),
                      Container(key: _skillsKey, child: const SkillsSection()),
                      Container(key: _expKey, child: const ExperienceSection()),
                      Container(key: _appsKey, child: const AppsSection()),
                      Container(key: _eduKey, child: const EducationSection()),
                      Container(
                          key: _contactKey, child: const ContactSection()),
                      _buildFooter(w),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Scroll progress bar (top edge)
          Positioned(
            top: 0,
            left: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 40),
              height: 2,
              width: MediaQuery.of(context).size.width * _scrollProgress,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.accent, AppTheme.green, AppTheme.purple],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(double w) {
    return Container(
      color: AppTheme.bg2,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© 2026  Abhimanyu Kumar · Senior Flutter Developer',
            style: GoogleFonts.jetBrainsMono(
                fontSize: 11, color: AppTheme.textMuted),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0x33185FA5),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0x3364B5F6)),
            ),
            child: Text(
              '◈ Built with Flutter Web',
              style: GoogleFonts.jetBrainsMono(
                  fontSize: 10, color: const Color(0xFF64B5F6)),
            ),
          ),
        ],
      ),
    );
  }
}
