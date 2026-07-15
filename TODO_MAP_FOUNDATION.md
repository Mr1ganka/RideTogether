# RideTogether Map Foundation Implementation Plan

## Version: 2.1

---

# Overview

This document outlines the implementation plan for the Map Foundation phase of RideTogether.

The map is the primary user interface of RideTogether. Instead of treating the map as a standalone feature screen, the application uses a map-first architecture where the map acts as the main workspace and other features appear as overlays, controls, and panels.

The map foundation uses a provider-agnostic architecture.

Current implementation:

```
flutter_map + OpenStreetMap
```

Future implementations:

```
Google Maps
Mapbox
HERE Maps
```

The application should never depend directly on a specific map provider.

---

# Core Architecture Principles

## 1. Map and Location are Separate Features

The map feature handles:

* Rendering
* Camera movement
* Markers
* Polylines
* Map interactions
* Map overlays

The location feature handles:

* GPS
* Permissions
* Position streams
* Geocoding

The map never accesses GPS directly.

```
Location Feature

GPS
  |
  v
LocationRepository
  |
  v
Position Entity


Map Feature

Position Entity
  |
  v
Map Marker
  |
  v
Map Rendering
```

---

## 2. Provider Agnostic Map Architecture

```
MapProvider Interface

        |
        |

FlutterMapProvider
(current implementation)

        |
        |

flutter_map + OpenStreetMap


Future:

GoogleMapsProvider

MapboxProvider

HEREMapsProvider
```

Changing map providers should only require replacing the implementation.

Presentation code should not change.

---

# Feature Structure

```
features/

map/

map/

    data/
        engines/
            flutter_map_provider.dart

        mappers/

        constants/


    domain/
        entities/
            geo_point.dart
            camera_position.dart
            map_marker.dart
            map_polyline.dart
            map_bounds.dart
            map_provider_type.dart

        engine/
            map_provider.dart
            map_camera_controller.dart
            map_capabilities.dart


    presentation/

        screens/
            map_screen.dart

        widgets/
            app_map.dart
            map_controls.dart
            navigation_panel.dart

        providers/
            map_provider_provider.dart
            map_mode_provider.dart



location/

    data/

    domain/

    presentation/
```

---

# Map Application Model

The map is always present.

The application has different map states.

## Map Modes

Initial:

```
Idle
Active Ride
```

Future:

```
Searching Ride

Navigation

Ride Completed
```

Example:

```dart
enum MapMode {

  idle,

  activeRide,

  searchingRide,

  navigation,

  rideCompleted,
}
```

---

# Map Layers

The map consists of independent layers.

```
Map

  |
  +-- Tile Layer
  |
  +-- User Location Layer
  |
  +-- Rider Marker Layer
  |
  +-- Route Layer
  |
  +-- Traffic Layer (future)
  |
  +-- Controls Layer
```

Each layer should be independently controlled.

---

# Dependencies

## Map Feature

```yaml
flutter_map
latlong2
```

Purpose:

* Map rendering
* Coordinates
* OpenStreetMap tiles

---

## Location Feature

```yaml
geolocator
geocoding
permission_handler
```

Purpose:

* GPS
* Permissions
* Reverse geocoding

---

# Implementation Progress

---

# Phase 1 — Dependencies and Platform Setup

## Dependencies

[x] Add flutter_map

[x] Add latlong2

[x] Add geolocator

[x] Add geocoding

[x] Add permission_handler

[x] Remove unused place search dependencies until destination search is implemented

## Platform Configuration

[ ] Add Android location permissions to `android/app/src/main/AndroidManifest.xml`:
    - `ACCESS_FINE_LOCATION`
    - `ACCESS_COARSE_LOCATION`
    - `FOREGROUND_SERVICE_LOCATION`

[ ] Add iOS location usage descriptions to `ios/Runner/Info.plist`:
    - `NSLocationWhenInUseUsageDescription`
    - `NSLocationAlwaysAndWhenInUseUsageDescription`

[ ] Verify web configuration (no additional config required for flutter_map)

---

# Phase 2 — Map Domain Layer

## Entities

[x] GeoPoint

[x] CameraPosition

[x] MapMarker

[x] MapPolyline

[x] MapBounds

