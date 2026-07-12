# RideTogether Local Setup

This document explains how to set up RideTogether for local development.

The currently supported development environment is:

- Windows
- Android development
- Physical Android device or emulator

Android is the primary development target because Firebase and application configuration are currently verified on Android.

---

# Requirements

| Tool | Purpose | Requirement |
|---|---|---|
| Git | Repository management | Latest stable |
| Flutter SDK | Application development | Dart `^3.12.2` |
| Android Studio | Android SDK, emulator, build tools | Required |
| Java / JDK | Android Gradle builds | JDK 17 |
| Android device/emulator | Running the application | Required |
| Node.js + npm | Firebase CLI | Latest LTS |
| Firebase CLI | Firebase management | Required |
| FlutterFire CLI | Firebase configuration | Required |
| VS Code / Android Studio | Development environment | Recommended |

The application dependencies are managed through:

```text
pubspec.yaml
```

Do not install Flutter packages globally.

Run:

```powershell
flutter pub get
```

to install project dependencies.

---

# 1. Install Development Tools

## Flutter

Install Flutter SDK and add Flutter to your system PATH.

Verify:

```powershell
flutter --version
dart --version
```

---

## Android Studio

Install Android Studio with:

- Android SDK
- Android SDK Platform Tools
- Android SDK Command-line Tools
- Android Emulator
- Android Build Tools

Verify:

```powershell
flutter doctor -v
```

Resolve all Android-related warnings before running the project.

---

## Java

RideTogether requires:

```text
JDK 17
```

Verify:

```powershell
java -version
```

Expected:

```text
17.x.x
```

---

## Node.js and Firebase Tools

Install Node.js LTS.

Install Firebase CLI:

```powershell
npm install -g firebase-tools
```

Install FlutterFire CLI:

```powershell
dart pub global activate flutterfire_cli
```

Verify:

```powershell
firebase --version
flutterfire --version
```

---

# 2. VS Code Setup

VS Code is the recommended development environment for RideTogether.

Install the following extensions.

---

## Required Extensions

## Flutter

Extension:

```text
Dart-Code.flutter
```

Purpose:

- Flutter project support
- Hot reload and hot restart
- Flutter debugging
- Device management
- Widget inspection

---

## Dart

Extension:

```text
Dart-Code.dart-code
```

Purpose:

- Dart language support
- Code completion
- Refactoring
- Formatting
- Debugging

---

# Recommended Extensions

## Flutter Widget Snippets

Purpose:

- Quickly create common Flutter widgets
- Speed up UI development

Useful for:

- StatelessWidget
- StatefulWidget
- ConsumerWidget
- Common Flutter layouts

---

## Gradle for Java

Purpose:

- Android Gradle file support
- Syntax highlighting
- Easier Android build configuration

Useful files:

```text
android/build.gradle
android/app/build.gradle
settings.gradle
```

---

## Error Lens

Purpose:

- Shows errors and warnings inline
- Faster debugging

---

## YAML

Purpose:

Better support for:

- pubspec.yaml
- Firebase configuration
- CI/CD files

---

## GitLens

Purpose:

- Git history
- Code ownership
- Change tracking

---

## Recommended VS Code Settings

Enable formatting on save:

```json
{
    "editor.formatOnSave": true,
    "dart.lineLength": 100,
    "dart.previewFlutterUiGuides": true
}
```

Restart VS Code after installing extensions.

---

# 3. Android SDK Configuration

If Flutter cannot locate Android SDK:

```powershell
flutter config --android-sdk "C:\Users\<username>\AppData\Local\Android\Sdk"
```

Accept Android licenses:

```powershell
flutter doctor --android-licenses
```

---

# 4. Clone and Run Project

Clone repository:

```powershell
git clone <repository-url>

cd ride_together
```

Install dependencies:

```powershell
flutter pub get
```

Run checks:

```powershell
flutter analyze

flutter test
```

Check connected devices:

```powershell
flutter devices
```

Run application:

```powershell
flutter run
```

For a specific device:

```powershell
flutter run -d <device-id>
```

---

# 5. Android Device Setup

For a physical Android device:

1. Enable Developer Options
2. Enable USB Debugging
3. Connect device using USB
4. Accept debugging permission
5. Verify:

```powershell
adb devices
```

or:

```powershell
flutter devices
```

---

# 6. Firebase Setup

