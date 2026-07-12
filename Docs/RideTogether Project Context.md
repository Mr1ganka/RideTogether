# RideTogether Project Context

Version: 1.4

Last Updated:
YYYY-MM-DD

---

# Purpose of This Document

This document is the primary context file for RideTogether.

It exists so that any developer or AI assistant can understand:

- What RideTogether is
- Why the project exists
- Current implementation status
- Project architecture
- Important file locations
- Development rules
- Current priorities
- Future direction

Before making changes, read this document first.

This document should evolve with the project.

Whenever a major feature is completed:

- Update the current status
- Update architecture changes
- Update important file locations
- Update the next development priorities

Do not allow this file to become outdated.

---

# Product Overview

RideTogether is a mobile-first group ride management application.

Target users:

- Motorcycle riders
- Cyclists
- Road trip groups
- Convoys
- Adventure groups

RideTogether is not a replacement for navigation applications.

Navigation applications answer:

"How do I get there?"

RideTogether answers:

"How do we get there together?"

The application adds a coordination layer on top of navigation services.

Core capabilities:

- Group ride management
- Rider synchronization
- Live rider locations
- Communication
- Safety features
- Ride organization

The product goal:

Make group riding easier, safer, and more connected.

Every feature must answer:

> Does this make riding in a group easier or safer?

If not, it should not be built.

---

# Product Principles

RideTogether should remain:

- Simple
- Fast
- Reliable
- Safe
- Distraction-free

Important principles:

- The map becomes the primary experience.
- Riders should interact with the app as little as possible while riding.
- Controls should be usable with gloves.
- Battery usage must be considered.
- Network usage must be optimized.
- Safety takes priority over unnecessary features.

---

# Current Development Status

## Current Version

```
v0.0.2 — Authentication Foundation
```

---

# Completed Features

## Application Foundation

Completed:

- Flutter application created
- Android development environment configured
- Physical device testing completed
- Feature-first architecture created
- Riverpod integrated
- GoRouter integrated
- Google Fonts integrated
- Material 3 theme foundation created
- Light and dark theme support created
- Application routing completed


---

# Firebase Setup

Completed:

- Firebase project created
- Android Firebase application registered
- FlutterFire CLI configured
- Firebase initialization implemented


Firebase currently used:

- Firebase Core
- Firebase Authentication


Future Firebase services:

- Cloud Firestore
- Firebase Realtime Database
- Firebase Messaging
- Cloud Functions
- Storage
- Crashlytics
- Analytics

---

# Authentication System

Completed:

- Authentication architecture
- Repository pattern implementation
- Firebase authentication repository
- Google Sign-In integration
- AppUser entity
- Firebase User → AppUser conversion
- Authentication providers
- Login flow
- Logout flow


Authentication architecture:

```
Login Screen

↓

Auth Provider

↓

Auth Repository

↓

Firebase Authentication

↓

AppUser

↓

Application State
```

---

# Current Application Flow

```
Application Start

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

Authentication Check


Authenticated

↓

HomeScreen


Unauthenticated

↓

LoginScreen
```

---

# Current Development Focus

The project is currently moving from foundation into application features.

Current priority order:

1. Rider profiles
2. Home screen foundation
3. Google Maps integration
4. Ride creation
5. Ride joining
6. Live location tracking
7. Navigation support
8. Communication
9. Safety features


Do not jump into advanced features before completing the foundation.

---

# Project Structure

Current structure:

```
lib/

├── app/
│   ├── app.dart
│   └── router/
│       ├── app_router.dart
│       └── app_routes.dart
│
├── core/
│   └── theme/
│       ├── app_theme.dart
│       ├── app_colors.dart
│       ├── app_text_styles.dart
│       ├── app_spacing.dart
│       ├── app_radius.dart
│       ├── app_shadows.dart
│       └── app_durations.dart
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

# Important File Locations

## Application Startup

Location:

```
lib/main.dart
```

Responsible for:

- Flutter initialization
- Firebase initialization
- ProviderScope creation
- Starting the application


Do not place business logic here.

---

## Application Configuration

Location:

```
lib/app/
```

Contains:

- Application shell
- Routing
- Global configuration


---

## App Theme

Location:

```
lib/core/theme/
```

Important files:

### app_theme.dart

Responsible for:

- Material ThemeData creation
- Light theme
- Dark theme
- Component styling


### app_colors.dart

Contains:

- Brand colors
- Semantic colors


### app_text_styles.dart

Contains:

- Typography system


### app_spacing.dart

Contains:

- Layout spacing values


### app_radius.dart

Contains:

- Border radius values


### app_shadows.dart

Contains:

- Elevation and shadows


### app_durations.dart

Contains:

- Animation timing


Rules:

Never hardcode:

- Colors
- Font sizes
- Radius values
- Spacing values

Use the design system.

---

# Architecture Rules

RideTogether follows:

- Feature-first architecture
- Repository pattern
- Separation of concerns
- Reactive state management


General flow:

```
UI

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

