# RideTogether Local Setup

Version: 1.5

---

# Prerequisites

## Required Software

* Flutter SDK 3.32+
* Android Studio
* Git
* Java 17+ (for Android builds)
* Xcode 15+ (for iOS builds on macOS)

## Required Accounts

* Firebase project
* Google Cloud project (for Google Sign-In)
* GitHub account

---

# Clone Repository

```bash
git clone https://github.com/Mr1ganka/RideTogether.git
cd RideTogether
```

---

# Flutter Environment

## Verify Flutter Installation

```bash
flutter doctor
```

All checks should pass for Android.

## Get Dependencies

```bash
flutter pub get
```

---

# Firebase Setup

## Firebase Project

Create a Firebase project at: https://console.firebase.google.com

Enable:
* Authentication → Google Sign-In
* Firestore Database

## FlutterFire CLI

Install FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
```

Configure Firebase for the project:

```bash
flutterfire configure
```

Select:
* Your Firebase project
* Platforms: Android, iOS, Web (as needed)

This generates:
* `lib/firebase_options.dart`
* `android/app/google-services.json`
* `ios/Runner/GoogleService-Info.plist`

---

# Android Setup

## Android SDK

Android SDK should be configured with Android Studio.

## Emulator or Device

Physical device recommended for testing.

## Google Services

Ensure `android/app/google-services.json` is present from `flutterfire configure`.

## Build

```bash
flutter build apk --debug
```

Or run on device:

```bash
flutter run
```

---

# iOS Setup (macOS Only)

## Xcode

Install Xcode from App Store.

Open workspace:

```bash
open ios/Runner.xcworkspace
```

## iOS Configuration

* Bundle ID: `com.ridetogether.app`
* Team: Select your Apple Developer Team
* Signing: Automatic

## Google Services

Ensure `ios/Runner/GoogleService-Info.plist` is present from `flutterfire configure`.

## Build

```bash
flutter build ios --debug
```

Or run:

```bash
flutter run
```

---

# Web Setup

## Chrome

Web runs on Chrome.

```bash
flutter run -d chrome
```

---

# Platform Configuration

## Android Permissions

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_LOCATION" />
```

## iOS Permissions

Add to `ios/Runner/Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>RideTogether needs location access to show your position on the map during rides.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>RideTogether needs location access for live rider tracking during group rides.</string>
```

## Web

No additional configuration required.

---

# Dependencies

The following packages are already in `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.1
  go_router: ^14.2.1
  google_fonts: ^6.2.1
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  cloud_firestore: ^5.4.3
  google_sign_in: ^6.2.1

  # Map & Location (Phase 2 - already added)
  flutter_map: ^8.2.2
  latlong2: ^0.9.1
  geolocator: ^14.0.2
  permission_handler: ^12.0.1
  geocoding: ^4.0.0
  flutter_google_places_sdk: ^0.4.2
  flutter_polyline_points: ^3.0.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

Run:

```bash
flutter pub get
```

---

# Project Structure

```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   └── router/
│       └── app_router.dart
├── core/
│   └── theme/
│       ├── app_colors.dart
│       ├── app_text_styles.dart
│       ├── app_spacing.dart
│       ├── app_radius.dart
│       ├── app_shadows.dart
│       ├── app_durations.dart
│       └── app_theme.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── repositories/
│   │   │   │   └── firebase_auth_repository.dart
│   │   │   └── datasources/
│   │   │       └── firebase_auth_datasource.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── app_user.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── mappers/
│   │   │       └── user_mapper.dart
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── login_screen.dart
│   │       ├── widgets/
│   │       └── providers/
│   │           └── auth_providers.dart
│   ├── home/
│   │   └── presentation/
│   │       └── screens/
│   │           └── home_screen.dart
│   ├── profile/
│   │   ├── data/
│   │   │   ├── repositories/
│   │   │   │   └── firebase_profile_repository.dart
│   │   │   ├── datasources/
│   │   │   │   └── firestore_profile_datasource.dart
│   │   │   └── models/
│   │   │       └── rider_profile_model.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── rider_profile.dart
│   │   │   ├── repositories/
│   │   │   │   └── profile_repository.dart
│   │   │   └── mappers/
│   │   │       └── profile_mapper.dart
│   │   └── presentation/
│   │       └── providers/
│   │           └── profile_providers.dart
│   ├── startup/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── splash_screen.dart
│   │       └── providers/
│   │           └── startup_providers.dart
│   ├── map/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── repositories/
│   │   │   │   └── flutter_map_provider.dart
│   │   │   └── datasources/
│   │   │       └── flutter_map_datasource.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── map_marker.dart
│   │   │   │   ├── map_polyline.dart
│   │   │   │   ├── camera_position.dart
│   │   │   │   ├── map_bounds.dart
│   │   │   │   ├── lat_lng.dart
│   │   │   │   ├── map_capabilities.dart
│   │   │   │   └── map_provider_type.dart
│   │   │   ├── repositories/
│   │   │   │   └── map_provider.dart
│   │   │   └── mappers/
│   │   └── presentation/
│   │       ├── screens/
│   │       ├── widgets/
│   │       │   └── app_map.dart
│   │       └── providers/
│   │           └── map_providers.dart
│   └── location/
│       ├── data/
│       │   ├── models/
│       │   ├── repositories/
│       │   │   └── geolocator_location_repository.dart
│       │   └── datasources/
│       │       └── geolocator_datasource.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── position.dart
│       │   ├── repositories/
│       │   │   └── location_repository.dart
│       │   └── mappers/
│       └── presentation/
│           ├── screens/
│           ├── widgets/
│           └── providers/
│               └── location_providers.dart
└── shared/
    └── widgets/
