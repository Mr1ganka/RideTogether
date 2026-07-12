# RideTogether Roadmap

Version: 1.3

---

# Development Progress

## Current Version

v0.0.2 — Authentication Foundation


## Current Status

The application foundation is complete.

Authentication foundation has been implemented.

Current development priority:

Authentication → Application Shell → Maps → Ride System


---

# Completed Features

## Application Foundation

Completed:

- Flutter project created
- Android development environment configured
- Physical device testing verified
- Feature-first architecture created
- Riverpod integrated
- GoRouter integrated
- Google Fonts integrated
- Application shell created
- Material 3 theme system created
- Light and dark theme support created
- Application routing implemented
- Splash screen implemented
- Login screen implemented
- Home screen implemented


## Android Configuration

Package:

com.ridetogether.app


Namespace:

com.ridetogether.app


Application ID:

com.ridetogether.app


## Firebase Foundation

Completed:

- Firebase project created
- Firebase Android application configured
- FlutterFire CLI configured
- Firebase initialization completed


## Authentication

Completed:

- Authentication repository architecture created
- Google Sign-In implemented
- Firebase Authentication implemented
- AppUser model created
- Login flow implemented
- Logout flow implemented


---

# Current Application Flow

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

Authentication Check

↓

LoginScreen or HomeScreen


---

# Phase 1 — Application Foundation

Status:

Complete


Completed:

- Flutter setup
- Android configuration
- Architecture setup
- Theme system
- Navigation system
- Firebase setup
- Authentication foundation


Deliverable:

User can launch the application, authenticate, and enter the application shell.


---

# Phase 2 — Rider Accounts

Status:

Planned


Features:

- User profiles
- Rider information
- Motorcycle information
- Profile avatar
- Account settings
- Privacy controls


Deliverable:

Complete rider identity system.


---

# Phase 3 — Ride System

Status:

Planned


Features:

- Create Ride
- Join Ride
- Invite links
- Ride codes
- QR code joining
- Ride permissions


Deliverable:

Users can create and join group rides.


---

# Phase 4 — Map Foundation

Status:

Planned


Features:

- Google Maps integration
- Map screen foundation
- Current location display
- Destination selection
- Map UI components


Deliverable:

RideTogether map experience.


---

# Phase 5 — Live Tracking

Status:

Planned


Features:

- GPS permissions
- Location service
- Location updates
- Firebase Realtime Database integration
- Live rider markers
- Leader tracking
- Rider status
- Battery status


Deliverable:

Group members can see each other live on the map.


---

# Phase 6 — Navigation

Status:

Planned


Features:

- Google Directions API
- Route display
- Destination handling
- Leader route updates
- Waypoints
- ETA calculation
- Distance calculation


Deliverable:

Shared group navigation experience.


---

# Phase 7 — Checkpoints

Status:

Planned


Features:

- Fuel stops
- Break stops
- Custom checkpoints
- Arrival detection
- Checkpoint notifications


Deliverable:

Checkpoint management system.


---

# Phase 8 — Ride Communication

Status:

Planned


Features:

- Ride chat
- Quick messages
- Emergency button
- Leader broadcasts


Deliverable:

Basic ride communication system.


---

# Phase 9 — Smart Ride Features

Status:

Planned


Features:

- Regroup functionality
- Off-route detection
- Stopped rider detection
- Low battery alerts
- Ride timeline


Deliverable:

RideTogether-specific intelligence features.


---

# Phase 10 — Ride History

Status:

Planned


Features:

- Ride replay
- Distance statistics
- Average speed
- Ride photos
- Ride summaries


Deliverable:

Complete ride history experience.


---

# Phase 11 — Safety Features

Status:

Planned


Features:

- Crash detection
- Emergency contacts
- Hazard reporting
- Voice alerts


Deliverable:

Safety-focused riding experience.


---

# Phase 12 — Community Features

Status:

Future


Features:

- Clubs
- Events
- Public rides
- Achievements
- Leaderboards
- Ride discovery


Deliverable:

Community platform for riders.


---

# Phase 13 — Premium Features

Status:

Future


Features:

- Offline maps
- GPX import
- Weather layers
- Advanced analytics
- Cloud backup
- Priority support


Deliverable:

Premium subscription offering.


---

# Future Journey Modes

Status:

Coming Soon


Reach is a future journey mode.

Reach is not part of the MVP.

Current MVP priority:

Authentication

↓

Profiles

↓

Ride System

↓

Live Tracking

↓

Navigation


---

# Journey Architecture

Future Journey structure:

Journey

- Ride
- Reach


Journey represents a shared movement activity.


Future shared Journey capabilities:

- Members
- Destination
- Location tracking
- Map visualization
- Status
- Notifications
- Chat
- Events
- History


Future implementation may use:

features/journey/


Do not restructure the project for Reach before MVP completion.


---

# Ride Mode

Current core feature.


Purpose:

Travel together.


Experience:

Follow the leader.


Control:

Leader controlled.


Features:

- Leader
- Route control
- Checkpoints
- Regroup commands
- Group synchronization


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


Features:

- Create Reach destination
- Join Reach
- Shared destination
- Live participant locations
- Arrival detection
- Rider progress
- ETA
- Completion status


Example:

"Everyone meet at this café."


---

# MVP Checklist

- Authentication
- User profiles
- Home map shell
- Create Ride
- Join Ride
- Google Maps
- Live tracking
- Destination sharing
- Navigation
- Checkpoints
- Ride chat
- Notifications


---

# Version Roadmap


## v0.1 — User Foundation

Target:

- Authentication complete
- User profile
- Home map shell


---

## v0.2 — Ride Foundation

Target:

- Create Ride
- Join Ride
- Ride permissions


---

## v0.3 — Live Ride Experience

Target:

- Live tracking
- Map integration
- Navigation foundation


---

## v0.4 — Group Ride Features

Target:

- Checkpoints
- Notifications
- Ride communication


---

## v0.5 — Advanced Ride Features

Target:

- Regroup
- Leader controls
- Ride history
- Statistics


---

## v1.0 — Production Release

Target:

- Android release
- iOS release
- Motorcycle-focused experience


---

# Long-Term Vision

Become the operating system for organized group rides.

Not only navigation.

Not only tracking.

A complete platform for safer and better group riding.