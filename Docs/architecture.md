# RideTogether Architecture

Version: 1.5

---

# Overview

RideTogether is a real-time group ride management application.

The application is designed as a coordination layer on top of navigation services.

External navigation services are responsible for:

* Map rendering
* Navigation
* Directions
* Places
* Geographic services

RideTogether is responsible for:

* Group ride management
* Rider synchronization
* Live rider locations
* Communication
* Checkpoints
* Safety features
* Ride coordination

The architecture goals are:

* Modular
* Scalable
* Testable
* Maintainable

The application follows:

* Feature-first architecture
* Repository pattern
* Separation of concerns
* Reactive state management
* Centralized design system

---

# Current Development Status

## Version

```
v0.0.4 — Map Foundation
```

---

# Completed

## Application Foundation

Completed:

✅ Flutter project created

✅ Android environment configured

✅ Physical device testing verified

✅ Feature-first architecture created

✅ Riverpod integrated

✅ GoRouter integrated

✅ Google Fonts integrated

✅ Material 3 theme foundation created

✅ Centralized theme system created

✅ Light and dark theme support implemented

✅ Application routing implemented

✅ Splash screen implemented

✅ Login screen implemented

✅ Home screen implemented

✅ Application identity configured

Android Application:

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

# Firebase Foundation

Completed:

✅ Firebase project created

✅ Firebase Android application configured

✅ FlutterFire CLI configured

✅ Firebase initialized during application startup

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

# Authentication Foundation

Completed:

✅ Authentication repository architecture created

✅ Google Sign-In implemented

✅ Firebase Authentication implemented

✅ AppUser domain model created

✅ Firebase user mapping implemented

✅ Authentication providers created

✅ Login flow implemented

✅ Logout flow implemented

✅ Authentication state handling implemented

Authentication follows:

```
Presentation

↓

Domain

↓

Data

↓

Firebase
```

---

# Rider Identity Foundation

Completed:

✅ RiderProfile domain entity created

✅ Rider profile repository contract created

✅ Firebase profile repository implemented

✅ Firestore profile datasource implemented

✅ Profile providers created

✅ Automatic profile creation after authentication implemented

✅ Existing profile lookup implemented

Rider profile flow:

```
Firebase Authentication

↓

AppUser

↓

Current Profile Provider

↓

Profile Repository

↓

Firestore

↓

RiderProfile
```

Current Firestore structure:

```
users

  └── {uid}

        ├── rider information
        ├── display information
        ├── createdAt
        └── updatedAt
```

Future RiderProfile capabilities:

* Profile screen
* Profile editing
* Motorcycle information
* Avatar management
* Privacy settings

---

# Startup Architecture

Startup is responsible for preparing the application before entering the main experience.

Current startup flow:

```
Application Launch

↓

Firebase Initialization

↓

ProviderScope

↓

RideTogetherApp

↓

GoRouter

↓

SplashScreen

↓

Startup Provider

↓

Authentication Check

↓

Rider Profile Check

↓

HomeScreen
```

Startup responsibilities:

* Maintain splash experience
* Wait for authentication readiness
* Ensure authenticated users have RiderProfile data

---

# Current Application Flow

```
Android Device

↓

main.dart

↓

Firebase.initializeApp()

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

Startup Provider

↓

Auth State Provider

↓

Current Profile Provider

↓

HomeScreen
```

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

Architecture flow:

```
UI

↓

Riverpod Providers

↓

Repositories

↓

Data Sources

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
- Business rules


presentation/

- Screens
- Widgets
- Providers
```

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

Use:

```
Theme.of(context)
```

---

# Current Development Priorities

Development order:

1. Complete rider identity foundation ✅
2. Implement map foundation 🔄 In Progress (Phases 1-10 Complete, Phase 11 Next)
3. Create Ride feature
4. Add live location tracking
5. Add group synchronization

---

# Map Foundation Implementation Plan (Phase 2)

**Status:** Phases 1-10 Complete, Phase 11 Next

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

### Phase 6: LocationRepository & Location Feature
- [x] Implement `GeolocatorLocationRepository` wrapping `geolocator` package
- [x] Permission handling: `requestPermission`, `checkPermission`, `isPermissionGranted`
- [x] Position operations: `getCurrentPosition`, `getPositionStream`
- [x] Geocoding: `getAddressFromCoordinates`, `getCoordinatesFromAddress`
- [x] Background location support (future)

### Phase 7: Location Repository Interface
- [x] Create `LocationRepository` abstraction
- [x] Define contract for GPS, permissions, geocoding

