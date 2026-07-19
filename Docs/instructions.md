# RideTogether AI Development Instructions

**Version:** 3.0  
**Last Updated:** 2026-07-17

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Core Philosophy](#core-philosophy)
3. [Technology Stack](#technology-stack)
4. [Architecture Rules](#architecture-rules)
5. [Completed Foundations](#completed-foundations)
6. [Map Foundation](#map-foundation)
7. [Map Responsibilities](#map-responsibilities)
8. [Location Architecture](#location-architecture)
9. [Current Map Features Completed](#current-map-features-completed)
10. [Current Development Status](#current-development-status)
11. [Next Implementation Roadmap](#next-implementation-roadmap)
12. [Future Journey Architecture](#future-journey-architecture)
13. [Ride Mode](#ride-mode)
14. [Reach Mode](#reach-mode)
15. [Architecture Evolution Rules](#architecture-evolution-rules)
16. [Important AI Rules](#important-ai-rules)
17. [Current Priority Order](#current-priority-order)
18. [Architecture Goal](#architecture-goal)

---

## Project Overview

RideTogether is a mobile-first group ride coordination application.

### Target Users

- Motorcycle riders
- Cyclists
- Road trip groups
- Convoys
- Adventure riders

### Core Purpose

**RideTogether is not a navigation replacement.**

- Navigation answers: *"How do I get there?"*
- RideTogether answers: *"How do we get there together?"*

The application provides a coordination layer on top of navigation services.

### Core Capabilities

| Capability | Description |
|------------|-------------|
| Group Ride Management | Create, join, and manage group rides |
| Rider Synchronization | Keep all riders coordinated |
| Live Rider Locations | Real-time position sharing |
| Communication | In-ride messaging and alerts |
| Checkpoints | Planned stops and regroup points |
| Safety Features | Emergency alerts, off-route detection |

### Product Goal

> Make group riding easier, safer, and more connected.

---

## Core Philosophy

### Guiding Question

> **Does this make group riding easier or safer?**

### Priorities

1. **Simple user experience** — Intuitive interfaces that work while riding
2. **Minimal rider interaction** — Reduce distraction during rides
3. **Reliable operation** — Consistent behavior across conditions
4. **Low battery usage** — Optimize for extended rides
5. **Low network usage** — Work in areas with poor connectivity
6. **Safety over feature quantity** — Safety-critical features take precedence

### Primary Experience

**The map is the primary application experience.**

---

## Technology Stack

### Frontend

| Technology | Version | Purpose |
|------------|---------|---------|
| Flutter | 3.32+ | Cross-platform UI framework |
| Riverpod | 2.5+ | State management |
| GoRouter | 14.2+ | Navigation/routing |
| Material 3 | Latest | Design system |

### Backend

#### Current
| Service | Purpose |
|---------|---------|
| Firebase Authentication | User authentication (Google Sign-In) |
| Cloud Firestore | Database (profiles, rides, real-time sync) |

#### Future
| Service | Purpose |
|---------|---------|
| Firebase Messaging | Push notifications |
| Cloud Functions | Serverless backend logic |
| Realtime Database | Low-latency presence/location |
| Storage | Media files (ride photos) |
| Crashlytics | Crash reporting |
| Analytics | Usage analytics |

---

## Architecture Rules

RideTogether uses:

- **Feature-first architecture** — Code organized by feature, not layer
- **Repository pattern** — Abstract external systems behind interfaces
- **Domain-driven separation** — Pure domain layer with no framework dependencies
- **Riverpod state management** — Declarative, compile-safe state management

### General Data Flow

```
UI (Widgets)
     ↓
Providers (Riverpod)
     ↓
Domain (Entities, Repositories, Use Cases)
     ↓
Repositories (Interfaces)
     ↓
External Services (Firebase, GPS, APIs)
```

### Layer Responsibilities

#### Widgets (Presentation)
| Must | Must NOT |
|------|----------|
| Render UI | Access Firebase directly |
| Receive state | Access GPS directly |
| Trigger actions | Contain business logic |

#### Providers (Presentation)
| Responsibility |
|----------------|
| Manage state |
| Coordinate features |

#### Repositories (Data)
| Responsibility |
|----------------|
| Hide external systems |

---

## Completed Foundations

### Application Foundation

**Status:** ✅ Complete

| Component | Status |
|-----------|--------|
| Flutter project setup | ✅ |
| Feature-first structure | ✅ |
| Riverpod integration | ✅ |
| GoRouter routing | ✅ |
| Material 3 theme | ✅ |
| Light/dark themes | ✅ |
| Application shell | ✅ |

---

### Authentication Foundation

**Status:** ✅ Complete

| Component | Status |
|-----------|--------|
| Firebase Authentication | ✅ |
| Google Sign-In | ✅ |
| Auth repository | ✅ |
| AppUser entity | ✅ |
| Authentication providers | ✅ |
| Login flow | ✅ |
| Logout flow | ✅ |
| Authentication state handling | ✅ |

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

**Status:** ✅ Complete

| Component | Status |
|-----------|--------|
| RiderProfile entity | ✅ |
| Profile repository | ✅ |
| Firestore profile storage | ✅ |
| Profile providers | ✅ |
| Automatic profile creation | ✅ |
| Profile loading | ✅ |

**Purpose:**

| Authentication | Rider Profile |
|----------------|---------------|
| "Who is this user?" | "Who is this rider?" |

---

## Map Foundation

**Status:** ✅ COMPLETE

The map system is **provider agnostic**.

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

> **Rule:** A provider change should only require a new `MapEngine` implementation.

---

## Map Responsibilities

### The Map Feature Owns

- Map rendering
- Camera movement
- Markers
- Polylines
- Layers
- Map interactions
- Overlays

### The Map Does NOT Own

- GPS
- Permissions
- Ride logic
- Rider synchronization
- Navigation logic

---

## Location Architecture

Location is **independent from maps**.

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

**Key Principle:** The map receives location data. The map never requests GPS.

---

## Current Map Features Completed

**Implemented:**

- MapEngine abstraction
- FlutterMapEngine
- OpenStreetMap rendering
- AppMap widget
- Camera domain models
- GeoPoint
- Map markers
- Map polylines
- Map bounds
- Current location stream
- User location marker
- Accuracy circle
- Heading indicator
- Location animations

---

## Current Development Status

### Current Milestone

```
Map Foundation
DONE
```

### Next Milestone

```
Map Experience
```

The map becomes the main application screen.

---

## Next Implementation Roadmap

### Phase 1 — Map Screen

**Create:** `features/map/presentation/screens/map_screen.dart`

**Purpose:** The main application workspace.

**Structure:**

```
MapScreen
Stack
├── AppMap
├── Floating Controls
├── Ride Panels
├── Bottom Sheets
└── Dialogs
```

**The map remains independent.**

---

### Phase 2 — Floating Map Controls

**Add contextual controls:**

**Idle Controls:**
- Join Ride
- Profile
- My Rides
- Settings
- Recenter

**Future Ride Controls:**
- Ride information
- Rider list
- Route options
- Group status

**Controls should appear over the map.**

---

### Phase 3 — Map Modes

**Introduce:**

```dart
enum MapMode {
  idle,
  searchingRide,
  activeRide,
  navigation,
  completedRide,
}
```

Each mode controls visible overlays.

---

### Phase 4 — Ride Feature

**Build ride functionality on top of the map.**

**Ride Owns:**
- Creating rides
- Joining rides
- Rider roles
- Leader
- Ride lifecycle
- Checkpoints
- Group state

**The map only displays ride information.**

---

### Phase 5 — Live Rider Experience

**Future:**

**Rider Markers:**
```
Rider A        Rider B
  🚦             🚦
```

**Architecture:**
```
Rider Location
      ↓
Ride State
      ↓
Map Overlay
      ↓
MapScreen
```

---

### Phase 6 — Background Tracking

**Only after Ride exists.**

**Flow:**
```
GPS
  ↓
Location Repository
  ↓
Ride Location Service
  ↓
Cloud Backend
  ↓
Other Riders
```

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

**Shared functionality belongs in Journey:**

- Members
- Status
- Notifications
- History
- Location sharing

**Rule:** Do not duplicate systems.

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

**After major milestones, update:**

- Version
- Completed features
- Architecture changes
- Important files
- Priorities

**Do Not:**

- Document features that do not exist
- Create speculative modules
- Couple features together unnecessarily
- Put business logic into infrastructure layers

---

## Important AI Rules

### When Implementing: DO

| Rule | Description |
|------|-------------|
| Follow existing abstractions | Use established patterns |
| Keep features isolated | Don't cross feature boundaries |
| Use repositories | Never access external systems directly |
| Use providers for state | Riverpod for all state management |
| Keep widgets simple | Render only, no logic |

### When Implementing: DO NOT

| Rule | Description |
|------|-------------|
| Put Firebase calls in widgets | Use repositories |
| Put GPS calls in map code | Location is separate |
| Put ride logic inside MapEngine | Map is for rendering only |
| Couple application code to flutter_map | Use MapEngine abstraction |
| Couple application code to OpenStreetMap | Provider-agnostic |

---

## Current Priority Order

**Implement in this order:**

1. **MapScreen** — Main map experience
2. **Floating map controls** — Contextual UI overlays
3. **Map state system** — MapMode enum and state management
4. **Join Ride flow** — Entry point for rides
5. **Ride feature** — Create/join rides, lifecycle
6. **Rider synchronization** — Live location sharing
7. **Live group map experience** — Group ride visualization

> **Do not build advanced ride features before the map experience is complete.**

---

## Architecture Goal

### Final Direction

```
Map Experience
      ↓
Ride Coordination
      ↓
Live Group Movement
      ↓
Future Journey Platform
```

### While Maintaining

- Clean architecture
- Provider independence
- Feature separation
- Testability
- Rider safety

---

*Document Version 3.0 — Updated after Map Foundation completion.*