[ ] MapProviderType (enum: openStreetMap, googleMaps, mapbox, here)

## MapProvider Interface

[x] Create MapProvider abstraction

[ ] Add missing interface methods:
    - `Future<void> initialize()`
    - `Future<void> dispose()`
    - `MapCapabilities getCapabilities()`
    - `Future<void> setTileLayer(TileLayerOptions options)`
    - `Future<void> setMapStyle(String styleJson)` (future)
    - `Future<void> enableLayer(String layerId)`
    - `Future<void> disableLayer(String layerId)`

Responsibilities:

* Render map widget
* Camera control: moveCamera, animateCamera, zoomIn, zoomOut, zoomTo, fitBounds, getCameraPosition, cameraPositionStream
* Markers: addMarker, removeMarker, updateMarker, clearMarkers, getMarkers, onMarkerTap, onMarkerLongPress
* Polylines: addPolyline, removePolyline, clearPolylines, getPolylines
* Tile layers & styling: setTileLayer, setMapStyle, enableLayer, disableLayer
* Lifecycle: initialize, dispose, getCapabilities

Does not handle:

* GPS
* Ride state
* Navigation logic

---

# Phase 2 Tests

[ ] Unit tests for GeoPoint equality and serialization
[ ] Unit tests for CameraPosition validation
[ ] Unit tests for MapMarker creation and properties
[ ] Unit tests for MapPolyline validation
[ ] Unit tests for MapBounds contains/expand logic
[ ] Unit tests for MapProviderType enum values

---

# Phase 3 — OpenStreetMap Implementation

## FlutterMapProvider

[x] Create FlutterMapProvider

[x] Implement MapProvider

[x] Configure OpenStreetMap tile layer

[x] Add mapper layer between domain objects and flutter_map models

[ ] Implement missing interface methods:
    - initialize()
    - dispose()
    - getCapabilities()
    - setTileLayer()
    - enableLayer()/disableLayer()

---

# Phase 3 Tests

[ ] Integration test: FlutterMapProvider renders map widget
[ ] Unit test: Camera operations (move, animate, zoom, fitBounds)
[ ] Unit test: Marker CRUD operations
[ ] Unit test: Polyline CRUD operations
[ ] Unit test: Mapper converts domain → flutter_map models correctly
[ ] Unit test: getCapabilities returns correct MapCapabilities

---

# Phase 4 — Riverpod Integration

[x] Create mapProviderProvider

Responsibilities:

Returns active map implementation.

Current:

```
FlutterMapProvider
```

Future:

```
GoogleMapsProvider
```

[ ] Rename from `mapEngineProvider` to `mapProviderProvider`

---

# Phase 4 Tests

[ ] Provider test: mapProviderProvider returns FlutterMapProvider
[ ] Provider test: Can swap implementation via provider override
[ ] Integration test: Widget using mapProviderProvider renders map

---

# Phase 5 — Map Application Widget

[x] Create AppMap widget

Responsibilities:

* Application-facing map widget
* Hides map provider implementation
* Receives domain objects

The application should use:

```
AppMap()
```

instead of:

```
FlutterMap()
```

---

# Phase 5 Tests

[ ] Widget test: AppMap renders with FlutterMapProvider
[ ] Widget test: AppMap accepts markers and polylines
[ ] Widget test: AppMap camera controls work
[ ] Integration test: AppMap with mock MapProvider

---

# Phase 6 — Location Feature Foundation

TODO

The first integration after map rendering is connecting device location to the map.

The purpose of this phase is to prove the complete flow:

```
Device GPS

    |

LocationRepository

    |

PositionEntity

    |

Map Marker

    |

AppMap
```

The location feature is independent from map rendering.

The map should only receive location data and display it.

---

## Location Feature Structure

```
features/

location/

    data/

        repositories/
            geolocator_location_repository.dart

        models/

        datasources/


    domain/

        entities/
            position_entity.dart
            address_entity.dart
            permission_status_entity.dart

        repositories/
            location_repository.dart


    presentation/

        providers/
            location_permission_provider.dart
            current_position_provider.dart
            location_stream_provider.dart
```

---

# Phase 7 — Location Repository Interface

TODO

Create:

```
LocationRepository
```

Responsibilities:

* Request permissions
* Check permissions
* Fetch current position
* Stream position updates
* Reverse geocode coordinates
* Forward geocode addresses

Interface:

```dart
abstract class LocationRepository {

  Future<PermissionStatusEntity> requestPermission();

  Future<PermissionStatusEntity> checkPermission();

  Future<bool> isPermissionGranted();

  Future<PositionEntity?> getCurrentPosition({LocationAccuracy accuracy});

  Stream<PositionEntity> getPositionStream({LocationAccuracy accuracy, DistanceFilter distanceFilter});

  Future<PositionEntity?> getLastKnownPosition();

  Future<List<Placemark>> getAddressFromCoordinates(double lat, double lng);

  Future<List<Location>> getCoordinatesFromAddress(String address);

  Future<bool> openAppSettings();

  Future<bool> openLocationSettings();
}
```

The interface must not depend on:

* geolocator
* Android APIs
* iOS APIs

---

# Phase 7 Tests

[ ] Contract test: LocationRepository interface compiles
[ ] Mock test: MockLocationRepository implements all methods

---

# Phase 8 — Geolocator Implementation

TODO

Create:

```
GeolocatorLocationRepository
```

Responsibilities:

* Wrap geolocator package
* Handle permissions
* Convert platform models into domain entities

Flow:

```
Geolocator Position

        |

Mapper

        |

PositionEntity
```

Handle:

* Permission denied
* Permission permanently denied
* GPS disabled
* Location unavailable

---

# Phase 8 Tests

[ ] Unit test: Permission request returns correct status
[ ] Unit test: getCurrentPosition returns PositionEntity
[ ] Unit test: getPositionStream emits PositionEntity
[ ] Unit test: Geocoding returns Placemark/Location entities
[ ] Unit test: Handles permission denied gracefully
[ ] Unit test: Handles GPS disabled gracefully
[ ] Integration test: GeolocatorLocationRepository on device

---

# Phase 9 — Location Riverpod Providers

TODO

Create:

```
locationPermissionProvider

currentPositionProvider

locationStreamProvider
```

Responsibilities:

## locationPermissionProvider

Tracks:

* unknown
* granted
* denied
* permanently denied

## currentPositionProvider

Provides:

```
PositionEntity?
```

for one-time location fetches.

## locationStreamProvider

Provides continuous updates:

```
PositionEntity stream
```

for moving users.

---

# Phase 9 Tests

[ ] Provider test: locationPermissionProvider state transitions
[ ] Provider test: currentPositionProvider returns position
[ ] Provider test: locationStreamProvider emits stream
[ ] Integration test: Providers work with GeolocatorLocationRepository

---

# Phase 10 — User Location Layer

TODO

Add user location as a map layer.

Updated map layers:

```
Map

  |
  +-- Tile Layer
  +-- User Location Layer
  +-- Rider Marker Layer
  +-- Route Layer
  +-- Traffic Layer (future)
  +-- Controls Layer
```

Responsibilities:

* Display current user position
* Show accuracy circle
* Update marker as location changes

Future:

* Direction arrow
* Heading indicator
* Follow-user camera mode

---

# Phase 10 Tests

[ ] Widget test: UserLocationLayer displays marker
[ ] Widget test: Accuracy circle renders correctly
[ ] Widget test: Marker updates on position stream
[ ] Integration test: UserLocationLayer with locationStreamProvider

---

# Phase 11 — Map Screen Architecture

TODO

After location integration is working, create the map-first application shell.

Create:

```
MapScreen
```

Responsibilities:

* Own the map experience
* Host map overlays
* Coordinate map UI state

Structure:

```
MapScreen

    |

    Stack

    |

    +----------------+
    |                |
    |     AppMap     |
    |                |
    +----------------+

    |

    + MapControls

    + NavigationPanel

    + RideInformationPanel
```

The map becomes the primary authenticated experience.

---

# Phase 11 Tests

[ ] Widget test: MapScreen renders AppMap
[ ] Widget test: MapScreen stacks controls over map
[ ] Integration test: MapScreen with MapMode providers
[ ] Integration test: MapScreen with UserLocationLayer

---

# Phase 12 — Floating Map Controls

TODO

Create floating controls based on map mode.

## Idle Mode

User has no active ride.

Controls:

* Join Ride
* Create Ride (future)
* Profile
* My Rides
* Settings

Example:

```
             MAP


              👤


        +-------------+
        | Join Ride   |
        +-------------+
```

---

## Searching Ride Mode

User is looking for a ride to join.

Controls:

* Cancel search
* Filter options
* My location

---

## Active Ride Mode

User is participating in a ride.

Controls:

* Recenter location
* Show riders
* Ride information
* Route options

---

## Navigation Mode

User is navigating to a destination.

Controls:

* Recenter
* Next turn preview
* Mute guidance
* End navigation

---

## Ride Completed Mode

Ride has finished.

Controls:

* View ride summary
* Save ride
* Share ride
* New ride

---

# Phase 12 Tests

[ ] Widget test: Idle mode controls render
[ ] Widget test: Active ride controls render
[ ] Widget test: Navigation mode controls render
[ ] Widget test: Ride completed controls render
[ ] Widget test: Controls react to MapMode changes

---

# Phase 13 — Map Mode State

TODO

Create:

```
mapModeProvider
```

Initial states:

```dart
enum MapMode {

  idle,

  activeRide,

  searchingRide,

  navigation,

  rideCompleted,
}
```

Controls and overlays react to map mode.

---

# Phase 13 Tests

[ ] Provider test: mapModeProvider initial state is idle
[ ] Provider test: State transitions work correctly
[ ] Integration test: MapMode controls update on state change

---

# Phase 14 — Active Ride Map

TODO

When a user joins a ride, display:

* Destination marker
* User location
* Rider markers
* Route polyline
* ETA
* Next navigation instruction

Example:

```
+--------------------------+

Turn right in 250m

ETA 18 min

+--------------------------+


          👤


========== Route ==========


          📍 Destination
```

---

# Phase 14 Tests

[ ] Widget test: Active ride map shows destination marker
[ ] Widget test: Rider markers display correctly
[ ] Widget test: Route polyline renders
[ ] Widget test: ETA and turn instruction display
[ ] Integration test: Active ride map with live rider data

---

# Phase 15 — Rider Visualization

TODO

Display other riders on the map.

Default:

```
Show rider markers
```

Optional:

```
Select rider

        |

Show route to rider
```

Avoid displaying every rider route simultaneously to prevent map clutter.

---

# Phase 15 Tests

[ ] Widget test: Rider markers display with rider info
[ ] Widget test: Selected rider shows route to them
[ ] Performance test: Multiple rider markers (10+) render smoothly
[ ] Integration test: Rider markers update from live location stream

---

# Phase 16 — Future Map Layers

## Traffic Layer

Future:

```
TrafficLayer
```

Responsibilities:

* Traffic visualization
* Congestion indicators
* Alternative route suggestions

Should not require changes to:

* MapProvider
* MapScreen
* Ride features

---

## Routing Layer

Future:

```
RouteRepository
```

Responsibilities:

* Calculate routes
* ETA
* Turn instructions

The map only renders route results.

---

# Reserved Riverpod Providers (Future)

The following providers are reserved for future implementation and should not be implemented yet:

- `nearbyRidersProvider` - Live nearby rider positions
- `selectedDestinationProvider` - User-selected destination
- `activeRouteProvider` - Currently active navigation route

These will be added when the ride coordination features require them.

---

# Updated Next Task

Current status:

[x] Map abstraction

[x] FlutterMapProvider

[x] OpenStreetMap rendering

[x] AppMap widget

Next implementation:

**Phase 6 — Create LocationRepository interface and location feature foundation.**

---

# Terminology Migration Checklist

The following files need to be renamed from `MapEngine` to `MapProvider` terminology:

[ ] `lib/features/map/domain/engine/map_engine.dart` → `map_provider.dart`
[ ] `lib/features/map/data/engines/flutter_map_engine.dart` → `flutter_map_provider.dart`
[ ] `lib/features/map/presentation/providers/map_engine_provider.dart` → `map_provider_provider.dart`
[ ] Update all imports and references throughout codebase
[ ] Update TODO_MAP_FOUNDATION.md (this file) - DONE
[ ] Update architecture.md
[ ] Update instructions.md
[ ] Update roadmap.md
[ ] Update localsetup.md
[ ] Update RideTogether Project Context.md