RideTogether currently uses Firebase for:

Implemented:

- Firebase Core
- Firebase Authentication
- Google Sign-In authentication

Future Firebase services:

- Cloud Firestore
- Firebase Realtime Database
- Firebase Messaging
- Cloud Functions
- Storage
- Crashlytics
- Analytics

Current Firebase project:

```text
Project:
r1detogether
```

Android application identity:

```text
Package:
com.ridetogether.app

Namespace:
com.ridetogether.app

Application ID:
com.ridetogether.app
```

---

# Firebase Configuration Files

The following files are required:

```text
firebase.json

lib/firebase_options.dart

android/app/google-services.json
```

Firebase initialization happens in:

```text
lib/main.dart
```

using:

```dart
Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

---

# Firebase Login

Authenticate Firebase CLI:

```powershell
firebase login
```

Verify access:

```powershell
firebase projects:list
```

---

# Reconfigure Firebase

Only run this when:

- Creating a new Firebase project
- Adding another platform
- Changing application identity

Run:

```powershell
flutterfire configure
```

This updates:

```text
firebase.json

lib/firebase_options.dart

platform Firebase configuration files
```

---
# 7. Application Structure

Current structure:

```text
lib/

├── app/
│   ├── app.dart
│   └── router/
│       ├── app_router.dart
│       └── app_routes.dart
│
├── core/
│   └── theme/
│
├── features/
│
│   ├── auth/
│   │
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── repositories/
│   │   │   └── datasources/
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   └── repositories/
│   │   │
│   │   └── presentation/
│   │       ├── screens/
│   │       ├── widgets/
│   │       └── providers/
│
│   ├── home/
│   │   └── presentation/
│
│   └── startup/
│       └── presentation/
│
├── firebase_options.dart
│
└── main.dart
```

---

# 8. Current Application Flow

```text
Android Device

↓

lib/main.dart

↓

Firebase.initializeApp()

↓

ProviderScope

↓

RideTogetherApp

↓

MaterialApp.router

↓

GoRouter

↓

SplashScreen

↓

Authentication Check

        |

        |-- Authenticated

        ↓

    HomeScreen


        |

        |-- Unauthenticated

        ↓

    LoginScreen
```

---

# 9. Development Rules

RideTogether follows:

- Feature-first architecture
- Repository pattern
- Riverpod state management
- Separation of concerns
- Null safety

Architecture flow:

```text
Widgets

↓

Providers

↓

Repositories

↓

Services

↓

External Systems
```

---

# Responsibilities

## Widgets

Responsible for:

- Displaying UI
- Handling presentation

Avoid:

- Firebase calls
- API calls
- Business logic

---

## Providers

Responsible for:

- State management
- Dependency injection
- Reactive updates

---

## Repositories

Responsible for:

- Data operations
- External data boundaries

---

## Services

Responsible for:

- Firebase
- Device APIs
- Maps
- External integrations

---

# 10. Design System

All UI styling uses:

```text
lib/core/theme/
```

Current design files:

```text
app_colors.dart

app_text_styles.dart

app_spacing.dart

app_radius.dart

app_shadows.dart

app_durations.dart

app_theme.dart
```

Avoid hardcoded:

- Colors
- Sizes
- Radius values
- Animation durations

Use:

```dart
Theme.of(context)
```

for adaptive styling.

---

# 11. Platform Support

## Android

Supported:

- Android build
- Firebase integration
- Physical device testing

---

## iOS

Not currently configured.

Required before development:

- macOS
- Xcode
- CocoaPods
- FlutterFire configuration

---

## Web/Desktop

Not currently supported.

Firebase configuration must be regenerated before use.

---

# 12. Maps Setup

Google Maps is planned but not currently configured.

Future services:

- Google Maps SDK
- Google Directions API
- Google Places API
- Google Geocoding API

Do not add API keys until map development begins.

When added:

- Restrict keys
- Use Android package restrictions
- Use API restrictions

---

# 13. Graphify AI Context Maintenance

RideTogether uses Graphify to maintain an AI-readable understanding of the application's architecture.

Graphify creates a graph representation of the codebase, helping AI tools understand:

- Feature relationships
- Code dependencies
- Architecture boundaries
- Major components
- Changes introduced over time

Graphify is a generated view of the current implementation.

It does not replace project documentation.

The sources of truth are:

1. Current codebase
2. Documentation in `/docs`
3. Graphify generated reports

---

# Graphify Setup

Graphify requires:

- Graphify CLI
- Gemini API key for semantic extraction

The Gemini API key must remain private.

Store it locally in:

```text
.env
```

Example:

```text
GEMINI_API_KEY=your_key_here
```

Ensure `.env` is included in:

```text
.gitignore
```

Never commit API keys.

---

# Running Graphify

Run Graphify from the project root:

```bash
graphify .
```

This generates:

```text
graphify-out/

