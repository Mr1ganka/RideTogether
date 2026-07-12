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

# 2. Android SDK Configuration

If Flutter cannot locate Android SDK:

```powershell
flutter config --android-sdk "C:\Users\<username>\AppData\Local\Android\Sdk"
```

Accept Android licenses:

```powershell
flutter doctor --android-licenses
```

---

# 3. Clone and Run Project

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

# 4. Android Device Setup

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

# 5. Firebase Setup

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

# 6. Application Structure

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

# 7. Current Application Flow

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

# 8. Development Rules

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

Responsibilities:

## Widgets

Responsible for:

- Displaying UI
- Handling presentation

Avoid:

- Firebase calls
- API calls
- Business logic


## Providers

Responsible for:

- State management
- Dependency injection
- Reactive updates


## Repositories

Responsible for:

- Data operations
- External data boundaries


## Services

Responsible for:

- Firebase
- Device APIs
- Maps
- External integrations

---

# 9. Design System

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

# 10. Platform Support

## Android

Supported:

- Android build
- Firebase integration
- Physical device testing


## iOS

Not currently configured.

Required before development:

- macOS
- Xcode
- CocoaPods
- FlutterFire configuration


## Web/Desktop

Not currently supported.

Firebase configuration must be regenerated before use.

---

# 11. Maps Setup

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

# 12. Daily Development Commands

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

# 13. Source Control Rules

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

IDE configuration files
```

---

# 14. Troubleshooting

| Problem | Solution |
|---|---|
| Flutter command not found | Add Flutter SDK to PATH |
| Firebase command not found | Install Firebase CLI |
| FlutterFire command not found | Add Dart pub cache to PATH |
| Android device missing | Enable USB debugging |
| Java build errors | Verify JDK 17 |
| Firebase configuration error | Check package name and Firebase project |
| Build cache problems | Run flutter clean then flutter pub get |

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