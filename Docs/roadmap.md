# RideTogether Roadmap

**Version:** 3.0  
**Last Updated:** 2026-07-17

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

**v0.0.4 — Map Foundation Complete**

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
Map Experience 🔄 Next
         ↓
Ride System
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

> Users can launch the application, authenticate, and enter the application with a stored rider profile.

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

**Status:** 🔄 Next

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
MapScreen
```

---

### MapScreen

**Create:** `features/map/presentation/screens/map_screen.dart`

#### Responsibilities

- Own the map experience
- Compose map overlays
- Manage map UI state
- Provide foundation for ride features

#### Structure

```
MapScreen
Stack
├── AppMap
├── FloatingMapControls
├── Ride Panels
├── Bottom Sheets
└── Dialogs
```

---

### Floating Map Controls

#### Idle Controls

| Control | Action |
|---------|--------|
| Join Ride | Navigate to join flow |
| Profile | Open rider profile |
| My Rides | View ride history |
| Settings | App settings |
| Recenter | Center map on user |

#### Future Ride Controls

| Control | Action |
|---------|--------|
| Ride Information | View active ride details |
| Rider List | See all participants |
| Route Options | View/modify route |
| Group Status | Connection, battery, etc. |

> **Controls should remain contextual and riding-friendly.**

---

## Phase 4 — Map State System

**Status:** 📋 Planned

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

Each mode controls visible overlays.

### Mode Examples

| Mode | Visible Overlays |
|------|------------------|
| **Idle** | Map, Join Ride, Profile, Searching Ride |
| **Searching Ride** | Searching panel, Cancel action |
| **Active Ride** | Rider markers, Ride info, Recenter |
| **Navigation** | Route, ETA, Directions (Future) |
| **Completed Ride** | Summary, Replay option (Future) |

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

### Current MVP: Completed

| Feature | Status |
|---------|--------|
| Authentication | ✅ |
| Rider identity | ✅ |
| Application shell | ✅ |
| Map Foundation | ✅ |

### Remaining for MVP

| Feature | Status |
|---------|--------|
| Map-first application experience | 🔄 |
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

### v0.3 — Map Experience 🔄 Current Target

**Target:**
- MapScreen
- Floating controls
- Camera controls
- Map modes

---

### v0.4 — Ride Foundation 📋

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

*Document Version 3.0 — Updated after Map Foundation completion.*