├── graph.json
├── .graphify_analysis.json
```

Generate the readable architecture report:

```bash
graphify cluster-only .
```

This creates:

```text
graphify-out/GRAPH_REPORT.md
```

---

# When to Update Graphify

Graphify does not need to run after every small code change.

Run Graphify after major changes such as:

- Adding a new feature
- Creating a new feature folder
- Adding Firebase services
- Adding Google Maps functionality
- Changing authentication flow
- Changing state management
- Refactoring architecture
- Adding new external integrations
- Changing repository structure

Examples:

Adding:

```text
features/rides/
```

Run Graphify after completion.

Changing:

```text
Authentication architecture
```

Run Graphify after completion.

---

# Recommended AI Workflow

Before asking an AI coding assistant to make large changes:

## 1. Refresh Graphify

Run:

```bash
graphify .

graphify cluster-only .
```

---

## 2. Review Architecture Report

Review:

```text
graphify-out/GRAPH_REPORT.md
```

---

## 3. Provide Context to AI Tools

When asking AI tools for architectural changes, provide:

```text
docs/

graphify-out/GRAPH_REPORT.md
```

Example prompt:

```text
Review the current architecture using:

- docs/architecture.md
- docs/projectcontext.md
- graphify-out/GRAPH_REPORT.md

Identify risks before making changes.
```

---

# Graphify Maintenance Rules

Do:

- Regenerate after major architectural changes
- Keep generated output separate from documentation
- Use reports to validate architecture decisions

Do not:

- Manually edit graph.json
- Treat Graphify output as the roadmap
- Replace architecture documentation with generated reports
- Commit API keys

---

# 14. Daily Development Commands

Install dependencies:

```powershell
flutter pub get
```

Format code:

```powershell
dart format lib test
```

Analyze:

```powershell
flutter analyze
```

Run tests:

```powershell
flutter test
```

Run application:

```powershell
flutter run
```

Clean build:

```powershell
flutter clean

flutter pub get
```

---

# 15. Source Control Rules

Commit:

```text
pubspec.yaml

pubspec.lock

firebase.json

lib/firebase_options.dart

android/app/google-services.json
```

Do not commit:

```text
.dart_tool/

build/

android/.gradle/

android/local.properties

ios/Pods/

.env

IDE configuration files
```

---

# 16. Troubleshooting

| Problem | Solution |
|---|---|
| Flutter command not found | Add Flutter SDK to PATH |
| Firebase command not found | Install Firebase CLI |
| FlutterFire command not found | Add Dart pub cache to PATH |
| Android device missing | Enable USB debugging |
| Java build errors | Verify JDK 17 |
| Firebase configuration error | Check package name and Firebase project |
| Build cache problems | Run `flutter clean` then `flutter pub get` |
| Graphify cannot find Gemini key | Check `.env` and `GEMINI_API_KEY` configuration |
| Graphify semantic extraction fails | Verify Gemini API quota and Graphify dependencies |

---

# Verification Checklist

Before starting development:

```powershell
flutter doctor -v

flutter pub get

flutter analyze

flutter test

flutter devices

flutter run
```

A successful setup should:

- Build the Android application
- Initialize Firebase
- Show splash screen
- Redirect based on authentication state
- Allow login/logout flow

---

# Documentation Maintenance

Update this document when:

- New Firebase services are added
- New platforms are supported
- Authentication flow changes
- Architecture changes
- Development requirements change
- New development tools are required
- AI development workflow changes

---

# Final Setup Checklist

A new developer should have:

- Flutter installed
- Android Studio configured
- JDK 17 installed
- Firebase CLI installed
- FlutterFire CLI installed
- VS Code extensions installed
- Environment variables configured
- Firebase files available
- Dependencies installed
- Device/emulator available
- Graphify configured for AI context updates

The project should then run successfully with:

```bash
flutter run
```