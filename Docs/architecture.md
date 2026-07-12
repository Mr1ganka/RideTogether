# RideTogether Architecture

Version: 1.4

---

# Overview

RideTogether is a real-time group ride management application.

The application is designed as a coordination layer on top of navigation services.

External navigation services are responsible for:

* Map rendering
* Navigation
* Directions
* Places
* Geographic services

RideTogether is responsible for:

* Group ride management
* Rider synchronization
* Live rider locations
* Communication
* Checkpoints
* Safety features
* Ride coordination

The architecture goals are:

* Modular
* Scalable
* Testable
* Maintainable

The application follows:

* Feature-first architecture
* Repository pattern
* Separation of concerns
* Reactive state management
* Centralized design system

---

# Current Development Status

## Version

v0.0.3 — Rider Identity Foundation

---

# Completed

## Application Foundation

Completed:

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

```
com.ridetogether.app
```

Namespace:

```
com.ridetogether.app
```

Application ID:

```
com.ridetogether.app
```

---

# Firebase Foundation

Completed:

✅ Firebase project created

✅ Firebase Android application configured

✅ FlutterFire CLI configured

✅ Firebase initialized during application startup

Current Firebase services:

* Firebase Core
* Firebase Authentication
* Cloud Firestore

Future Firebase services:

* Firebase Realtime Database
* Cloud Functions
* Firebase Messaging
* Storage
* Crashlytics
* Analytics

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

```
Presentation

↓

Domain

↓

Data

↓

Firebase
```

---

# Rider Identity Foundation

Completed:

✅ RiderProfile domain entity created

✅ Rider profile repository contract created

✅ Firebase profile repository implemented

✅ Firestore profile datasource implemented

✅ Profile providers created

✅ Automatic profile creation after authentication implemented

✅ Existing profile lookup implemented

Rider profile flow:

```
Firebase Authentication

↓

AppUser

↓

Current Profile Provider

↓

Profile Repository

↓

Firestore

↓

RiderProfile
```

Current Firestore structure:

```
users

 └── {uid}

       ├── rider information
       ├── display information
       ├── createdAt
       └── updatedAt
```

Future RiderProfile capabilities:

* Profile screen
* Profile editing
* Motorcycle information
* Avatar management
* Privacy settings

---

# Startup Architecture

Startup is responsible for preparing the application before entering the main experience.

Current startup flow:

```
Application Launch

↓

Firebase Initialization

↓

ProviderScope

↓

RideTogetherApp

↓

GoRouter

↓

SplashScreen

↓

Startup Provider

↓

Authentication Check

↓

Rider Profile Check

↓

HomeScreen
```

Startup responsibilities:

* Maintain splash experience
* Wait for authentication readiness
* Ensure authenticated users have RiderProfile data

---

# Current Application Flow

```
Android Device

↓

main.dart

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

Startup Provider

↓

Auth State Provider

↓

Current Profile Provider

↓

HomeScreen
```

---

# Application Architecture

RideTogether uses:

* Flutter
* Riverpod
* GoRouter
* Feature-first architecture
* Repository pattern
* Strong typing
* Null safety

Architecture flow:

```
UI

↓

Riverpod Providers

↓

Repositories

↓

Data Sources

↓

External Systems
```

Example:

```
Login Screen

↓

Auth Provider

↓

Auth Repository

↓

Firebase Authentication
```

Profile example:

```
Startup Provider

↓

Current Profile Provider

↓

Profile Repository

↓

Firestore Datasource

↓

Cloud Firestore
```

---

# Application Structure

Current structure:

```
lib/

app/

- Application configuration
- Routing
- Global settings


core/

- Themes
- Services
- Utilities
- Shared infrastructure


features/

- Feature modules
```

Feature structure:

```
feature/

data/

- Models
- Repositories
- Datasources


domain/

- Entities
- Repository contracts
- Business rules


presentation/

- Screens
- Widgets
- Providers
```

---

# Coding Rules

## Widgets

Widgets should only handle UI rendering.

Widgets should:

* Display information
* Receive state
* Trigger user actions

Widgets should not contain:

* Firebase calls
* API calls
* Business logic
* Data processing

Business logic belongs in:

* Providers
* Repositories
* Services

---

# Riverpod Rules

Riverpod manages:

* Application state
* Feature state
* Dependency injection
* Reactive updates

Rules:

* Widgets consume providers
* Providers communicate with repositories
* Repositories communicate with services

---

# Repository Rules

Repositories separate application logic from external systems.

Example:

```
AuthRepository

↓

FirebaseAuthRepository

↓

Firebase
```

Features should depend on repository abstractions rather than directly accessing external services.

---

# Design System Rules

All UI styling must use:

```
lib/core/theme/
```

The design system controls:

* Colors
* Typography
* Spacing
* Radius
* Shadows
* Animations
* Component styling

Do not:

* Hardcode colors
* Add random spacing values
* Create feature-specific theme systems

Use:

```
Theme.of(context)
```

---

# Current Development Priorities

Development order:

1. Complete rider identity foundation
2. Implement map foundation
3. Create Ride feature
4. Add live location tracking
5. Add group synchronization

---

# Future Journey Architecture

RideTogether currently focuses only on Ride mode.

Reach is a future feature.

Do not implement Reach during MVP.

Future architecture:

```
Journey

├── Ride

└── Reach
```

A Journey represents a shared group movement activity.

Future shared Journey functionality:

* Members
* Destination
* Location tracking
* Map visualization
* Status
* Notifications
* Chat
* Events
* History

Future implementation may use:

```
features/journey/
```

Do not restructure the current project for Reach before MVP completion.

---

# Ride Mode

Ride is the current MVP feature.

Purpose:

Travel together.

Experience:

Follow the leader.

Control:

Leader controlled.

Capabilities:

* Leader
* Route control
* Checkpoints
* Regroup commands
* Group synchronization

---

# Reach Mode

Reach is a future journey mode.

Purpose:

Meet at a destination.

Experience:

Everyone travels independently.

Control:

No leader.

Capabilities:

* Shared destination
* Individual navigation
* Arrival tracking
* Participant progress

---

# Future Technical Direction

Future systems:

## Mapping

Planned:

* Google Maps integration
* Location services
* Map visualization

## Live Tracking

Planned:

* GPS updates
* Rider location synchronization
* Realtime Database

## Communication

Planned:

* Ride chat
* Notifications
* Emergency communication

## Safety

Planned:

* Crash detection
* Hazard reporting
* Emergency contacts

---

# Architecture Evolution Rules

After major milestones update:

* Version number
* Current status
* Completed architecture
* Important file locations
* Development priorities

Do not:

* Add speculative architecture
* Create future modules before implementation
* Duplicate shared systems
* Move files without architectural reason

The architecture document should always describe the implemented system, not only future plans.