# RideTogether Roadmap

Version: 1.4

---

# Development Progress

## Current Version

```
v0.0.3 — Rider Identity Foundation
```

---

# Current Status

The application foundation is complete.

Authentication and rider identity foundations have been implemented.

Current development priority:

```
Authentication
↓
Rider Identity
↓
Map Foundation
↓
Ride System
↓
Live Tracking
```

---

# Completed Features

## Application Foundation

Completed:

* Flutter project created
* Android development environment configured
* Physical device testing verified
* Feature-first architecture created
* Riverpod integrated
* GoRouter integrated
* Google Fonts integrated
* Application shell created
* Material 3 theme system created
* Light and dark theme support created
* Application routing implemented
* Splash screen implemented
* Login screen implemented
* Home screen implemented

---

## Android Configuration

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

## Firebase Foundation

Completed:

* Firebase project created
* Firebase Android application configured
* FlutterFire CLI configured
* Firebase initialization completed
* Firebase Authentication integrated
* Cloud Firestore integrated for rider profiles

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

# Authentication

Status:

Complete

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

Status:

Complete

Purpose:

Extend authenticated identity into an application-specific rider profile.

Authentication answers:

"Who is this user?"

Rider profile answers:

"Who is this rider inside RideTogether?"

Completed:

* RiderProfile entity created
* Profile repository abstraction created
* Firebase profile repository implemented
* Firestore profile datasource created
* Profile providers created
* Automatic profile creation implemented
* Existing profile loading implemented

Profile creation flow:

```
User authenticates

↓

Authentication State

↓

Current Profile Provider

↓

Check Firestore profile

↓

Profile exists

OR

Create new RiderProfile

↓

Application uses rider identity
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

Future rider profile extensions:

* Motorcycle information
* Rider avatar
* Riding preferences
* Privacy settings
* Emergency information

---

# Current Application Flow

```
Android Device

↓

main.dart

↓

Firebase Initialization

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

Startup Check

↓

Authentication Check

↓

LoginScreen

OR

HomeScreen

↓

Current Rider Profile Loaded
```

---

# Phase 1 — Application Foundation

Status:

Complete

Completed:

* Flutter setup
* Android configuration
* Architecture setup
* Theme system
* Navigation system
* Firebase setup
* Authentication foundation
* Rider identity foundation

Deliverable:

User can launch the application, authenticate, and enter the application shell with a stored rider profile.

---

# Phase 2 — Map Foundation

Status:

Current Development

Goal:

Create the core map experience.

Features:

* Google Maps integration
* Map screen foundation
* Current location display
* Location permissions
* Map UI components
* Map state management

Deliverable:

RideTogether has a working map experience.

---

# Phase 3 — Ride System

Status:

Planned

Features:

* Create Ride
* Join Ride
* Invite links
* Ride codes
* QR code joining
* Ride permissions
* Rider roles

Deliverable:

Users can create and join group rides.

---

# Phase 4 — Live Tracking

Status:

Planned

Features:

* GPS permissions
* Location service
* Location updates
* Firebase Realtime Database integration
* Live rider markers
* Leader tracking
* Rider status
* Battery status

Deliverable:

Group members can see each other live on the map.

---

# Phase 5 — Navigation

Status:

Planned

Features:

* Google Directions API
* Route display
* Destination handling
* Leader route updates
* Waypoints
* ETA calculation
* Distance calculation

Deliverable:

Shared group navigation experience.

---

# Phase 6 — Checkpoints

Status:

Planned

Features:

* Fuel stops
* Break stops
* Custom checkpoints
* Arrival detection
* Checkpoint notifications

Deliverable:

Checkpoint management system.

---

# Phase 7 — Ride Communication

Status:

Planned

Features:

* Ride chat
* Quick messages
* Emergency button
* Leader broadcasts

Deliverable:

Basic ride communication system.

---

# Phase 8 — Smart Ride Features

Status:

Planned

Features:

* Regroup functionality
* Off-route detection
* Stopped rider detection
* Low battery alerts
* Ride timeline

Deliverable:

RideTogether-specific intelligence features.

---

# Phase 9 — Ride History

Status:

Planned

Features:

* Ride replay
* Distance statistics
* Average speed
* Ride photos
* Ride summaries

Deliverable:

Complete ride history experience.

---

# Phase 10 — Safety Features

Status:

Planned

Features:

* Crash detection
* Emergency contacts
* Hazard reporting
* Voice alerts

Deliverable:

Safety-focused riding experience.

---

# Future Features

## Community Features

Status:

Future

Features:

* Clubs
* Events
* Public rides
* Achievements
* Leaderboards
* Ride discovery

---

## Premium Features

Status:

Future

Features:

* Offline maps
* GPX import
* Weather layers
* Advanced analytics
* Cloud backup
* Priority support

---

# Future Journey Modes

Status:

Future

RideTogether currently focuses only on Ride mode.

Reach is not part of MVP.

---

# Journey Architecture

Future structure:

```
Journey

├── Ride

└── Reach
```

A Journey represents shared movement.

Future shared capabilities:

* Members
* Destination
* Location tracking
* Map visualization
* Status
* Notifications
* Chat
* Events
* History

Do not restructure the application for Journey until MVP completion.

---

# Ride Mode

Current core feature.

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

Example:

"Follow me to the mountain viewpoint."

---

# Reach Mode

Future feature.

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

Example:

"Everyone meet at this café."

---

# MVP Checklist

Current MVP goals:

* Authentication ✅
* Rider profiles ✅
* Home application shell ✅
* Map foundation
* Create Ride
* Join Ride
* Google Maps
* Live tracking
* Destination sharing
* Navigation
* Checkpoints
* Ride communication
* Notifications

---

# Version Roadmap

## v0.1 — User Foundation

Completed:

* Authentication
* Rider identity
* Application shell

---

## v0.2 — Map Foundation

Current target:

* Google Maps integration
* Location permissions
* Map screen

---

## v0.3 — Ride Foundation

Target:

* Create Ride
* Join Ride
* Ride permissions

---

## v0.4 — Live Ride Experience

Target:

* Live tracking
* Map integration
* Navigation foundation

---

## v0.5 — Group Ride Features

Target:

* Checkpoints
* Notifications
* Ride communication

---

## v1.0 — Production Release

Target:

* Android release
* iOS release
* Motorcycle-focused experience

---

# Long-Term Vision

Become the operating system for organized group rides.

Not only navigation.

Not only tracking.

A complete platform for safer and better group riding.