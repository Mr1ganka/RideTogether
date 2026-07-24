# RideTogether AI Development Instructions

**Version:** 4.1  
**Last Updated:** 2026-07-23

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

### Startup Location Flow

Location permission is checked during startup:

```
SplashScreen (startupProvider)
    │
    ├── StartupLocationRequired → LocationRequiredScreen
    │       ├── Grant → invalidate startupProvider → re-check
    │       ├── Permanently Denied → Open Settings
    │       └── Denied → Request permission dialog
    │
    └── StartupReady → HomeScreen (map)
```

**Lifecycle:** `AppLifecycleObserver` watches app lifecycle and invalidates `startupProvider` on resume, ensuring permissions are re-checked when the user returns from Settings.

---

## Current Map Features Completed

**Implemented:**

- MapEngine abstraction
- FlutterMapEngine
- OpenStreetMap rendering
- AppMap widget (now accepts `MapController` for external camera control)
- `mapControllerProvider` — shared MapController for navbar recentering
- Camera domain models
- GeoPoint
- Map markers
- Map polylines
- `MapMode` enum (`idle`, `searchingRide`, `activeRide`, `navigation`, `completedRide`)
- `mapModeProvider` — Riverpod state for current map mode
- Map bounds
- Current location stream
- User location marker
- Accuracy circle
- Heading indicator
- Location animations
- Floating Map Controls (navbar with NavHandle auto-hide, Recenter button, JoinRide pill)
- Direction Cone Painter refactored to use design tokens
- Location permission flow integrated into startup (`StartupResult`, `LocationRequiredScreen`)
- `AppLifecycleObserver` re-checks permissions on app resume
- `startupProvider` now returns `Future<StartupResult>` (typed instead of `void`)

---

## Current Development Status

### Current Milestone

```
Map Experience
DONE (Floating Controls + Map Modes)
```

### Next Milestone

```
Join Ride Flow
```

The map is now the main application experience with floating controls.

---

## Next Implementation Roadmap

### Phase 1 — Map Screen

**Status:** ✅ The map is the primary screen via `HomeScreen`. No separate `MapScreen` was created — floating controls were integrated directly into `HomeScreen` as a more practical approach.

**Current structure:**

```
HomeScreen
Stack
├── AppMap (with mapController)
└── FloatingMapControls
    ├── RecenterButton
    ├── BottomNavBar (Profile, Rides, JoinRide, Settings, Logout)
    └── NavHandle (slide toggle)
```

---

### Phase 2 — Floating Map Controls ✅

**Status:** ✅ Complete

**Created:**
- `features/map/presentation/widgets/floating_map_controls.dart` (export hub)
- `features/map/presentation/widgets/navbar/bottom_nav_bar.dart`
- `features/map/presentation/widgets/navbar/floating_map_controls.dart` (main widget with AutoHide logic)
- `features/map/presentation/widgets/navbar/recenter_button.dart`
- `features/map/presentation/widgets/navbar/nav_icon_button.dart`
- `features/map/presentation/widgets/navbar/join_ride_pill.dart`
- `features/map/presentation/widgets/navbar/nav_handle.dart`

**Design:**

Bottom bar across full width (not a FAB stack):
- Translucent surface panel (`surface` at 0.94 opacity, `AppRadius.xl`)
- Row of `NavIconButton` tiles + center `JoinRidePill`
- `NavHandle` sits on top of the bar for toggle
- `RecenterButton` positioned above-right of the bar

**Idle Controls:**
| Control | Icon | Action |
|---------|------|--------|
| Join Ride | `group_add_outlined` (pill) | Navigate to join flow |
| Profile | `person_outlined` | Open rider profile |
| Rides | `history_outlined` | View ride history |
| Settings | `settings_outlined` | App settings |
| Logout | `logout` | Sign out |

**Standalone Recenter Button:**
- `my_location` icon in circular container
- Always visible (except in `navigation` mode)
- Centers map on user's current GPS position via `mapController`

**Visibility Behavior (via `FloatingMapControls` widget):**

| Mode | Behavior |
|------|----------|
| `idle` | Controls always visible, no auto-hide |
| `activeRide` | Controls auto-slide down after 3s of inactivity. Tap to bring back up for another 3s. |
| `navigation` | Controls hidden (returns `SizedBox.shrink`) |

**Transitions:**
- Slide down/up animation using `AppDurations.normal` (300ms) + `CurvedAnimation(curve: Curves.easeInOut)`
- When switching `idle → activeRide`, controls hide
- When switching `activeRide → idle`, controls show
- `SlideTransition` with `Tween<Offset>(begin: Offset.zero, end: Offset(0, 1.15))`

**State:**
- Uses `SingleTickerProviderStateMixin` for slide animation
- Uses `Timer` with `AppDurations.autoHideNav` (3s) for auto-hide
- Reads `mapModeProvider` to decide visibility
- Reads `currentPositionProvider` and `authRepositoryProvider` for actions

**Controls appear over the map in a Stack within `HomeScreen`.**

---

### Phase 3 — Map Modes ✅

**Status:** ✅ Complete

**Created:**
- `features/map/domain/entities/map_mode.dart` — `MapMode` enum
- `features/map/presentation/providers/map_mode_provider.dart` — `StateProvider<MapMode>`

```dart
enum MapMode {
  idle,
  searchingRide,
  activeRide,
  navigation,
  completedRide,
}
```

Each mode controls visible overlays and FloatingMapControls behavior:
- `idle` — Full controls visible, Recenter active, no auto-hide
- `searchingRide` — Join Ride replaced with Cancel Search
- `activeRide` — Controls auto-hide after 3s, Ride controls visible
- `navigation` — All controls hidden (minimal distraction)
- `completedRide` — Ride summary panel, controls return to idle

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

1. ~~**MapScreen**~~ — Main map experience (currently via `HomeScreen` + floating controls)
2. ~~**Floating map controls**~~ — ✅ Done (navbar, recenter, auto-hide)
3. ~~**Map state system**~~ — ✅ Done (`MapMode`, `mapModeProvider`, `mapControllerProvider`)
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

*Document Version 4.0 — Updated after Floating Map Controls & Map Modes completion.*