```

---

# Running the App

## Debug Build

```bash
flutter run
```

## Release Build (Android)

```bash
flutter build apk --release
```

## Release Build (iOS)

```bash
flutter build ios --release
```

---

# Environment Variables

Create a `.env` file for local development (not committed):

```bash
GEMINI_API_KEY=your_gemini_api_key_here
```

Ensure `.env` is in `.gitignore`.

---

# Troubleshooting

## Flutter Doctor Issues

Run:

```bash
flutter doctor -v
```

Address any reported issues.

## Firebase Configuration

If Firebase configuration is missing:

```bash
flutterfire configure
```

## Android Build Fails

Clean build:

```bash
flutter clean
flutter pub get
flutter build apk
```

## iOS Build Fails

Clean and rebuild:

```bash
flutter clean
flutter pub get
cd ios
pod install
cd ..
flutter build ios
```

## Google Sign-In Not Working

1. Verify SHA-1 fingerprint in Firebase Console
2. Verify Google Sign-In is enabled in Firebase Authentication
3. Ensure `google-services.json` is in `android/app/`
4. Ensure `GoogleService-Info.plist` is in `ios/Runner/`

## Map Not Loading

1. Verify `flutter_map` and `latlong2` are in pubspec.yaml
2. Run `flutter pub get`
3. Check network connectivity (OpenStreetMap requires internet)
4. Verify Android internet permission in AndroidManifest.xml

## Location Not Working

1. Verify location permissions in AndroidManifest.xml and Info.plist
2. Verify `geolocator` and `permission_handler` in pubspec.yaml
3. Test on physical device (emulator GPS may be unreliable)
4. Check location services are enabled on device

---

# IDE Setup

## VS Code Extensions (Recommended)

* Flutter
* Dart
* Riverpod
* Error Lens
* GitLens

## Android Studio

* Flutter plugin
* Dart plugin

---

# Code Generation

No code generation tools are currently used.

---

# Testing

## Unit Tests

```bash
flutter test
```

## Integration Tests

```bash
flutter test integration_test/
```

---

# Version Control

## Git Configuration

```bash
git config user.name "Your Name"
git config user.email "your@email.com"
```

## Branching Strategy

* `main` - production
* `develop` - integration
* `feature/*` - feature branches

---

# CI/CD

No CI/CD pipeline configured yet.

---

# Next Steps After Setup

1. Run `flutter pub get`
2. Run `flutter run` on device/emulator
3. Verify Google Sign-In works
4. Verify map loads (Map Foundation Phases 1-5 complete, MapScreen in Phase 7)
5. Verify location permissions work (Location Foundation Phases 6-10 complete, User Location Layer in Phase 10)
