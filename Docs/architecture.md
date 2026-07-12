# RideTogether Architecture

Version: 1.3

---

# Overview

RideTogether is a real-time group ride management application.

The application is designed as a companion layer on top of navigation services.

External navigation services are responsible for:

- Map rendering
- Navigation
- Directions
- Places
- Geographic services

RideTogether is responsible for:

- Group ride management
- Rider synchronization
- Live rider locations
- Communication
- Checkpoints
- Safety features
- Ride coordination

The architecture goals are:

- Modular
- Scalable
- Testable
- Maintainable

The application follows:

- Feature-first architecture
- Repository pattern
- Separation of concerns
- Reactive state management
- Centralized design system

---

# Current Development Status

## Version

v0.0.2 — Authentication Foundation

---

# Completed

## Application Foundation

✅ Flutter project created

✅ Android environment configured

✅ Physical device testing verified

✅ Feature-first architecture created

✅ Riverpod integrated

✅ GoRouter integrated

✅ Google Fonts integrated

✅ Material 3 theme foundation created

✅ Centralized theme system created

✅ Light and dark theme support implemented

✅ Application routing implemented

✅ Splash screen implemented

✅ Login screen implemented

✅ Home screen implemented

✅ Application identity configured


Android Application:

Package:

com.ridetogether.app

Namespace:

com.ridetogether.app

Application ID:

com.ridetogether.app


---

# Firebase Foundation

Completed:

✅ Firebase project created

✅ Firebase Android application configured

✅ FlutterFire CLI configured

✅ Firebase initialized during application startup


Current Firebase services:

- Firebase Core
- Firebase Authentication


Future Firebase services:

- Cloud Firestore
- Realtime Database
- Cloud Functions
- Firebase Messaging
- Storage
- Crashlytics
- Analytics

---

# Authentication Foundation

Completed:

✅ Authentication repository architecture created

✅ Google Sign-In implemented

✅ Firebase Authentication implemented

✅ AppUser domain model created

✅ Firebase user mapping implemented

✅ Authentication providers created

✅ Login flow implemented

✅ Logout flow implemented


Authentication follows:

Presentation

↓

Domain

↓

Data

↓

Firebase

---

# Current Application Flow
