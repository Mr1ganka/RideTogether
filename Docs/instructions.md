# RideTogether AI Development Instructions

Version: 1.4

---

# Project Overview

RideTogether is a mobile-first group ride management application designed for:

* Motorcycle riders
* Cyclists
* Road trips
* Convoys
* Adventure groups

RideTogether is not a replacement for navigation applications.

The purpose of RideTogether is to add a group management and coordination layer on top of existing navigation services.

The application provides:

* Group ride management
* Rider synchronization
* Live rider locations
* Communication
* Safety features
* Ride coordination

RideTogether should feel like a co-pilot for group rides.

---

# Core Philosophy

Every feature must answer:

"Does this make riding in a group easier or safer?"

If the answer is no, do not build it.

The application should remain:

* Simple
* Fast
* Reliable
* Safe
* Distraction-free

The map is the primary experience.

Features should minimize interaction while riding.

Important principles:

* Avoid unnecessary rider interaction during rides
* Optimize battery usage
* Optimize network usage
* Keep controls usable while riding
* Safety takes priority over feature quantity

---

# Current Development Status

## Version

```
v0.0.3 — Rider Identity Foundation
```

---

# Completed Features

## Application Foundation

Completed:

* Flutter project created
* Android environment configured
* Physical device testing completed
* Feature-first architecture created
* Riverpod integrated
* GoRouter integrated
* Google Fonts integrated
* Application shell created
* Material 3 theme foundation created
* Light and dark theme support implemented
* Splash screen implemented
* Login screen implemented
* Home screen implemented
* Application routing implemented

---

## Firebase Foundation

Completed:

* Firebase project created
* Firebase Android application configured
* FlutterFire CLI configured
* Firebase initialization completed

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

## Authentication

Completed:

* Authentication repository architecture created
* Google Sign-In implemented
* Firebase Authentication implemented
* AppUser domain model created
* Firebase user mapping implemented
* Authentication providers created
* Login flow implemented
* Logout flow implemented
* Authentication state handling implemented
* Startup authentication checking implemented

Authentication flow:

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

# Rider Identity System

Completed:

* RiderProfile entity created
* Profile repository abstraction created
* Firebase profile repository implemented
* Firestore profile datasource created
* Profile providers created
* Automatic profile creation implemented
* Existing profile loading implemented

Rider identity purpose:

Authentication answers:

"Who is this user?"

Rider profile answers:

"Who is this rider inside RideTogether?"

Profile flow:

```
User Authentication

↓

Auth State Provider

↓

Current Profile Provider

↓

Check Firestore Profile

↓

Profile Exists

OR

Create Rider Profile

↓

Application Uses Rider Identity
```

Firestore structure:

```
users

 └── {userId}

      ├── displayName
      ├── email
      ├── photoUrl
      ├── createdAt
      └── updatedAt
```

Future rider profile additions:

* Motorcycle information
* Rider avatar
* Riding preferences
* Privacy settings
* Emergency information

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

Architecture principles:

Widgets display information.

Providers manage state.

Repositories manage application data.

Services communicate with external systems.

Architecture flow:

```
UI

↓

Riverpod Providers

↓

Repositories

↓

Services

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
Profile State Provider

↓

Profile Repository

↓

Firebase Profile Repository

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


shared/

- Reusable components
- Shared models
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
- Use cases


presentation/

- Screens
- Widgets
- Providers
```

---

# Android Application Identity

Current Android identity:

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

Do not change these values without updating:

* Firebase Android configuration
* google-services.json
* MainActivity package
* Gradle namespace
* Gradle applicationId

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
* Avoid storing application state inside widgets

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

Never:

```
Widget

↓

Firebase
```

Preferred:

```
Widget

↓

Provider

↓

Repository

↓

Service

↓

External System
```

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

Use Flutter theme values:

```
Theme.of(context)
```

---

# Current Development Priorities

Development order:

1. Complete map foundation
2. Integrate location permissions
3. Create map experience
4. Create Ride feature
5. Add live location tracking
6. Add group synchronization

Do not jump into advanced features before MVP foundations are complete.

---

# Future Journey Architecture

RideTogether currently focuses only on Ride mode.

Reach is a future feature.

Do not implement Reach during MVP.

Future architecture:

```
Journey

- Ride

- Reach
```

A Journey represents a shared group movement activity.

---

# Shared Journey Capabilities

Future shared Journey functionality may include:

* Members
* Destination
* Location tracking
* Map visualization
* Status
* Notifications
* Chat
* Events
* History

Shared functionality should be implemented once inside Journey.

Do not duplicate shared systems between Ride and Reach.

---

# Ride Mode

Ride is the current MVP feature.

Purpose:

Travel together.

Experience:

Follow the leader.

Control:

Leader controlled.

Ride capabilities:

* Leader
* Route control
* Checkpoints
* Regroup commands
* Group synchronization

Example:

"Follow me to the mountain viewpoint."

---

# Reach Mode

Reach is a future destination-based group activity.

Purpose:

Meet at a destination.

Experience:

Everyone travels independently.

Control:

No leader.

Reach capabilities:

* Shared destination
* Individual navigation
* Arrival tracking
* Participant progress

Example:

"Everyone meet at this café."

---

# Future Journey Domain

Future Journey model:

* id
* creatorId
* destination
* members
* status
* type

Journey types:

* Ride
* Reach

Mode-specific behavior should extend Journey.

Do not duplicate:

* Membership
* Location tracking
* Status handling
* Notifications
* Chat
* History

---

# Future Feature Direction

Do not restructure the current project for Reach.

After MVP completion, future Journey functionality may be organized as:

```
features/

journey/

data/

domain/

presentation/
```
Reach should only be implemented after current MVP priorities are complete.