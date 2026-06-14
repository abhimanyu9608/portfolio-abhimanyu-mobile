import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const bg = Color(0xFF060610);
  static const bg2 = Color(0xFF080816);
  static const bg3 = Color(0xFF0C0C1E);
  static const surface = Color(0xFF0F0F24);
  static const surface2 = Color(0xFF13132C);
  static const surface3 = Color(0xFF171734);

  static const accent = Color(0xFF00D4FF);
  static const accentDim = Color(0x1A00D4FF);
  static const green = Color(0xFF00FF88);
  static const greenDim = Color(0x1A00FF88);
  static const amber = Color(0xFFFFAA00);
  static const pink = Color(0xFFFF4488);
  static const purple = Color(0xFFAA44FF);

  static const textPrimary = Color(0xFFEEF2FF);
  static const textSecondary = Color(0xFF8892B0);
  static const textMuted = Color(0xFF3D4A6B);

  static const border = Color(0x1A00D4FF);
  static const border2 = Color(0x4000D4FF);

  // Text styles
  static TextStyle get mono => GoogleFonts.jetBrainsMono();
  static TextStyle get display => GoogleFonts.syne();

  static ThemeData get theme => ThemeData(
    scaffoldBackgroundColor: bg,
    colorScheme: const ColorScheme.dark(
      primary: accent,
      secondary: green,
      surface: surface,
    ),
    textTheme: GoogleFonts.syneTextTheme(
      ThemeData.dark().textTheme,
    ).apply(bodyColor: textPrimary, displayColor: textPrimary),
    useMaterial3: true,
  );
}

class AppData {
  static const name = 'Abhimanyu Kumar';
  static const role = 'Senior Flutter & Android Developer';
  static const location = 'Noida, India';
  static const email = 'abhik9608@gmail.com';
  static const phone = '+91-8766389395';
  static const linkedin = 'https://linkedin.com/in/abhimanyu-kumar-1768bb110';
  static const yearsExp = '8+';
  static const totalApps = '20+';
  static const totalUsers = '50K+';
  static const rating = '4.4★';

  static const List<Map<String, dynamic>> skills = [
    {
      'icon': '📱',
      'label': 'Mobile',
      'tags': ['Flutter', 'Dart', 'Android Native', 'Kotlin', 'Java', 'Android TV', 'Flutter Web'],
      'featured': ['Flutter', 'Dart', 'Kotlin'],
    },
    {
      'icon': '⚡',
      'label': 'State Management',
      'tags': ['BLoC', 'Riverpod', 'Provider', 'GetX', 'setState', 'Clean Architecture', 'MVVM'],
      'featured': ['BLoC', 'Riverpod', 'Clean Architecture'],
    },
    {
      'icon': '🔗',
      'label': 'Backend & APIs',
      'tags': ['REST APIs', 'Firebase FCM', 'Firestore', 'Firebase Auth', 'GraphQL', 'Dio', 'Sinch SDK'],
      'featured': ['REST APIs', 'Firestore'],
    },
    {
      'icon': '💳',
      'label': 'Payments',
      'tags': ['RazorPay', 'Paytm', 'Stripe', 'PayPal'],
      'featured': ['RazorPay'],
    },
    {
      'icon': '🛠',
      'label': 'DevTools & CI/CD',
      'tags': ['Android Studio', 'VS Code', 'Git', 'Bitbucket', 'Jira', 'CI/CD', 'Play Console'],
      'featured': ['Git', 'CI/CD'],
    },
    {
      'icon': '🧪',
      'label': 'Testing & Methods',
      'tags': ['Unit Testing', 'Widget Testing', 'Integration Testing', 'Null Safety', 'Agile/Scrum', 'Platform Channels'],
      'featured': ['Agile/Scrum'],
    },
  ];