# Layer Responsibilities

## Presentation Layer

Contains:

- Screens
- Widgets
- Providers

Responsible for:

- Displaying UI
- Receiving user interaction
- Consuming state


Should NOT contain:

- Firebase calls
- API calls
- Business rules


---

## Domain Layer

Contains:

- Entities
- Repository contracts
- Business rules


Should remain independent from external systems.

---

## Data Layer

Contains:

- Models
- Repository implementations
- Data sources


Responsible for:

- Firebase communication
- External APIs
- Data conversion


---

# State Management Rules

Riverpod is used for:

- Dependency injection
- Application state
- Feature state


Rules:

- Widgets consume providers
- Providers communicate with repositories
- Repositories communicate with external services

Avoid putting application state inside widgets.

---

# Navigation Rules

Navigation is managed through:

```
lib/app/router/
```

Using:

- GoRouter


Routes should not be created directly inside widgets.

---

# Android Configuration

Current application identity:

```
Package:
com.ridetogether.app

Namespace:
com.ridetogether.app

Application ID:
com.ridetogether.app
```

Do not change these without updating:

- Firebase configuration
- Android Gradle configuration
- google-services.json

---

# Product Architecture

## Ride Mode

Current core product.

Ride is a leader-led group movement experience.

Purpose:

Travel together.

Experience:

Follow the leader.


Planned capabilities:

- Create rides
- Join rides
- Invite links
- Ride codes
- Rider roles
- Live locations
- Shared destination
- Navigation support
- Checkpoints
- Ride communication
- Regroup features
- Safety features


---

# Future Journey Architecture

Reach is a future feature.

Do not implement during MVP.

Future architecture:

```
Journey

├── Ride Mode

└── Reach Mode
```

A Journey represents shared movement.

Future shared capabilities:

- Members
- Destination
- Location tracking
- Status
- Notifications
- Chat
- Events
- History


Do not create:

```
features/journey/
```

until Reach development begins.

---

# Current Next Tasks

The next development work should focus on:

## 1. Rider Profile System

Build:

- User profile entity
- Profile storage
- Rider information
- Settings foundation


## 2. Home Foundation

Build:

- Authenticated home experience
- Application shell
- Map placeholder
- User state display


## 3. Maps Foundation

Add:

- Google Maps SDK
- Map screen
- Location permissions


## 4. Ride System

Build:

- Create ride
- Join ride
- Ride membership
- Ride permissions


---

# AI Development Instructions

When modifying this project:

1. Read this document first.

2. Understand the current architecture before adding files.

3. Follow existing folder structure.

4. Do not move files unless architecture requires it.

5. Do not add unnecessary abstractions.

6. Keep business logic outside widgets.

7. Use repositories for external communication.

8. Use providers for state management.

9. Use the existing design system.

10. Update this document after major architectural changes.

---

# Documentation System

Related documents:

## architecture.md

Contains:

- Detailed architecture
- Technical decisions
- Folder rules


## instructions.md

Contains:

- Coding rules
- AI guidelines
- Development conventions


## roadmap.md

Contains:

- Feature roadmap
- Development phases
- Future plans


## local_setup.md

Contains:

- Environment setup
- Required tools
- Firebase setup


---

# Document Evolution Rules

This file is a living project bookmark.

After completing a major milestone:

Update:

- Version number
- Current status
- Completed features
- Current architecture
- Next development priorities


Do not:

- Remove future plans
- Mark incomplete features as completed
- Add speculative architecture without implementation

The purpose of this file is to allow any AI or developer to quickly understand RideTogether and continue development without losing project context.

---

# Long-Term Vision

Become the default platform for organized group rides.

Not just navigation.

Not just tracking.

A complete riding companion for safer and better group experiences.