# RideTogether Roadmap

Version: 1.5

---

# Development Progress

## Current Version

```
v0.0.4 — Map Foundation
```

---

# Current Status

The application foundation is complete.

Authentication and rider identity foundations have been implemented.

Map Foundation (Phase 2) is the current development priority with dependencies already added to pubspec.yaml.

Current development priority:

```
Authentication ✅
↓
Rider Identity ✅
↓
Map Foundation 🔄 In Progress (Phases 1-5 Complete, Phase 6 Next)
↓
Ride System
↓
Live Tracking
```

---

# Map Foundation Implementation Plan (Phase 2)

**Status:** Phases 1-5 Complete, Phase 6 Next

**Goal:** Create the core map experience using a provider-agnostic architecture with OpenStreetMap via flutter_map. Separate map rendering from location services into independent features.

## Implementation Phases

### Phase 1: Foundation & MapProvider Abstraction
- [x] Create `lib/features/map/` and `lib/features/location/` feature structure
- [x] Define `MapProvider` interface (provider-agnostic map operations)
- [x] Define `LocationRepository` interface (GPS, permissions, geocoding)
- [x] Create domain models: `MapMarker`, `MapPolyline`, `LatLng`, `CameraPosition`, `MapBounds`
- [x] Create `MapCapabilities` model for provider feature flags
- [x] Create `MapProviderType` enum (openStreetMap, googleMaps, mapbox, here)

### Phase 2: Camera & Viewport Control
- [x] Implement `FlutterMapProvider` with `flutter_map` controller
- [x] Camera operations: `moveCamera`, `animateCamera`, `zoomIn`, `zoomOut`, `fitBounds`, `getCameraPosition`
- [x] Camera state stream for reactive UI updates
- [x] Map initialization and disposal

### Phase 3: Markers & Overlays
- [x] Marker operations: `addMarker`, `removeMarker`, `updateMarker`, `clearMarkers`
- [x] Marker clustering support (future-ready)
- [x] Custom marker widget support
- [x] Marker tap/long-press callbacks

### Phase 4: Polylines & Routes
- [x] Polyline operations: `addPolyline`, `removePolyline`, `clearPolylines`
- [x] Route rendering with customizable styling
- [x] Multiple polyline support (route, trail, alternative routes)

### Phase 5: AppMap Widget & Providers
- [x] Create `AppMap` widget with `FlutterMap` integration
- [x] Riverpod providers for map state (camera, markers, polylines)
- [x] Error handling and loading states
- [x] Map event system (MapEvent, EventBus)

### Phase 6: LocationRepository & Location Feature (Next)
- [ ] Implement `GeolocatorLocationRepository` wrapping `geolocator` package
- [ ] Permission handling: `requestPermission`, `checkPermission`, `isPermissionGranted`
- [ ] Position operations: `getCurrentPosition`, `getPositionStream`
- [ ] Geocoding: `getAddressFromCoordinates`, `getCoordinatesFromAddress`
- [ ] Background location support (future)

### Phase 7: MapScreen & UI Integration
- [ ] Create `MapScreen` with `AppMap` widget
- [ ] Map toolbar (zoom, recenter, layer toggle)
- [ ] Current location button with accuracy indicator
- [ ] Map state providers (camera, markers, polylines)
- [ ] Error/empty states

### Phase 8: Map Persistence & Preferences
- [ ] Map preferences (last position, zoom, layer)
- [ ] Cached tile layer configuration
- [ ] Persistence across sessions

### Phase 9: Map Event System
- [ ] MapEvent definitions
- [ ] EventBus for map lifecycle events
- [ ] Camera change events
- [ ] Interaction events

### Phase 10: Map Styling & Tile Layers
- [ ] Tile layer configuration (satellite, terrain, custom)
- [ ] Offline tile caching
- [ ] Map clustering
- [ ] Custom map styling
- [ ] Provider swap utilities

### Phase 11: Offline Map Support
- [ ] Tile caching
- [ ] Offline-first rendering
- [ ] Background download

### Phase 12: Advanced Map Interactions
- [ ] Gesture handling
- [ ] Distance/area measurement
- [ ] Map clustering

### Phase 13: Map Performance & Optimization
- [ ] Viewport culling
- [ ] Level-of-detail
- [ ] Frame budget

### Phase 14: Map Testing Infrastructure
- [ ] Mock provider
- [ ] Golden tests
- [ ] Integration tests

### Phase 15: Ride Visualization on Map
- [ ] Rider markers
- [ ] Route overlay
- [ ] Leader/follower UI

### Phase 16: Future Map Layers
- [ ] TrafficLayer
- [ ] RoutingLayer (future)

---

# Deliverable

