# RideTogether AI Development Instructions

Version: 1.5

---

# Project Overview

RideTogether is a mobile-first group ride management application designed for:

* Motorcycle riders
* Cyclists
* Road trips
* Convoys
* Adventure groups

RideTogether is not a replacement for navigation applications.

The purpose of RideTogether is to add a group management and coordination layer on top of existing navigation services.

The application provides:

* Group ride management
* Rider synchronization
* Live rider locations
* Communication
* Safety features
* Ride coordination

RideTogether should feel like a co-pilot for group rides.

---

# Core Philosophy

Every feature must answer:

"Does this make riding in a group easier or safer?"

If the answer is no, do not build it.

The application should remain:

* Simple
* Fast
* Reliable
* Safe
* Distraction-free

The map is the primary experience.

Features should minimize interaction while riding.

Important principles:

* Avoid unnecessary rider interaction during rides
* Optimize battery usage
* Optimize network usage
* Keep controls usable while riding
* Safety takes priority over feature quantity

---

# Current Development Status

## Version

```
v0.0.4 — Map Foundation
```

---

# Completed Features

## Application Foundation

Completed:

* Flutter project created
* Android environment configured
* Physical device testing completed
* Feature-first architecture created
* Riverpod integrated
* GoRouter integrated
* Google Fonts integrated
* Application shell created
* Material 3 theme foundation created
* Light and dark theme support implemented
* Splash screen implemented
* Login screen implemented
* Home screen implemented
* Application routing implemented

---

## Firebase Foundation

Completed:

* Firebase project created
* Firebase Android application configured
* FlutterFire CLI configured
* Firebase initialization completed

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

## Authentication

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

## Rider Identity System

Completed:

* RiderProfile entity created
* Profile repository abstraction created
* Firebase profile repository implemented
* Firestore profile datasource created
* Profile providers created
* Automatic profile creation implemented
* Existing profile loading implemented

Rider identity purpose:

Authentication answers:

"Who is this user?"

Rider profile answers:

"Who is this rider inside RideTogether?"

Profile flow:

```
User Authentication

↓

Auth State Provider

↓

Current Profile Provider

↓

Check Firestore Profile

↓

Profile Exists

OR

Create Rider Profile

↓

Application Uses Rider Identity
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

Future rider profile additions:

* Motorcycle information
* Rider avatar
* Riding preferences
* Privacy settings
* Emergency information

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

Architecture principles:

Widgets display information.

Providers manage state.

Repositories manage application data.

Services communicate with external systems.

Architecture flow:

```
UI

↓

Riverpod Providers

↓

Repositories

↓

Services

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


shared/

- Reusable components
- Shared models
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
- Use cases


presentation/

- Screens
- Widgets
- Providers
```

---

# Android Application Identity

Current Android identity:

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

Do not change these values without updating:

* Firebase Android configuration
* google-services.json
* MainActivity package
* Gradle namespace
* Gradle applicationId

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
* Avoid storing application state inside widgets

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

Never:

```
Widget

↓

Firebase
```

Preferred:

```
Widget

↓

Provider

↓

Repository

↓

Service

↓

External System
```

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

Use Flutter theme values:

```
Theme.of(context)
```

---

# Current Development Priorities

Development order:

1. Complete map foundation
2. Integrate location permissions
3. Create map experience
4. Create Ride feature
5. Add live location tracking
6. Add group synchronization

Do not jump into advanced features before MVP foundations are complete.

---

# Future Journey Architecture

RideTogether currently focuses only on Ride mode.

Reach is a future feature.

Do not implement Reach during MVP.

Future architecture:

```
Journey

- Ride

- Reach
```

A Journey represents a shared group movement activity.

---

# Shared Journey Capabilities

Future shared Journey functionality may include:

* Members
* Destination
* Location tracking
* Map visualization
* Status
* Notifications
* Chat
* Events
* History

Shared functionality should be implemented once inside Journey.

Do not duplicate shared systems between Ride and Reach.

---

# Ride Mode

Ride is the current MVP feature.

Purpose:

Travel together.

Experience:

Follow the leader.

Control:

Leader controlled.

Ride capabilities:

* Leader
* Route control
* Checkpoints
* Regroup commands
* Group synchronization

Example:

"Follow me to the mountain viewpoint."

---

# Reach Mode

Reach is a future destination-based group activity.

Purpose:

Meet at a destination.

Experience:

Everyone travels independently.

Control:

No leader.

Reach capabilities:

* Shared destination
* Individual navigation
* Arrival tracking
* Participant progress

Example:

"Everyone meet at this café."

---

# Future Journey Domain

Future Journey model:

* id
* creatorId
* destination
* members
* status
* type

Journey types:

* Ride
* Reach

Mode-specific behavior should extend Journey.

Do not duplicate:

* Membership
* Location tracking
* Status handling
* Notifications
* Chat
* History

---

# Future Feature Direction

Do not restructure the current project for Reach.

After MVP completion, future Journey functionality may be organized as:

```
features/

