# Abhimanyu Kumar — Flutter Portfolio

A production-ready Flutter Web portfolio website with matrix rain animation, photo orbit, and full resume content.

## 🚀 Quick Start

### Prerequisites
- Flutter SDK 3.x installed ([flutter.dev](https://flutter.dev/docs/get-started/install))
- Chrome browser (for web preview)

### Run in 3 steps

```bash
# 1. Navigate to the project folder
cd abhimanyu_portfolio

# 2. Get dependencies
flutter pub get

# 3. Run on web
flutter run -d chrome
```

### Build for deployment
```bash
# Build optimised web release
flutter build web --release

# Output is in: build/web/
# Drag the build/web/ folder to netlify.com/drop to deploy instantly
```

## 📁 Project Structure

```
abhimanyu_portfolio/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── screens/
│   │   └── home_screen.dart         # Main page assembling all sections
│   ├── theme/
│   │   └── app_theme.dart           # Colors, fonts, all resume data
│   └── widgets/
│       ├── hero_section.dart        # Photo orbit + hero text
│       ├── sections.dart            # Skills, Experience, Apps, Education, Contact
│       ├── nav_bar.dart             # Fixed top navigation
│       ├── code_marquee.dart        # Scrolling code strip
│       └── matrix_background.dart   # Animated matrix rain canvas
├── assets/
│   └── images/
│       └── profile.jpg              # Your photo (already included)
├── web/
│   └── index.html                   # Web entry with loading screen
└── pubspec.yaml                     # Dependencies
```

## ✏️ Customisation

All your personal data is in one place:
**`lib/theme/app_theme.dart`** → `AppData` class

- Change email, phone, LinkedIn → update constants at top
- Add new apps → add to `AppData.apps` list
- Add new skills → update `AppData.skills`
- Add new experience → update `AppData.experience`

## 🎨 Features

- ✅ Matrix code rain background (canvas animation)
- ✅ Photo with rotating orbit rings + scan line
- ✅ Floating animated tech chips around photo
- ✅ Scrolling code marquee strip
- ✅ Hover animations on all cards
- ✅ Glowing CTA buttons with parallax
- ✅ Timeline experience section
- ✅ Live app cards with pulsing badges
- ✅ Contact section with availability indicator
- ✅ Fully responsive (mobile + desktop)
- ✅ Smooth scroll navigation

## 📦 Dependencies

| Package | Purpose |
|---------|---------|
| `google_fonts` | JetBrains Mono + Syne fonts |
| `flutter_animate` | Stagger fade/slide animations |
| `url_launcher` | Email & LinkedIn links |
| `animated_text_kit` | Typing cursor effect |
| `visibility_detector` | Scroll-triggered animations |
| `font_awesome_flutter` | Icons |

## 🌐 Deploy to Netlify (Free)

```bash
flutter build web --release
# Go to netlify.com/drop
# Drag the build/web/ folder
# Done — live in 60 seconds!
```
