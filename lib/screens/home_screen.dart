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

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Stack(
        children: [
          // Matrix + Grid background (fixed)
          const Positioned.fill(child: MatrixBackground()),
          Positioned.fill(
            child: CustomPaint(painter: GridPainter()),
          ),

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
              // Fixed navbar
              NavBar(
                scrollController: _scrollCtrl,
                sectionKeys: [_skillsKey, _expKey, _appsKey, _eduKey, _contactKey],
              ),

              // Scrollable body
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollCtrl,
                  child: Column(
                    children: [
                      // Hero
                      const HeroSection(),

                      // Code marquee strip
                      const CodeMarquee(),

                      // Skills
                      Container(key: _skillsKey, child: const SkillsSection()),

                      // Experience
                      Container(key: _expKey, child: const ExperienceSection()),

                      // Apps
                      Container(key: _appsKey, child: const AppsSection()),

                      // Education
                      Container(key: _eduKey, child: const EducationSection()),

                      // Contact
                      Container(key: _contactKey, child: const ContactSection()),

                      // Footer
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: AppTheme.bg2,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© 2026  Abhimanyu Kumar · Senior Flutter Developer',
            style: GoogleFonts.jetBrainsMono(fontSize: 11, color: AppTheme.textMuted),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0x33185FA5),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0x3364B5F6)),
            ),
            child: Text(
              '◈ Built with Flutter Web',
              style: GoogleFonts.jetBrainsMono(fontSize: 10, color: const Color(0xFF64B5F6)),
            ),
          ),
        ],
      ),
    );
  }
}