journey/

data/

domain/

presentation/
```

Reach should only be implemented after current MVP priorities are complete.

---

# 12. Mapping Architecture & Setup

RideTogether uses a provider-agnostic mapping architecture. The current implementation uses **OpenStreetMap** via the `flutter_map` package, but the application is designed so that the underlying map provider can be replaced (Google Maps, Mapbox, HERE, etc.) without affecting business logic.

**Maps and Location are separate features.** The map feature handles rendering, camera, markers, and polylines. The location feature handles GPS, permissions, and geocoding.

### Current Map Stack

The following packages are used for the OpenStreetMap implementation:

| Package | Purpose |
|---------|---------|
| `flutter_map` | Map widget for rendering tiles and overlays |
| `latlong2` | Geographic coordinate handling (LatLng) |

### Current Location Stack

The following packages are used for location services:

| Package | Purpose |
|---------|---------|
| `geolocator` | Device GPS location access |
| `geocoding` | Address ↔ coordinate conversion |
| `permission_handler` | Runtime permission management |
| `flutter_google_places_sdk` | Places API integration (future) |
| `flutter_polyline_points` | Route polyline decoding |

These are implementation details behind the `MapProvider` and `LocationRepository` abstractions. Application code should depend on the provider interfaces, not directly on `flutter_map`, `geolocator`, or provider-specific APIs.

### Feature Structure

Instead of a combined map repository, the architecture defines two independent feature areas:

```
features/
  map/
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
  location/
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

The **map feature** is responsible for:
- Rendering maps
- Camera movement
- Markers
- Polylines
- Tile providers
- Map interactions

The **location feature** is responsible for:
- GPS
- Location permissions
- Current position
- Continuous location updates
- Reverse geocoding

### Map Dependencies (Already Added)

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

Run `flutter pub get` if not already done.

### Platform Configuration

