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

## Status: Completed

The first map integration milestone is connecting device location to the map.

The complete flow is now working:

```
Device GPS

    |

Geolocator

    |

LocationRepository

    |

PositionEntity

    |

User Marker

    |

AppMap

    |

FlutterMap/OpenStreetMap
```

The location feature remains independent from map rendering.

The map receives location data and displays it.

---

# Location Feature Structure

```
features/

location/

    data/

        repositories/
            geolocator_location_repository.dart

        mappers/
            position_mapper.dart
            permission_mapper.dart


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
            initial_position_provider.dart
```

---

# Phase 7 — Location Repository Interface

## Status: Completed

Created:

```
LocationRepository
```

Responsibilities:

* Request permissions
* Check permissions
* Fetch current position
* Stream position updates

The interface does not depend on:

* geolocator
* Android APIs
* iOS APIs

---

# Phase 8 — Geolocator Implementation

## Status: Completed

Created:

```
GeolocatorLocationRepository
```

Responsibilities:

* Wrap geolocator package
* Handle GPS access
* Convert platform models into domain entities

Flow:

```
Geolocator Position

        |

PositionMapper

        |

PositionEntity
```

Implemented:

[x] getCurrentPosition()

[x] getPositionStream()

[x] PositionEntity mapping

[x] Permission abstraction

---

# Phase 9 — Location Riverpod Providers

## Status: Completed

Implemented:

```
locationPermissionProvider

currentPositionProvider

initialPositionProvider
```

Responsibilities:

## currentPositionProvider

Provides continuous GPS updates:

```
Stream<PositionEntity>
```

Used for:

* Live user movement
* Rider tracking
* Future active ride tracking


## initialPositionProvider

Provides initial camera position:

```
PositionEntity?
```

Used for:

* Initial map centering

---

# Phase 10 — User Location Layer

## Status: Completed

The user location layer is now implemented.

Current behaviour:

```
GPS update

    |

PositionEntity

    |

MapMarker

    |

MarkerLayer

    |

User location displayed
```

Implemented:

[x] Current location marker

[x] Marker updates from GPS stream

[x] Live position updates

Future:

[ ] Accuracy circle

[ ] Heading indicator

[ ] Direction arrow

[ ] Follow-user camera mode

---

# Current Map Architecture

Current runtime flow:

```
HomeScreen

    |

AppMap

    |

MapEngine Interface

    |

FlutterMapEngine

    |

flutter_map

    |

OpenStreetMap
```


Location flow:

```
Phone GPS

    |

GeolocatorLocationRepository

    |

currentPositionProvider

    |

userMarkerProvider

    |

AppMap markers

    |

FlutterMap MarkerLayer
```

---

# Map UI Direction

The application follows a map-first approach.

The map is the primary workspace.

Other features will appear as overlays:

```
Map

 |

 + Floating Controls

 + Navigation Panels

 + Ride Information Panels

 + Profile Panels
```

The homepage will eventually become:

```
MapScreen

    |

    Stack

    |

    +----------------+
    |                |
    |      Map       |
    |                |
    +----------------+

    Floating Buttons
```

---

# Next Implementation Phase

# Phase 11 — Camera Controls and Map Interaction

## Status: Next

The next goal is making the map behave like a navigation application.

Features:

[x] Display user location

Next:

[ ] Add MapEngine camera control abstraction

[ ] Add moveCamera()

[ ] Add zoomIn()

[ ] Add zoomOut()

[ ] Add centerOnUser()

[ ] Add floating map controls

[ ] Add recenter button


Architecture:

```
UI

 |

MapEngine

 |

FlutterMapEngine

 |

MapController
```


The UI must never directly access:

```
flutter_map MapController
```

---

# Phase 12 — Floating Map Controls

TODO

Controls will depend on MapMode.

## Idle Mode

User has not joined a ride.

Controls:

* Join Ride
* Profile
* My Rides
* Settings


## Active Ride Mode

User is participating in a ride.

Controls:

* Recenter location
* Show riders
* Route options
* Ride information


## Navigation Mode

Controls:

* Recenter
* Next turn preview
* ETA
* Route options


---

# Phase 13 — Follow User Mode

TODO

Add optional camera following.

Behaviour:

Default:

```
Marker moves

Camera remains where user left it
```


User presses:

```
[Center Location]
```

Then:

```
Camera follows user
```


This avoids preventing users from exploring the map manually.

---

# Future Map Features

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

* MapEngine
* MapScreen
* Ride features


## Routing Layer

Future:

```
RouteRepository
```

Responsibilities:

* Route calculation
* ETA
* Turn-by-turn instructions

The map only renders route results.

---

# Current Next Task

Completed:

[x] Map abstraction

[x] FlutterMapEngine

[x] OpenStreetMap rendering

[x] AppMap widget

[x] LocationRepository abstraction

[x] Geolocator implementation

[x] Permission flow

[x] Current location stream

[x] Live user marker


Next:

**Phase 11 — Camera Controls and Map Interaction**