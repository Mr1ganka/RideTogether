# RideTogether Roadmap

**Version:** 4.1  
**Last Updated:** 2026-07-23

---

## Table of Contents

1. [Development Progress](#development-progress)
2. [Phase 1 — Application Foundation](#phase-1--application-foundation)
3. [Phase 2 — Map Foundation](#phase-2--map-foundation)
4. [Phase 3 — Map Experience](#phase-3--map-experience)
5. [Phase 4 — Map State System](#phase-4--map-state-system)
6. [Phase 5 — Ride System](#phase-5--ride-system)
7. [Phase 6 — Live Ride Experience](#phase-6--live-ride-experience)
8. [Phase 7 — Navigation Foundation](#phase-7--navigation-foundation)
9. [Phase 8 — Ride Coordination Features](#phase-8--ride-coordination-features)
10. [Phase 9 — Smart Ride Features](#phase-9--smart-ride-features)
11. [Phase 10 — Ride History](#phase-10--ride-history)
12. [Future Journey Architecture](#future-journey-architecture)
13. [Ride Mode](#ride-mode)
14. [Reach Mode](#reach-mode)
15. [MVP Goals](#mvp-goals)
16. [Version Roadmap](#version-roadmap)
17. [Long-Term Vision](#long-term-vision)

---

## Development Progress

### Current Version

**v0.3 — Map Experience Complete**

### Status Flow

```
Application Foundation ✅
         ↓
Authentication ✅
         ↓
Rider Identity ✅
         ↓
Map Foundation ✅
          ↓
Map Experience ✅
          ↓
Join Ride Flow 🔄 Next
         ↓
Live Ride Experience
```

---

## Phase 1 — Application Foundation

**Status:** ✅ Complete

### Completed Components

| Component | Description |
|-----------|-------------|
| Flutter project setup | Initial project configuration |
| Feature-first architecture | Organized by feature, not layer |
| Riverpod integration | State management setup |
| GoRouter routing | Declarative navigation |
| Material 3 theme system | Design system with light/dark |
| Application shell | Root widget structure |
| Firebase initialization | Core Firebase setup |
| Authentication foundation | Auth infrastructure |
| Rider identity foundation | Profile infrastructure |

### Deliverable

> Users can launch the application, authenticate, enter the application with a stored rider profile, and location permissions are verified during startup with a dedicated permission screen.

---

### Startup Location Flow

**Files:**
- `lib/features/startup/domain/entities/startup_result.dart` — `StartupResult` sealed class
- `lib/features/location/presentation/screens/location_required_screen.dart`
- `lib/core/providers/app_lifecycle_providers.dart` — `AppLifecycleObserver`

**Flow:**
```
SplashScreen (startupProvider)
    │
    ├── StartupLocationRequired → LocationRequiredScreen
    │       ├── Grant → invalidate startupProvider → re-check
    │       └── Permanently Denied / Settings required → Open App Settings
    │
    └── StartupReady → HomeScreen
```

**Key details:**
- `startupProvider` returns `Future<StartupResult>` — typed result instead of `void`
- `LocationPermissionNotifier` gained `ensurePermissionGranted()`, `refreshPermission()`, `hasRequestedPermission` flag
- `AppLifecycleObserver` watches `WidgetsBindingObserver` and invalidates `startupProvider` on `resumed`, re-checking permissions when user returns from Settings

---

## Phase 2 — Map Foundation

**Status:** ✅ Complete

### Goal

Create a **provider-independent map system** that can support different map providers without changing application logic.

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

### Completed Components

| Component | Description |
|-----------|-------------|
| Provider-agnostic MapEngine abstraction | Interface for map providers |
| FlutterMapEngine implementation | flutter_map + OSM implementation |
| OpenStreetMap rendering | Tile rendering |
| Camera foundation | Camera position, movement |
| Marker system | Domain models and rendering |
| Polyline foundation | Route/path rendering |
| Map entities | GeoPoint, CameraPosition, MapMarker, MapPolyline, MapBounds |
| Map overlays | Layer composition |
| Location integration | PositionEntity to map |
| User location marker | Custom animated marker |
| Live position updates | Real-time GPS stream |

### Architecture Rules

| Map Handles | Location Handles |
|-------------|------------------|
| Rendering | GPS |
| Camera | Permissions |
| Markers | Position updates |
| Polylines | Geocoding |
| Layers | |
| Interactions | |

> **The map never accesses GPS directly.**

---

## Phase 3 — Map Experience

**Status:** ✅ Complete

### Goal

Make the map the **primary application experience**.

### Direction

**Before:**
```
HomeScreen
     ↓
Open Map
```

**After:**
```
Authentication
     ↓
HomeScreen (Map-first)
     ├── AppMap (with MapController)
     └── FloatingMapControls
```

The map is now the default screen after auth. `HomeScreen` acts as the map experience — a separate `MapScreen` was not created since integrating controls directly into `HomeScreen` was the more practical approach.

---

### MapScreen (via `HomeScreen`)

**File:** `features/home/presentation/screens/home_screen.dart`

#### Responsibilities

- Own the map experience
- Compose map overlays
- Manage map UI state
- Provide foundation for ride features

#### Structure

```
HomeScreen
Stack
├── AppMap (with mapController & initialCamera)
├── FloatingMapControls
│   ├── RecenterButton
│   ├── BottomNavBar
│   │   ├── NavIconButton (Profile)
│   │   ├── NavIconButton (Rides)
│   │   ├── JoinRidePill
│   │   ├── NavIconButton (Settings)
│   │   └── NavIconButton (Logout)
│   └── NavHandle (slide toggle)
├── Ride Panels (future)
└── Bottom Sheets (future)
```

---

### Floating Map Controls ✅

**Status:** ✅ Complete

**Created:**
- `features/map/presentation/widgets/floating_map_controls.dart` (export hub)
- `features/map/presentation/widgets/navbar/floating_map_controls.dart` (main widget with animations)
- `features/map/presentation/widgets/navbar/bottom_nav_bar.dart`
- `features/map/presentation/widgets/navbar/recenter_button.dart`
- `features/map/presentation/widgets/navbar/nav_icon_button.dart`
- `features/map/presentation/widgets/navbar/join_ride_pill.dart`
- `features/map/presentation/widgets/navbar/nav_handle.dart`

#### Design

Bottom bar across full width:
- Translucent surface panel (`surface` at 0.94 opacity, `AppRadius.xl`)
- Row of `NavIconButton` tiles + centered `JoinRidePill`
- `NavHandle` on top of bar for show/hide toggle
- `RecenterButton` (circular, `my_location` icon) positioned above-right of bar

#### Idle Controls

| Control | Icon | Action |
|---------|------|--------|
| Join Ride | `group_add_outlined` (pill) | Navigate to join flow |
| Profile | `person_outlined` | Open rider profile |
| Rides | `history_outlined` | View ride history |
| Settings | `settings_outlined` | App settings |
| Logout | `logout` | Sign out |

#### Standalone Recenter Button

- Circular surface container with `my_location` icon
- Positioned bottom-right above the nav bar
- Always visible (except in `navigation` mode)
- Centers map on user's current GPS position via `mapController`

#### Visibility Behavior

| Mode | Behavior |
|------|----------|
| `idle` | Controls **always visible**, no auto-hide |
| `activeRide` | Controls auto-slide **down after 3 seconds** of inactivity. Tap to bring back up for 3 seconds. |
| `navigation` | Controls **hidden** — minimal distraction |

#### Transitions

- Slide down/up with `AppDurations.normal` (300ms) + `Curves.easeInOut`
- `idle → activeRide`: controls hide
- `activeRide → idle`: controls show
- `SlideTransition` with `Tween<Offset>(begin: Offset.zero, end: Offset(0, 1.15))`

#### Future Ride Controls (visible when MapMode is activeRide)

| Control | Action |
|---------|--------|
| Ride Information | View active ride details |
| Rider List | See all participants |
| Route Options | View/modify route |
| Group Status | Connection, battery, etc. |

> **Controls should remain contextual and riding-friendly.**

---

## Phase 4 — Map State System

**Status:** ✅ Complete

**Done:** 
- `MapMode` enum (`features/map/domain/entities/map_mode.dart`)
- `mapModeProvider` — `StateProvider<MapMode>` (`features/map/presentation/providers/map_mode_provider.dart`)
- `mapControllerProvider` — `Provider<MapController>` (`features/map/presentation/providers/map_controller_provider.dart`)

### Map Modes

```dart
enum MapMode {
  idle,
  searchingRide,
  activeRide,
  navigation,
  completedRide,
}
```

Each mode controls visible overlays and FloatingMapControls visibility.

### Mode Control Behavior

| Mode | FloatingMapControls | Recenter | Overlays |
|------|---------------------|----------|----------|
| **Idle** | Always visible | Yes | Join Ride, Profile, My Rides, Settings, Logout |
| **Searching Ride** | Visible (Cancel Search replaces Join Ride) | Yes | Searching panel, Cancel action |
| **Active Ride** | Auto-hide after 3s | Yes | Ride controls (Ride Info, Rider List, Route Options, Group Status) |
| **Navigation** | Hidden | Yes | Route, ETA, Directions (Future) |
| **Completed Ride** | Returns to idle controls | Yes | Summary, Replay option (Future) |

### Remaining

- [x] Camera position state management
- [ ] Map bounds tracking
- [x] Mode transition logic (idle → searchingRide → activeRide → navigation → completedRide)

---

## Phase 5 — Ride System

**Status:** 📋 Planned

### Goal

Allow riders to create and join group rides.

### Responsibilities

| Responsibility | Description |
|----------------|-------------|
| Create rides | Leader creates new ride |
| Join riders | Riders join via code/link |
| Rider roles | Leader, Co-leader, Rider |
| Ride lifecycle | Planned → Recruiting → Active → Paused → Completed |
| Permissions | Role-based access |
| Ride state | Real-time ride status |

### MVP Data Decisions & Roadmap TODOs

- **`members` List**: Plural field name in domain model and database map.
- **Embedded Members List**: Members array embedded in `rides/{rideId}` document for single-read queries in MVP. *(TODO: Migrate to `rides/{rideId}/members` subcollection in post-MVP)*.
- **Embedded Profile Snapshot**: Full `RiderProfile` inside each `RideMember`. *(TODO: Decouple to `riderId` reference post-MVP)*.
- **ISO-8601 Serialization**: Standard ISO-8601 strings for `DateTime` fields.


### Example Flow

```
Create Ride
     ↓
Invite Riders
     ↓
Start Ride
     ↓
Follow Leader
```

---

## Phase 6 — Live Ride Experience

**Status:** 📋 Planned

### Goal

Turn the map into a **shared group experience**.

### Features

| Feature | Description |
|---------|-------------|
| Live rider locations | Real-time position sharing |
| Rider markers | Custom markers per rider |
| Leader marker | Distinctive leader marker |
| Group status | Connection, battery, distance |
| Presence | Online/offline indicators |

### Architecture

```
GPS
     ↓
Location Service
     ↓
Ride State
     ↓
Map Overlays
```

---

## Phase 7 — Navigation Foundation

**Status:** 📋 Future

### Purpose

Provide **shared route awareness** for the group.

### Features

| Feature | Description |
|---------|-------------|
| Route display | Visual route on map |
| Destination | End point marker |
| Waypoints | Intermediate points |
| ETA | Estimated time of arrival |
| Distance | Remaining distance |

> **The map displays navigation results. Routing logic remains separate.**

---

## Phase 8 — Ride Coordination Features

**Status:** 📋 Future

### Features

| Feature | Description |
|---------|-------------|
| Checkpoints | Planned stops with actions |
| Regroup commands | Leader calls regroup |
| Ride communication | In-ride messaging |
| Notifications | Alerts to all riders |
| Rider status | Fuel, tire, fatigue indicators |

---

## Phase 9 — Smart Ride Features

**Status:** 📋 Future

### Features

| Feature | Description |
|---------|-------------|
| Off-route detection | Alert when rider deviates |
| Stopped rider detection | Alert when rider stops unexpectedly |
| Battery alerts | Low battery warnings |
| Ride timeline | Chronological ride events |
| Safety assistance | Emergency contact integration |

---

## Phase 10 — Ride History

**Status:** 📋 Future

### Features

| Feature | Description |
|---------|-------------|
| Completed rides | List of past rides |
| Ride replay | Visual replay on map |
| Statistics | Distance, duration, speed, elevation |
| Photos | Ride media gallery |
| Summaries | Auto-generated ride summaries |

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

### Journey Represents Shared Movement

| Shared Capability | Description |
|-------------------|-------------|
| Members | Participant management |
| Location | Position sharing |
| Status | Real-time state |
| Notifications | Alert system |
| History | Ride records |
| Communication | Messaging |

> **Do not build Journey abstraction before MVP completion.**

---

## Ride Mode

**Current product focus.**

| Aspect | Description |
|--------|-------------|
| **Purpose** | Travel together |
| **Experience** | Follow the leader |

### Capabilities

| Capability | Description |
|------------|-------------|
| Leader | Designated ride leader |
| Route Control | Leader controls the route |
| Checkpoints | Planned stops |
| Regroup Commands | Leader can call regroup |
| Group Synchronization | Keep riders together |

### Example

> "Follow me to the mountain viewpoint."

---

## Reach Mode

**Future feature.**

| Aspect | Description |
|--------|-------------|
| **Purpose** | Meet at a destination |
| **Experience** | Everyone travels independently |

### Capabilities

| Capability | Description |
|------------|-------------|
| Shared Destination | Common meeting point |
| Arrival Tracking | Monitor who has arrived |
| Participant Progress | See everyone's progress |

### Example

> "Everyone meet at this café."

---

## MVP Goals

### Current MVP: Map Experience Complete

| Feature | Status |
|---------|--------|
| Authentication | ✅ |
| Rider identity | ✅ |
| Application shell | ✅ |
| Map Foundation | ✅ |
| Floating Map Controls | ✅ |
| Map Modes & State System | ✅ |

### Remaining for MVP

| Feature | Status |
|---------|--------|
| Join Ride flow | 📋 |
| Create Ride flow | 📋 |
| Ride state | 📋 |
| Live rider tracking | 📋 |
| Group synchronization | 📋 |

---

## Version Roadmap

### v0.1 — User Foundation ✅

**Completed:**
- Authentication
- Rider identity
- Application shell

---

### v0.2 — Map Foundation ✅

**Completed:**
- Provider-agnostic map architecture
- OpenStreetMap rendering
- Location integration
- User location display

---

### v0.3 — Map Experience ✅

**Completed:**
- Map-first HomeScreen with AppMap
- Floating controls (navbar with auto-hide)
- MapMode enum and state system
- Recenter button with MapController

---

### v0.4 — Ride Foundation 🔄 Current Target

**Target:**
- Create Ride
- Join Ride
- Ride lifecycle
- Rider roles

---

### v0.5 — Live Ride Experience 📋

**Target:**
- Rider synchronization
- Live locations
- Leader tracking
- Group map experience

---

### v1.0 — Production Release 📋

**Target:**
- Stable Android/iOS release
- Motorcycle-focused group riding experience

---

## Long-Term Vision

> **RideTogether becomes the operating system for organized group rides.**

### Not Only

| Category | Description |
|----------|-------------|
| Navigation | Not just directions |
| Tracking | Not just location sharing |

### But a Complete Platform For

| Goal | Description |
|------|-------------|
| Safer riding | Safety features, alerts |
| Better coordination | Communication, sync |
| Connected rider communities | Social, history, discovery |

---

*Document Version 4.0 — Updated after Floating Map Controls & Map Modes completion.*