  static const List<Map<String, dynamic>> experience = [
    {
      'role': 'Senior Flutter Developer',
      'company': 'Capricorn Identity Services Pvt. Ltd.',
      'location': 'Noida',
      'period': 'Apr 2021 – Present',
      'current': true,
      'points': [
        'Led end-to-end development of Capricorn Customer App — DSC app with KYC video verification, real-time tracking & RazorPay. 50,000+ users, 4.4★ Play Store.',
        'Architected eSign.Digital — Aadhaar-based paperless signing with Face, Fingerprint & IRIS auth. IT Act Sections 3 & 5 compliant. 20,000+ enterprise users in 6 months.',
        'Shipped 5 additional live apps: Capricorn DSC Channel, AuthTech Authenticator, Locker.Digital, Fetch, One eSimplified.',
        'End-to-end encryption, Aadhaar API integrations, biometric flows. Mentored junior devs. Zero critical post-release defects.',
      ],
      'tags': ['Flutter', 'Dart', 'BLoC', 'Aadhaar API', 'Biometric', 'RazorPay', 'Firebase', 'MVVM', 'CI/CD'],
    },
    {
      'role': 'Flutter Developer',
      'company': 'Ajath Infotech Pvt. Ltd.',
      'location': '',
      'period': 'Jan 2021 – Mar 2021',
      'current': false,
      'points': [
        'Developed Flutter UI for Purpletok — social/content platform — integrating REST APIs and external data sources.',
        'Managed application dependencies; collaborated with backend teams to define and consume API contracts.',
      ],
      'tags': ['Flutter', 'REST APIs', 'Social Platform'],
    },
    {
      'role': 'Android / Flutter Developer',
      'company': 'Mobiloitte Technologies Pvt. Ltd.',
      'location': '',
      'period': 'Aug 2020 – Oct 2020',
      'current': false,
      'points': [
        'Developed Taju – Language Learning and Orbital Installation Technologies apps using Flutter and Android.',
        'Resolved performance bottlenecks and production bugs; integrated third-party APIs.',
      ],
      'tags': ['Flutter', 'Android', 'Performance'],
    },
    {
      'role': 'Android Developer',
      'company': 'Altsols IT Services Pvt. Ltd.',
      'location': '',
      'period': 'May 2018 – Jun 2020',
      'current': false,
      'points': [
        'Built 7 native Android apps — Altsols, Desi Apps, Wrist Trust, My Menu, Loadaccess, AMS, SDSS — all on Google Play.',
        'Integrated Android Leanback for Android TV experience. Maintained client-facing relationships.',
      ],
      'tags': ['Android Native', 'Java', 'Kotlin', 'Android TV', 'Leanback'],
    },
    {
      'role': 'Android Developer',
      'company': 'NuSys Technologies',
      'location': '',
      'period': 'Mar 2017 – Mar 2018',
      'current': false,
      'points': [
        'Delivered 6 live apps: Touch and Glow, Indian Brasserie, Green Steams, My Nextra-Online TV, Restrobar Pro.',
        'Integrated Live TV, Paytm, Stripe, Google Maps, Sinch SDK voice calls, GCM/FCM push notifications.',
      ],
      'tags': ['Android', 'Paytm', 'Stripe', 'Sinch SDK', 'FCM', 'Google Maps'],
    },
  ];