### Phase 8: Geolocator Implementation
- [x] Create `GeolocatorLocationRepository`
- [x] Wrap geolocator package
- [x] Handle GPS access
- [x] Convert platform models into domain entities

### Phase 9: Location Riverpod Providers
- [x] Create `locationPermissionProvider`
- [x] Create `currentPositionProvider`
- [x] Create `initialPositionProvider`

### Phase 10: User Location Layer
- [x] Current location marker
- [x] Marker updates from GPS stream
- [x] Live position updates
- [ ] Accuracy circle
- [ ] Heading indicator
- [ ] Direction arrow
- [ ] Follow-user camera mode

### Phase 11: Camera Controls and Map Interaction (Next)
- [ ] Add MapEngine camera control abstraction
- [ ] Add moveCamera()
- [ ] Add zoomIn()
- [ ] Add zoomOut()
- [ ] Add centerOnUser()
- [ ] Add floating map controls
- [ ] Add recenter button

### Phase 12: Floating Map Controls
- [ ] Idle Mode controls (Join Ride, Profile, My Rides, Settings)
- [ ] Active Ride Mode controls (Recenter, Show Riders, Route Options, Ride Info)
- [ ] Navigation Mode controls (Recenter, Next Turn Preview, ETA, Route Options)

### Phase 13: Follow User Mode
- [ ] Optional camera following
- [ ] Default: Marker moves, camera stays
- [ ] User presses Center Location → Camera follows user

### Phase 14: Map Styling & Tile Layers
- [ ] Tile layer configuration (satellite, terrain, custom)
- [ ] Offline tile caching
- [ ] Map clustering
- [ ] Custom map styling
- [ ] Provider swap utilities

### Phase 15: Offline Map Support
- [ ] Tile caching
- [ ] Offline-first rendering
- [ ] Background download

### Phase 16: Advanced Map Interactions
- [ ] Gesture handling
- [ ] Distance/area measurement
- [ ] Map clustering

### Phase 17: Map Performance & Optimization
- [ ] Viewport culling
- [ ] Level-of-detail
- [ ] Frame budget

### Phase 18: Map Testing Infrastructure
- [ ] Mock provider
- [ ] Golden tests
- [ ] Integration tests

### Phase 19: Ride Visualization on Map
- [ ] Rider markers
- [ ] Route overlay
- [ ] Leader/follower UI

### Phase 20: Future Map Layers
- [ ] TrafficLayer
- [ ] RoutingLayer (future)


# Deliverable

RideTogether has a working map experience with a provider-agnostic architecture that can support multiple map providers (OpenStreetMap, Google Maps, Mapbox, HERE, etc.) in the future. Location services are completely separate from map rendering.

## Dependencies Already Added to pubspec.yaml

```yaml
dependencies:
  flutter_map: ^8.2.2
  latlong2: ^0.9.1
  geolocator: ^14.0.2
  permission_handler: ^12.0.1
  geocoding: ^4.0.0
  flutter_google_places_sdk: ^0.4.2  # Future places integration
  flutter_polyline_points: ^3.0.1    # Route decoding
```

## Platform Configuration Required

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

# Future Journey Architecture

# Deliverable

RideTogether has a working map experience with a provider-agnostic architecture that can support multiple map providers (OpenStreetMap, Google Maps, Mapbox, HERE, etc.) in the future. Location services are completely separate from map rendering.

## Dependencies Already Added to pubspec.yaml

```yaml
dependencies:
  flutter_map: ^8.2.2
  latlong2: ^0.9.1
  geolocator: ^14.0.2
  permission_handler: ^12.0.1
  geocoding: ^4.0.0
  flutter_google_places_sdk: ^0.4.2  # Future places integration
  flutter_polyline_points: ^3.0.1    # Route decoding
```

## Platform Configuration Required

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

# Future Journey Architecture

# Future Journey Architecture

RideTogether currently focuses only on Ride mode.

Reach is a future feature.

Do not implement Reach during MVP.

Future architecture:

```
Journey

├── Ride

└── Reach
```

A Journey represents a shared group movement activity.

Future shared Journey functionality:

* Members
* Destination
* Location tracking
* Map visualization
* Status
* Notifications
* Chat
* Events
* History

Future implementation may use:

```
features/journey/
```

Do not restructure the current project for Reach before MVP completion.

---

# Ride Mode

Ride is the current MVP feature.

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

---

# Reach Mode

Reach is a future journey mode.

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

---

# Future Technical Direction

Future systems:

## Mapping

Planned:

* Map provider abstraction layer (implemented in Phase 2)
* OpenStreetMap implementation via flutter_map (current)
* Location services via geolocator
* Map visualization
* Google Maps as future provider option
* Mapbox as future provider option
* HERE Maps as future provider option

### MapProvider Abstraction

The application uses a provider-agnostic mapping architecture. The `MapProvider` interface defines the contract for map rendering, camera control, markers, polylines, and map interactions. The current implementation uses `FlutterMapProvider` which wraps the `flutter_map` package with OpenStreetMap tiles.

**Maps and Location are separate concerns.** The map is responsible for visualization only. Location services (GPS, permissions, geocoding) are handled by a separate `LocationRepository` abstraction.

```
Application UI
    ↓
Map Feature
    ↓
MapProvider (abstract interface)
    ↓
FlutterMapProvider (current: flutter_map + OpenStreetMap)
```

Independently:

```
Application
    ↓
Location Feature
    ↓
LocationRepository (abstract interface)
    ↓
GeolocatorLocationRepository (current: geolocator)
```

The map should never be described as being responsible for acquiring GPS data.

### Current Implementation Stack

The current map implementation uses:
- **flutter_map** - Map widget for rendering tiles and overlays
- **latlong2** - Geographic coordinate handling (LatLng)

The current location implementation uses:
- **geolocator** - Device GPS location access
- **geocoding** - Address/coordinate conversion

These are implementation details behind their respective abstractions. Application code should interact with the `MapProvider` and `LocationRepository` interfaces rather than directly depending on `flutter_map`, `geolocator`, or provider-specific APIs.

### MapProvider Responsibilities

The `MapProvider` abstraction will expose operations including:

- `moveCamera()`
- `zoomIn()`
- `zoomOut()`
- `fitBounds()`
- `addMarker()`
- `removeMarker()`
- `drawPolyline()`
- `clearPolylines()`
- Tile layer configuration
- Map interaction callbacks (tap, long press, camera move)

**Future Implementations:**
- `FlutterMapProvider` (current: flutter_map + OpenStreetMap)
- `GoogleMapsProvider` (future: google_maps_flutter)
- `MapboxProvider` (future: mapbox_maps_flutter)
- `HEREMapsProvider` (future: here_sdk)

The application depends only on the `MapProvider` interface, making the underlying provider interchangeable.

### LocationRepository Responsibilities

The `LocationRepository` abstraction defines the contract for location services:

- `requestPermission()`
- `checkPermission()`
- `getCurrentPosition()`
- `getLocationStream()`
- `getAddressFromCoordinates()`
- `getCoordinatesFromAddress()`

**Current Implementation:**
- `GeolocatorLocationRepository` (wraps geolocator package)

**Future Implementations:**
- Alternative GPS providers
- Fused location providers
- Mock implementations for testing

### Provider Abstraction Benefits

1. **Vendor Independence** - No lock-in to Google Maps billing, terms, or API changes
2. **Cost Control** - OpenStreetMap is free and open-source
3. **Offline Capability** - Easier to implement offline map tiles with OSM
4. **Customization** - Full control over map styling and layers

---

# Graphify AI Context Maintenance

RideTogether uses Graphify to maintain an AI-readable understanding of the application's architecture.

Graphify creates a graph representation of the codebase, helping AI tools understand:

- Feature relationships
- Code dependencies
- Architecture boundaries
- Major components
- Changes introduced over time

Graphify is a generated view of the current implementation.

It does not replace project documentation.

The sources of truth are:

1. Current codebase
2. Documentation in `/docs`
3. Graphify generated reports

---

# Graphify Setup

Graphify requires:

- Graphify CLI
- Gemini API key for semantic extraction

The Gemini API key must remain private.

Store it locally in:

```text
.env
```

Example:

```text
GEMINI_API_KEY=your_key_here
```

Ensure `.env` is included in:

```text
.gitignore
```

Never commit API keys.

---

# Running Graphify

Run Graphify from the project root:

```bash
graphify .
```

This generates:

```text
graphify-out/

├── graph.json
├── .graphify_analysis.json
```

Generate the readable architecture report:

```bash
graphify cluster-only .
```

This creates:

```text
graphify-out/GRAPH_REPORT.md
```

---

# When to Update Graphify

Graphify does not need to run after every small code change.

Run Graphify after major changes such as:

- Adding a new feature
- Creating a new feature folder
- Adding Firebase services
- Adding Google Maps functionality
- Changing authentication flow
- Changing state management
- Refactoring architecture
- Adding new external integrations