RideTogether has a working map experience with a provider-agnostic architecture that can support multiple map providers (OpenStreetMap, Google Maps, Mapbox, HERE, etc.) in the future. Location services are completely separate from map rendering.

All map dependencies are already in pubspec.yaml:
- `flutter_map: ^8.2.2`
- `latlong2: ^0.9.1`
- `geolocator: ^14.0.2`
- `permission_handler: ^12.0.1`
- `geocoding: ^4.0.0`
- `flutter_google_places_sdk: ^0.4.2` (future places integration)
- `flutter_polyline_points: ^3.0.1` (route decoding)

---

# Platform Configuration Required

### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_LOCATION" />
```

### iOS (`ios/Runner/Info.plist`)
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>RideTogether needs location access to show your position on the map during rides.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>RideTogether needs location access for live rider tracking during group rides.</string>
```

### Web
No additional configuration required for `flutter_map` on web.

---

# Dependencies Added

The following packages are already in `pubspec.yaml`:
```yaml
dependencies:
  flutter_map: ^8.2.2
  latlong2: ^0.9.1
  geolocator: ^14.0.2
  permission_handler: ^12.0.1
  geocoding: ^4.0.0
  flutter_google_places_sdk: ^0.4.2
  flutter_polyline_points: ^3.0.1
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

---


# Phase 2 — Map Foundation

Status:

In Progress - Phases 1-5 Complete, Phase 6 Next

Goal:

Create the core map experience using a provider-agnostic architecture with OpenStreetMap via flutter_map. Separate map rendering from location services into independent features.

Features:

* flutter_map (OpenStreetMap) integration with MapProvider abstraction
* LocationRepository abstraction for GPS, permissions, geocoding
* features/map/ and features/location/ feature structure
* Map screen with camera control, markers, polylines
* Current location display with accuracy indicator
* Location permissions handling
* Map UI components
* Map state management via Riverpod

Deliverable:

RideTogether has a working map experience with a provider-agnostic architecture that can support multiple map providers (OpenStreetMap, Google Maps, Mapbox, etc.) in the future. Location services are completely separate from map rendering.

---

---


# Phase 2 Implementation Phases

| Phase | Description | Status |
|-------|-------------|--------|
| 1 | Foundation & MapProvider Abstraction | ✅ Complete |
| 2 | Camera & Viewport Control | ✅ Complete |
| 3 | Markers & Overlays | ✅ Complete |
| 4 | Polylines & Routes | ✅ Complete |
| 5 | AppMap Widget & Providers | ✅ Complete |
| 6 | LocationRepository & Location Feature | ⏳ Next |
| 7 | Map Screen & UI Integration | ⏳ Pending |
| 8 | Map Persistence & Preferences | ⏳ Pending |
| 9 | Map Event System | ⏳ Pending |
| 10 | Map Styling & Tile Layers | ⏳ Pending |
| 11 | Offline Map Support | 🔮 Future |
| 12 | Advanced Map Interactions | 🔮 Future |
| 13 | Map Performance & Optimization | 🔮 Future |
| 14 | Map Testing Infrastructure | 🔮 Future |
| 15 | Ride Visualization on Map | 🔮 Future |
| 16 | Future Map Layers | 🔮 Future |

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

---


# Phase 2 — Map Foundation

Status:

In Progress - Phases 1-5 Complete, Phase 6 Next

Goal:

Create the core map experience using a provider-agnostic architecture with OpenStreetMap via flutter_map. Separate map rendering from location services into independent features.

Features:

* flutter_map (OpenStreetMap) integration with MapProvider abstraction
* LocationRepository abstraction for GPS, permissions, geocoding
* features/map/ and features/location/ feature structure
* Map screen with camera control, markers, polylines
* Current location display with accuracy indicator
* Location permissions handling
* Map UI components
* Map state management via Riverpod

Deliverable:

RideTogether has a working map experience with a provider-agnostic architecture that can support multiple map providers (OpenStreetMap, Google Maps, Mapbox, etc.) in the future. Location services are completely separate from map rendering.

---

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

---


# Future Journey Modes

Status:

Future

RideTogether currently focuses only on Ride mode.

Reach is not part of MVP.

---

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

---


# MVP Checklist

Current MVP goals:

* Authentication ✅
* Rider profiles ✅
* Home application shell ✅
* Map foundation
* Create Ride
* Join Ride
* Live tracking
* Destination sharing
* Navigation
* Checkpoints
* Ride communication
* Notifications

---

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

* MapProvider abstraction ✅
* LocationRepository abstraction ⏳
* OpenStreetMap via flutter_map ✅
* Location permissions ⏳
* Map screen ⏳
* Location feature (separate from map) ⏳

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

---


# Long-Term Vision

Become the operating system for organized group rides.

Not only navigation.

Not only tracking.

A complete platform for safer and better group riding.