#### Android
Add location permissions to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_LOCATION" />
```

#### iOS
Add location usage descriptions to `ios/Runner/Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>RideTogether needs location access to show your position on the map during rides.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>RideTogether needs location access for live rider tracking during group rides.</string>
```

#### Web
No additional configuration required for `flutter_map` on web.

### MapProvider Abstraction

The `MapProvider` abstraction defines the contract for map operations. **Use `MapProvider` (not `MapEngine`) for consistency across documentation.**

#### Core Domain Models

```dart
// Domain entities (in features/map/domain/entities/)
class MapMarker { /* id, position, icon, label, onTap, data */ }
class MapPolyline { /* id, points, color, width, pattern */ }
class CameraPosition { /* target, zoom, bearing, tilt */ }
class MapBounds { /* southwest, northeast */ }
class LatLng { /* latitude, longitude */ }
class MapCapabilities { /* supportsSatellite, supportsTraffic, supportsOffline, etc. */ }
enum MapProviderType { openStreetMap, googleMaps, mapbox, here }
```

#### Core Operations

**Camera Control:**
- `moveCamera(CameraPosition position)`
- `animateCamera(CameraPosition position, {Duration duration})`
- `zoomIn()`
- `zoomOut()`
- `zoomTo(double zoom)`
- `fitBounds(MapBounds bounds, {EdgeInsets padding})`
- `getCameraPosition()` → `Future<CameraPosition>`
- `cameraPositionStream` → `Stream<CameraPosition>`

**Markers:**
- `addMarker(MapMarker marker)`
- `removeMarker(String markerId)`
- `updateMarker(MapMarker marker)`
- `clearMarkers()`
- `getMarkers()` → `List<MapMarker>`
- `onMarkerTap` → `Stream<String>` (markerId)
- `onMarkerLongPress` → `Stream<String>`

**Polylines:**
- `addPolyline(MapPolyline polyline)`
- `removePolyline(String polylineId)`
- `clearPolylines()`
- `getPolylines()` → `List<MapPolyline>`

**Map Layers & Styling:**
- `setTileLayer(TileLayerOptions options)`
- `setMapStyle(String styleJson)` (future)
- `enableLayer(String layerId)`
- `disableLayer(String layerId)`

**Lifecycle:**
- `initialize()`
- `dispose()`
- `getCapabilities()` → `MapCapabilities`

**Implementations:**
- `FlutterMapProvider` (current: flutter_map + OpenStreetMap)
- `GoogleMapsProvider` (future: google_maps_flutter)
- `MapboxProvider` (future: mapbox_maps_flutter)
- `HEREMapsProvider` (future: here_sdk)

The application depends only on the `MapProvider` interface, making the underlying provider interchangeable.

### LocationRepository Abstraction

The `LocationRepository` abstraction defines the contract for location services:

**Core Operations:**
- `requestPermission()` → `Future<PermissionStatus>`
- `checkPermission()` → `Future<PermissionStatus>`
- `isPermissionGranted()` → `Future<bool>`
- `getCurrentPosition({LocationAccuracy accuracy})` → `Future<Position>`
- `getPositionStream({LocationAccuracy accuracy, DistanceFilter distanceFilter})` → `Stream<Position>`
- `getLastKnownPosition()` → `Future<Position?>`
- `getAddressFromCoordinates(double lat, double lng)` → `Future<List<Placemark>>`
- `getCoordinatesFromAddress(String address)` → `Future<List<Location>>`
- `openAppSettings()` → `Future<bool>`
- `openLocationSettings()` → `Future<bool>`

**Implementations:**
- `GeolocatorLocationRepository` (current: wraps geolocator package)
- Alternative GPS providers (future)
- Mock implementations for testing (future)

### Provider Abstraction Benefits

1. **Vendor Independence** - No lock-in to Google Maps billing, terms, or API changes
2. **Cost Control** - OpenStreetMap is free and open-source
3. **Offline Capability** - Easier to implement offline map tiles with OSM
4. **Customization** - Full control over map styling and layers
5. **Future Flexibility** - Can swap to Google Maps/Mapbox when needed for specific features (Street View, advanced routing, etc.)

### Google Maps (Future Provider)

Google Maps remains a possible future provider. The architecture intentionally avoids vendor lock-in. If Google Maps is needed later (e.g., for Street View, advanced routing, or Places API):

1. Create a `GoogleMapsProvider` implementing the `MapProvider` interface
2. Add `google_maps_flutter` dependency
3. Configure API keys in `AndroidManifest.xml` and `Info.plist`
4. Update the provider registration
5. No changes required to ride coordination, live tracking, or UI layers

Do not add Google Maps API keys or configuration until the provider is actually implemented.

### Mapbox (Future Provider)

Similar to Google Maps, Mapbox can be implemented as a `MapProvider` when needed for specific features.

### HERE Maps (Future Provider)

HERE Maps can be implemented as a `MapProvider` when needed for specific features.

### Implementation Phases (from TODO_MAP_FOUNDATION.md)

The Map Foundation is implemented in 16 phases:

| Phase | Description | Key Deliverables |
|-------|-------------|------------------|
| 1 | Foundation & MapProvider Abstraction | Feature structure, interfaces, domain models |
| 2 | Camera & Viewport Control | FlutterMapProvider, camera operations, stream |
| 3 | Markers & Overlays | Marker CRUD, clustering-ready, callbacks |
| 4 | Polylines & Routes | Polyline operations, route rendering |
| 5 | AppMap Widget & Providers | AppMap widget, Riverpod providers, error handling |
| 6 | LocationRepository & Location Feature | GeolocatorLocationRepository, permissions, geocoding |
| 7 | MapScreen & UI Integration | MapScreen, toolbar, providers, error states |
| 8 | Map Persistence & Preferences | Map preferences, cached tile layer, persistence |
| 9 | Map Event System | MapEvent, EventBus, lifecycle events |
| 10 | Map Styling & Tile Layers | Tile layer config, satellite/terrain, custom styles |
| 11 | Offline Map Support | Tile caching, offline-first, background download |
| 12 | Advanced Map Interactions | Gestures, distance/area measurement, clustering |
| 13 | Map Performance & Optimization | Viewport culling, level-of-detail, frame budget |
| 14 | Map Testing Infrastructure | Mock provider, golden tests, integration tests |
| 15 | Ride Visualization on Map | Rider markers, route overlay, leader/follower UI |
| 16 | Future Map Layers | TrafficLayer, RoutingLayer (future) |

### Future Providers Placeholder

The following Riverpod providers are reserved for future implementation and should not be implemented yet:

- `nearbyRidersProvider`
- `selectedDestinationProvider`
- `activeRouteProvider`

These will be added when the ride coordination features require them.