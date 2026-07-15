# RideTogether Project Context

Version: 1.5

Last Updated:
2026-07-15

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
- Rider identity
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
v0.0.4 — Map Foundation
```

---

## Completed Features

### Application Foundation

- Flutter project created
- Android environment configured
- Physical device testing verified
- Feature-first architecture created
- Riverpod integrated
- GoRouter integrated
- Google Fonts integrated
- Material 3 theme foundation created
- Centralized theme system created
- Light and dark theme support implemented
- Application routing implemented
- Splash screen implemented
- Login screen implemented
- Home screen implemented
- Application identity configured

### Firebase Foundation

- Firebase project created
- Firebase Android application configured
- FlutterFire CLI configured
- Firebase initialized during application startup
- Current Firebase services: Firebase Core, Firebase Authentication, Cloud Firestore

### Authentication Foundation

- Authentication repository architecture created
- Google Sign-In implemented
- Firebase Authentication implemented
- AppUser domain model created
- Firebase user mapping implemented
- Authentication providers created
- Login flow implemented
- Logout flow implemented
- Authentication state handling implemented
- Startup authentication checking implemented

### Rider Identity Foundation

- RiderProfile domain entity created
- Profile repository abstraction created
- Firebase profile repository implemented
- Firestore profile datasource created
- Profile providers created
- Automatic profile creation after authentication implemented
- Existing profile loading implemented

---

## In Progress

### Map Foundation (Phase 2)

**Status:** Phases 1-5 Complete, Phase 6 Next

- MapProvider abstraction defined (provider-agnostic map rendering)
- LocationRepository abstraction defined (separate location/GPS services)
- FlutterMapProvider implementation completed (flutter_map + OpenStreetMap)
- GeolocatorLocationRepository implementation planned (geolocator package)
- Feature structure defined: `features/map/` and `features/location/`
- Dependencies documented: flutter_map, latlong2, geolocator, geocoding
- Platform configuration documented for Android/iOS/Web
- AppMap widget created with Riverpod providers
- Camera operations implemented (move, animate, zoom, fitBounds)
- Marker operations implemented (add, remove, update, clear)
- Polyline operations implemented (add, remove, clear)
- Map event system implemented (MapEvent, EventBus)

---

# Architecture Overview

RideTogether follows a feature-first architecture with Riverpod for state management and GoRouter for navigation.

### Architecture Layers

```
UI (Widgets)
    ↓
Riverpod Providers (State Management & DI)
    ↓
Repositories (Abstractions)
    ↓
Data Sources (Implementations)
    ↓
External Systems (Firebase, Maps, GPS, etc.)
```

### Feature Structure

Each feature follows this structure:

```
features/
  feature_name/
    data/
      - models/
      - repositories/
      - datasources/
    domain/
      - entities/
      - repositories/
      - mappers/
    presentation/
      - screens/
      - widgets/
      - providers/
```

### Current Features

- **auth/** — Google Sign-In, Firebase Auth, user state management
- **home/** — Home screen presentation
- **profile/** — RiderProfile entity, repository, Firestore datasource, providers
- **startup/** — Splash screen, authentication check, profile loading
- **map/** — MapProvider abstraction, FlutterMapProvider, camera/marker/polyline operations, AppMap widget
- **location/** — (Planned) LocationRepository abstraction, GeolocatorLocationRepository

---

# Important File Locations

| Purpose | Location |
|---------|----------|
| Application entry | `lib/main.dart` |
| App configuration | `lib/app/app.dart` |
| Routing | `lib/app/router/app_router.dart` |
| Theme system | `lib/core/theme/` |
| Authentication feature | `lib/features/auth/` |
| Profile feature | `lib/features/profile/` |
| Startup feature | `lib/features/startup/` |
| Map feature | `lib/features/map/` |
| Location feature (planned) | `lib/features/location/` |
| Firebase config | `lib/firebase_options.dart` |
| Project config | `pubspec.yaml`, `firebase.json` |

---

# Development Rules

### Architecture Rules

- Feature-first organization
- Repository pattern for data access
- Riverpod for state management and DI
- GoRouter for navigation
- Separation of concerns: UI → Providers → Repositories → Data Sources → External Systems

### Coding Rules

- Widgets only handle UI rendering
- Business logic in providers, repositories, services
- No Firebase calls in widgets
- Use repository abstractions, not direct external service calls
- All UI styling through `lib/core/theme/`

### Design System

All styling through `lib/core/theme/`:
- Colors, typography, spacing, radius, shadows, durations
- Use `Theme.of(context)` for adaptive styling
- No hardcoded colors, spacing, or animation values

---

# Current Development Priorities

1. **Complete map foundation** — Implement MapProvider and LocationRepository abstractions with OpenStreetMap/flutter_map
2. **Integrate location permissions** — Request and manage GPS permissions
3. **Create map experience** — Build map screen with camera, markers, and polylines
4. **Create Ride feature** — Group ride creation, joining, and management
5. **Add live location tracking** — Real-time rider positions during rides
6. **Add group synchronization** — Leader/follower coordination, checkpoints, regroup commands

---

# Future Direction

### Mapping Architecture

RideTogether uses a **provider-agnostic mapping architecture**. The current implementation uses **OpenStreetMap via flutter_map**, but the application is designed so the underlying map provider can be replaced (Google Maps, Mapbox, HERE, etc.) without affecting business logic.

**Maps and Location are separate features:**
- **Map feature** — Rendering, camera, markers, polylines, tile providers
- **Location feature** — GPS, permissions, current position, continuous updates, geocoding

**Abstractions:**
- `MapProvider` interface with implementations: `FlutterMapProvider` (current), `GoogleMapsProvider` (future), `MapboxProvider` (future), `HEREMapsProvider` (future)
- `LocationRepository` interface with implementations: `GeolocatorLocationRepository` (current), alternatives for testing/future providers

---

### Journey Architecture

RideTogether currently focuses only on **Ride mode**. **Reach** is a future feature.

Future architecture:

```
Journey
├── Ride
└── Reach
```

A Journey represents a shared group movement activity. Shared Journey functionality includes: members, destination, location tracking, map visualization, status, notifications, chat, events, history.

Do not restructure the current project for Reach before MVP completion.

---

### Ride Mode (Current MVP)

- Purpose: Travel together
- Experience: Follow the leader
- Control: Leader controlled
- Capabilities: Leader, route control, checkpoints, regroup commands, group synchronization

---

### Reach Mode (Future)

- Purpose: Meet at a destination
- Experience: Everyone travels independently
- Control: No leader
- Capabilities: Shared destination, individual navigation, arrival tracking, participant progress

---

### Future Technical Direction

- **Live Tracking** — GPS updates, rider location synchronization, Realtime Database
- **Communication** — Ride chat, notifications, emergency communication
- **Safety** — Crash detection, hazard reporting, emergency contacts

---

# Architecture Evolution Rules

After major milestones update:
- Version number
- Current status
- Completed architecture
- Important file locations
- Development priorities

Do not:
- Add speculative architecture
- Create future modules before implementation
- Duplicate shared systems
- Move files without architectural reason

The architecture document should always describe the implemented system, not only future plans.