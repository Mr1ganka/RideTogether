# RideTogether

<p align="center">
  <strong>Your co-pilot for group rides.</strong>
</p>

---

# RunCommand
- "flutter run --dart-define-from-file=config.json"

# Overview

RideTogether is a mobile-first group ride management application built for:

- Motorcycle riders
- Cyclists
- Road trips
- Convoys
- Adventure groups

The goal is not to replace navigation applications.

RideTogether adds a group coordination layer on top of navigation services.

Think:

```
Google Maps
+
Discord
+
Life360
+
Group Ride Management
```

RideTogether helps groups ride together safely with:

- Live rider locations
- Group synchronization
- Ride management
- Checkpoints
- Communication
- Safety features

---

# Current Status

## Version

`v0.0.1 — Foundation Setup`

The initial application foundation is complete.

Completed:

✅ Flutter application setup

✅ Android development environment

✅ Feature-first architecture

✅ Riverpod integration

✅ GoRouter navigation

✅ Centralized design system

✅ Material 3 theme system

✅ Light and dark theme support

✅ Application routing flow

✅ Splash screen

✅ Login screen foundation

✅ Home screen foundation

---

# Current Application Flow

```
Application Launch

↓

main.dart

↓

ProviderScope

↓

RideTogetherApp

↓

MaterialApp.router

↓

GoRouter

↓

Splash Screen

↓

Authentication

↓

Home
```

---

# Technology Stack

## Mobile

- Flutter
- Dart

## State Management

- Riverpod

## Navigation

- GoRouter

## Backend

Planned Firebase ecosystem:

- Firebase Authentication
- Cloud Firestore
- Realtime Database
- Cloud Functions
- Firebase Messaging
- Firebase Storage
- Crashlytics
- Analytics

## Maps

Google services:

- Google Maps SDK
- Google Directions API
- Google Places API
- Google Geocoding API

---

# Architecture

RideTogether follows:

- Feature-first architecture
- Repository pattern
- Separation of concerns
- Reactive state management
- Centralized design system

Application flow:

```
UI Widgets

↓

Riverpod Providers

↓

Repositories

↓

Services

↓

External Systems
```

Responsibilities:

| Layer | Responsibility |
|---|---|
| Widgets | Display UI |
| Providers | Manage application state |
| Repositories | Handle data access |
| Services | Communicate with external systems |

---

# Project Structure

```
lib/

├── app/
│   ├── app.dart
│   └── router/
│
├── core/
│   ├── config/
│   ├── services/
│   ├── themes/
│   └── utils/
│
├── features/
│   ├── auth/
│   ├── home/
│   ├── map/
│   ├── ride/
│   ├── navigation/
│   ├── checkpoints/
│   ├── chat/
│   ├── hazards/
│   ├── notifications/
│   ├── profile/
│   └── settings/
│
└── shared/
    ├── models/
    └── widgets/
```

---

# Development Setup

## Requirements

Install:

- Flutter SDK
- Android Studio or Android SDK
- VS Code / IntelliJ
- Java 17+

Verify Flutter installation:

```bash
flutter doctor
```

---

## Run Application

Clone repository:

```bash
git clone <repository-url>
```

Install dependencies:

```bash
flutter pub get
```

Run application:

```bash
flutter run
```

---

# Development Principles

Every feature should answer:

> "Does this make riding in a group easier and safer?"

If not, it should not be built.

RideTogether should remain:

- Fast
- Reliable
- Safe
- Simple
- Distraction-free

The map is always the primary experience.

---

# Roadmap

Current milestone:

## Authentication Foundation

Next milestones:

1. Firebase setup
2. Authentication flow
3. User profiles
4. Home map screen
5. Google Maps integration
6. Ride creation
7. Live tracking
8. Navigation
9. Communication
10. Safety features

---

# Documentation

Detailed project documentation:

- `docs/architecture.md`
- `docs/instructions.md`
- `docs/project_context.md`
- `docs/roadmap.md`

---

# Vision

Become the default application for organized group rides.

Not just navigation.

Not just tracking.

The operating system for group riding.