  static const List<Map<String, dynamic>> apps = [
    // ── Capricorn Identity Services ──────────────────────────────────────────
    {
      'icon': '📋', 'name': 'Capricorn Customer App',
      'desc': 'Full-cycle DSC app: document upload, KYC video verification, real-time tracking, RazorPay payments.',
      'users': '50,000+ users', 'rating': '4.4★', 'color': 0xFF00D4FF,
      'url': 'https://play.google.com/store/apps/details?id=dscenrollment.capricorn.com.capturevideodsc',
    },
    {
      'icon': '✍️', 'name': 'eSign.Digital',
      'desc': 'Aadhaar-based paperless signing with Face, Fingerprint & IRIS biometric auth. IT Act compliant.',
      'users': '20,000+ enterprise', 'rating': 'Live', 'color': 0xFF00FF88,
      'url': 'https://play.google.com/store/apps/details?id=com.capricorn.esign.digital',
    },
    {
      'icon': '🔐', 'name': 'AuthTech Authenticator',
      'desc': 'Two-factor authentication with multi-factor biometric support and enterprise-grade security.',
      'users': 'Google Play', 'rating': 'Live', 'color': 0xFFFFAA00,
      'url': 'https://play.google.com/store/apps/details?id=com.ca.capricorn_authenticator',
    },
    {
      'icon': '🔒', 'name': 'Locker.Digital',
      'desc': 'File encryption & digital locker. End-to-end encryption with advanced security protocols.',
      'users': 'Google Play', 'rating': 'Live', 'color': 0xFFFF4488,
      'url': 'https://play.google.com/store/apps/details?id=com.locker.digital',
    },
    {
      'icon': '📡', 'name': 'Capricorn DSC Channel',
      'desc': 'DSC channel management and workflow automation for enterprise digital certificate handling.',
      'users': 'Google Play', 'rating': 'Live', 'color': 0xFFAA44FF,
      'url': 'https://play.google.com/store/apps/details?id=productcaller.caller.capricorn.CapricornDSCChannel',
    },
    // ── Ajath Infotech ───────────────────────────────────────────────────────
    {
      'icon': '🌐', 'name': 'Purpletok',
      'desc': 'Social content platform with Flutter UI, REST API integration and real-time content delivery.',
      'users': 'Social · Content', 'rating': 'Live', 'color': 0xFF00D4FF,
    },
    // ── Altsols IT Services ──────────────────────────────────────────────────
    {
      'icon': '💼', 'name': 'Altsols',
      'desc': 'Company app for Altsols IT Services covering web design, Android/iOS development and digital marketing.',
      'users': 'Google Play', 'rating': 'Live', 'color': 0xFF00FF88,
    },
    {
      'icon': '🏪', 'name': 'Desi Apps',
      'desc': 'Cloud-based marketplace connecting real estate advisors, event providers, retailers and wholesalers.',
      'users': 'Google Play', 'rating': 'Live', 'color': 0xFFFFAA00,
      'url': 'https://play.google.com/store/apps/details?id=in.altsols.desiapps',
    },
    {
      'icon': '⌚', 'name': 'Wrist Trust',
      'desc': 'Luxury watch registry for individual and commercial users — report lost, mark found, manage collections.',
      'users': 'Google Play', 'rating': 'Live', 'color': 0xFFFF4488,
    },
    {
      'icon': '🍽️', 'name': 'My Menu',
      'desc': 'Restaurant discovery with QR menu scanning, dine-in/takeaway orders, map view and user reviews.',
      'users': 'Google Play', 'rating': 'Live', 'color': 0xFFAA44FF,
    },
    {
      'icon': '🚛', 'name': 'Loadaccess',
      'desc': 'Logistics app with location/lane searches, GPS tracking, document generation and order management.',
      'users': 'Google Play', 'rating': 'Live', 'color': 0xFF00D4FF,
    },
    {
      'icon': '📊', 'name': 'AMS',
      'desc': 'ERP asset management with barcode scanning, multi-role access (admin/manager/user) and request workflows.',
      'users': 'Google Play', 'rating': 'Live', 'color': 0xFF00FF88,
    },
    {
      'icon': '🖥️', 'name': 'SDSS',
      'desc': 'Android TV digital signage app with credential-based login, daily schedules and ExoPlayer playlists.',
      'users': 'Android TV', 'rating': 'Live', 'color': 0xFFFFAA00,
    },
    // ── NuSys Technologies ───────────────────────────────────────────────────
    {
      'icon': '🚗', 'name': 'Touch and Glow',
      'desc': 'Car wash service booking app with FCM push notifications and email alerts for service centers.',
      'users': 'Google Play', 'rating': 'Live', 'color': 0xFFFF4488,
    },
    {
      'icon': '🍛', 'name': 'Indian Brasserie',
      'desc': 'Australian restaurant food ordering app with FCM push notifications and Google Maven integration.',
      'users': 'Google Play', 'rating': 'Live', 'color': 0xFFAA44FF,
      'url': 'https://play.google.com/store/apps/details?id=au.com.indianbrasserie',
    },
    {
      'icon': '🧹', 'name': 'Green Steams',
      'desc': 'On-demand car wash (Ola-inspired) with Stripe payments, GPS tracking and dual provider/customer modes.',
      'users': 'Google Play', 'rating': 'Live', 'color': 0xFF00D4FF,
    },
    {
      'icon': '📺', 'name': 'My Nextra – Online TV',
      'desc': 'Broadband TV app with live channels, CCTV, Paytm payments, AdMob, FCM and Sinch SDK voice calls.',
      'users': 'Google Play', 'rating': 'Live', 'color': 0xFF00FF88,
    },
    {
      'icon': '🍺', 'name': 'Restrobar Pro',
      'desc': 'Restaurant order management for owners: accept/reject orders with delivery assignment and FCM alerts.',
      'users': 'Google Play', 'rating': 'Live', 'color': 0xFFFFAA00,
    },
  ];

  static const List<Map<String, String>> education = [
    {
      'degree': 'B.Tech — Computer Science',
      'school': 'ITS Engineering College, Greater Noida',
      'score': '68.66%',
    },
    {
      'degree': 'Class XII',
      'school': 'A.N. College, Patna',
      'score': '69%',
    },
    {
      'degree': 'Class X',
      'school': 'Bal Vidya Niketan, Patna',
      'score': '8.2 CGPA',
    },
  ];
}
