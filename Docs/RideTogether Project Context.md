# RideTogether Project Context

**Version:** 3.0  
**Last Updated:** 2026-07-17

---

## Table of Contents

1. [Purpose](#purpose)
2. [Product Overview](#product-overview)
3. [Product Principles](#product-principles)
4. [Current Development Status](#current-development-status)
5. [Completed Features](#completed-features)
6. [Map Foundation](#map-foundation)
7. [Map Responsibilities](#map-responsibilities)
8. [Location Architecture](#location-architecture)
9. [Completed Map Features](#completed-map-features)
10. [Architecture Overview](#architecture-overview)
11. [Feature Structure](#feature-structure)
12. [Important File Locations](#important-file-locations)
13. [Development Rules](#development-rules)
14. [Current Development Priorities](#current-development-priorities)
15. [Roadmap Summary](#roadmap-summary)
16. [Future Journey Architecture](#future-journey-architecture)
17. [Ride Mode](#ride-mode)
18. [Reach Mode](#reach-mode)
19. [Architecture Evolution Rules](#architecture-evolution-rules)

---

## Purpose

This document is the **primary context reference** for RideTogether.

Before making changes, understand:

- Product direction
- Current implementation status
- Architecture rules
- Completed features
- Next development priorities

This document should describe the **actual system**.

Update it after major milestones.

---

## Product Overview

RideTogether is a mobile-first group ride coordination application.

### Target Users

- Motorcycle riders
- Cyclists
- Road trip groups
- Convoys
- Adventure riders

### Core Philosophy

**RideTogether is not a navigation replacement.**

| Navigation Answers | RideTogether Answers |
|--------------------|----------------------|
| "How do I get there?" | "How do we get there together?" |

The application adds a **coordination layer** on top of navigation services.

### Core Capabilities

| Capability | Description |
|------------|-------------|
| Group Ride Management | Create, join, and manage group rides |
| Rider Identity | Profile, bike info, preferences |
| Rider Synchronization | Keep all riders coordinated |
| Live Locations | Real-time position sharing |
| Communication | In-ride messaging and alerts |
| Checkpoints | Planned stops and regroup points |
| Safety Features | Emergency alerts, off-route detection |

### Product Goal

> Make group riding easier, safer, and more connected.

---

## Product Principles

RideTogether should remain:

| Principle | Description |
|-----------|-------------|
| **Simple** | Intuitive interfaces that work while riding |
| **Fast** | Responsive, minimal latency |
| **Reliable** | Consistent behavior across conditions |
| **Safe** | Safety-critical features take precedence |
| **Distraction-free** | Minimal rider interaction while riding |

### Important Rules

| Rule | Rationale |
|------|-----------|
| The map is the primary experience | Core coordination happens on the map |
| Riders should interact minimally while riding | Safety first |
| Controls should be easy to use while riding | Glove-friendly, large targets |
| Battery usage matters | Long rides without charging |
| Network usage matters | Work in poor connectivity areas |
| Safety is more important than feature quantity | Quality over quantity |

---

## Current Development Status

### Current Version

**v0.0.4 — Map Foundation Complete**

---

## Completed Features

### Application Foundation

**Completed:**

- Flutter project setup
- Feature-first architecture
- Riverpod integration
- GoRouter routing
- Material 3 theme system
- Light/dark themes
- Application shell
- Splash screen
- Login screen
- Navigation foundation

---

### Firebase Foundation

**Completed:**

- Firebase initialization
- Firebase Authentication
- Cloud Firestore integration

---

### Authentication Foundation

**Completed:**

- Authentication repository
- Google Sign-In
- Firebase Authentication
- AppUser entity
- Authentication providers
- Login flow
- Logout flow
- Authentication state management

**Flow:**
```
Firebase Authentication
         ↓
    Auth Repository
         ↓
      AppUser
         ↓
    Auth Providers
```

---

### Rider Identity Foundation

**Completed:**

- RiderProfile entity
- Profile repository
- Firestore profile storage
- Profile providers
- Automatic profile creation
- Profile loading

**Purpose:**

| Authentication | Rider Profile |
|----------------|---------------|
| "Who is this user?" | "Who is this rider?" |

---

## Map Foundation

**Status: COMPLETE**

The map architecture is **provider agnostic**.

### Current Implementation

```
flutter_map
OpenStreetMap
```

### Architecture

```
AppMap
     ↓
MapEngine
     ↓
FlutterMapEngine
     ↓
flutter_map
```

### Future Providers

- Google Maps
- Mapbox
- HERE Maps

> **Changing providers should only require a new `MapEngine` implementation.**

---

## Map Responsibilities

### The Map Feature Owns

- Map rendering
- Camera control
- Markers
- Polylines
- Layers
- Map interactions
- Map overlays

### The Map Does NOT Own

- GPS
- Permissions
- Ride logic
- Rider synchronization
- Navigation logic

---

## Location Architecture

Location is **separate from maps**.

### Flow

```
GPS
    ↓
LocationRepository
    ↓
PositionEntity
    ↓
Riverpod Providers
    ↓
Map Rendering
```

### Current Implementation

```
Phone GPS
    ↓
GeolocatorLocationRepository
    ↓
PositionEntity
    ↓
currentPositionProvider
    ↓
UserLocationMarker
    ↓
AppMap
```

**Key Principle:** The map receives location data. The map never requests GPS directly.

---

## Completed Map Features

**Implemented:**

- MapEngine abstraction
- FlutterMapEngine
- OpenStreetMap rendering
- AppMap widget
- GeoPoint
- CameraPosition
- MapMarker
- MapPolyline
- MapBounds
- Position integration
- Current position stream
- User location marker
- Accuracy circle
- Heading animation
- Marker foundation
- Polyline foundation

---

## Architecture Overview

RideTogether follows:

- Feature-first architecture
- Repository pattern
- Riverpod state management
- Domain separation

### General Flow

```
Presentation
     ↓
Providers
     ↓
Domain
     ↓
Repositories
     ↓
External Systems
```

---

## Feature Structure

```
features/
├── auth/
├── profile/
├── startup/
├── map/
├── location/
└── ride/
```

### Feature Structure Template

```
feature/
├── data/
├── domain/
└── presentation/
```

---

## Important File Locations

| Purpose | Location |
|---------|----------|
| Application entry | `lib/main.dart` |
| App configuration | `lib/app/` |
| Routing | `lib/app/router/` |
| Theme system | `lib/core/theme/` |
| Authentication | `lib/features/auth/` |
| Rider profile | `lib/features/profile/` |
| Startup | `lib/features/startup/` |
| Map | `lib/features/map/` |
| Location | `lib/features/location/` |
| Firebase config | `lib/firebase_options.dart` |

---

## Development Rules

### Widgets

**Widgets should:**
- Render UI
- Receive state
- Trigger actions

**Widgets should NOT:**
- Access Firebase
- Access GPS
- Contain business logic

---

### Providers

**Providers manage:**
- Application state
- Feature state
- Dependency injection

---

### Repositories

**Repositories:**
- Hide external systems
- Expose application contracts

**Never:**
```
Widget
   ↓
Firebase/GPS/API
```

**Preferred:**
```
Widget
   ↓
Provider
   ↓
Repository
   ↓
External System
```

---

## Current Development Priorities

### Next Milestone: Map Experience

**Build:**
```
MapScreen
```

**The application moves toward:**
```
Authentication
     ↓
Map Experience
     ↓
Ride Features
```

---

## Roadmap Summary

| Phase | Status | Focus |
|-------|--------|-------|
| 1. Application Foundation | ✅ Complete | Flutter, Riverpod, GoRouter, Theme, Auth, Profile |
| 2. Map Foundation | ✅ Complete | Provider-agnostic map, OSM, Location integration |
| 3. Map Experience | 🔄 Next | MapScreen, Floating controls, Map modes |
| 4. Ride System | 📋 Planned | Create/join rides, Ride lifecycle, Roles |
| 5. Live Ride Experience | 📋 Planned | Rider sync, Live locations, Group map |
| 6. Navigation Foundation | 📋 Future | Route display, ETA, Waypoints |
| 7. Ride Coordination | 📋 Future | Checkpoints, Regroup, Communication |
| 8. Smart Ride Features | 📋 Future | Off-route detection, Safety alerts |
| 9. Ride History | 📋 Future | Replay, Statistics, Summaries |

---

## Future Journey Architecture

### Current MVP

```
Ride
```

### Future

```
Journey
├── Ride
└── Reach
```

**Journey owns shared concepts:**
- Members
- Status
- Notifications
- History
- Location sharing

**Rule:** Do not duplicate these systems.

---

## Ride Mode

**Current MVP.**

### Purpose

Travel together.

### Experience

Follow the leader.

### Capabilities

| Capability | Description |
|------------|-------------|
| Leader | Designated ride leader |
| Route Control | Leader controls the route |
| Checkpoints | Planned stops |
| Regroup Commands | Leader can call regroup |
| Group Synchronization | Keep riders together |

---

## Reach Mode

**Future.**

### Purpose

Meet at a destination.

### Experience

Everyone travels independently.

### Capabilities

| Capability | Description |
|------------|-------------|
| Shared Destination | Common meeting point |
| Arrival Tracking | Monitor who has arrived |
| Participant Progress | See everyone's progress |

---

## Architecture Evolution Rules

### After Major Milestones Update

- Version
- Completed features
- Architecture changes
- Important files
- Priorities

### Do Not

- Document features that do not exist
- Create speculative modules
- Couple features together unnecessarily
- Put business logic into infrastructure layers

---

The context document should always describe the **current system** and the **next intention**.