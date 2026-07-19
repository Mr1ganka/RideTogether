# RideTogether Map Foundation

**Version:** 4.0  
**Last Updated:** 2026-07-17

---

## Table of Contents

1. [Overview](#overview)
2. [Architecture Principles](#architecture-principles)
3. [Provider-Agnostic Map Engine](#provider-agnostic-map-engine)
4. [Current Feature Structure](#current-feature-structure)
5. [Current Runtime Flow](#current-runtime-flow)
6. [User Location Layer](#user-location-layer)
7. [Current Capabilities](#current-capabilities)
8. [Future Map Enhancements](#future-map-enhancements)
9. [Design Goals](#design-goals)
10. [Implementation Details](#implementation-details)
11. [Key Classes and Interfaces](#key-classes-and-interfaces)

---

## Overview

The **Map Foundation** provides the core infrastructure for all map functionality in RideTogether.

### Key Principle

> **The map feature is responsible only for rendering and interacting with maps.** It is intentionally independent from GPS, ride logic, navigation, and business rules.

### Implementation Approach

- **Provider-agnostic architecture** — Different map providers can be swapped without affecting application code
- **Domain-driven** — Pure Dart domain entities, no Flutter dependencies in domain layer
- **Clean separation** — Map never accesses GPS directly; receives location data via providers

### Current Implementation

```
flutter_map + OpenStreetMap
```

### Future Provider Support

| Provider | Status | Implementation |
|----------|--------|----------------|
| Google Maps | 📋 Planned | `GoogleMapsEngine` |
| Mapbox | 📋 Planned | `MapboxEngine` |
| HERE Maps | 📋 Planned | `HereMapsEngine` |

> **Rule:** Changing providers should only require a new `MapEngine` implementation — no application code changes.

---

## Architecture Principles

### Map and Location are Separate Features

| Map Feature Owns | Location Feature Owns |
|------------------|----------------------|
| Rendering map tiles | GPS |
| Camera positioning | Permissions |
| Markers | Position updates |
| Polylines | Geocoding |
| Map overlays | |
| Map interactions | |

> **The map never accesses platform GPS APIs directly.**

### Current Data Flow

```
Phone GPS
        │
        ▼
GeolocatorLocationRepository
        │
        ▼
PositionEntity
        │
        ▼
currentPositionProvider
        │
        ▼
UserLocationMarker
        │
        ▼
AppMap
        │
        ▼
MapEngine
        │
        ▼
FlutterMapEngine
        │
        ▼
flutter_map
```

---

## Provider-Agnostic Map Engine

The application communicates **only** with the `MapEngine` abstraction.

```
AppMap
     │
     ▼
MapEngine (Interface)
     │
     ├── FlutterMapEngine (current)
     ├── GoogleMapsEngine (future)
     ├── MapboxEngine (future)
     └── HereMapsEngine (future)
```

### Contract

**Presentation code never depends directly on a specific map implementation.**

```dart
// Domain: features/map/domain/engine/map_engine.dart
abstract class MapEngine {
  // Rendering
  Widget build(BuildContext context);
  
  // Camera
  void moveCamera(CameraPosition position);
  void animateCamera(CameraPosition position, Duration duration);
  CameraPosition getCurrentCameraPosition();
  Future<void> fitBounds(MapBounds bounds, {EdgeInsets? padding});
  
  // Markers
  void addMarker(MapMarker marker);
  void removeMarker(String markerId);
  void clearMarkers();
  
  // Polylines
  void addPolyline(MapPolyline polyline);
  void removePolyline(String polylineId);
  void clearPolylines();
  
  // Bounds
  MapBounds getVisibleBounds();
  LatLngBounds getVisibleLatLngBounds();
  
  // Events
  Stream<MapEvent> get mapEvents;
}
```

---

## Current Feature Structure

```
features/
├── map/
│   ├── data/
│   │   ├── engines/
│   │   │   └── flutter_map_engine.dart
│   │   ├── mappers/
│   │   └── constants/
│   ├── domain/
│   │   ├── engine/
│   │   │   └── map_engine.dart
│   │   ├── entities/
│   │   │   ├── camera_position.dart
│   │   │   ├── geo_point.dart
│   │   │   ├── map_marker.dart
│   │   │   ├── map_polyline.dart
│   │   │   ├── map_bounds.dart
│   │   │   └── user_location_marker.dart
│   │   └── repositories/
│   │       └── map_provider.dart
│   └── presentation/
│       ├── providers/
│       └── widgets/
│           └── app_map.dart
│
└── location/
    ├── data/
    ├── domain/
    └── presentation/
```

---

## Current Runtime Flow

### Map Rendering

```
AppMap
    │
    ▼
MapEngine
    │
    ▼
FlutterMapEngine
    │
    ▼
flutter_map
```

### Location Rendering

```
GPS

    │

GeolocatorLocationRepository

    │

PositionEntity

    │

currentPositionProvider

    │

userLocationMarkerProvider

    │

UserLocationMarker

    │

FlutterMap MarkerLayer
```

---

## User Location Layer

The custom user location marker is implemented as **independent rendering components**.

### Component Structure

```
UserLocationMarker

    │

    ├── AccuracyCircle
    ├── DirectionIndicator
    └── LocationDot
```

### Responsibility Separation

**Rendering components receive only rendering data:**
- Position (lat/lng)
- Heading (degrees)
- Speed (m/s)
- Accuracy (meters)

**Rendering components do NOT access:**
- Riverpod providers
- Geolocator
- Repositories
- GPS APIs

### Current Capabilities

| Capability | Description |
|------------|-------------|
| Live GPS position updates | Real-time position stream |
| Animated user location marker | Smooth position transitions |
| Animated accuracy circle | Pulsing accuracy visualization |
| Heading rotation | Shortest-path interpolation |
| Independent marker layers | Separate layer management |
| Approximate accuracy radius | Visual accuracy scaling | |

### Known Limitation

> **TODO:** Proper accuracy scaling should use the current map projection and zoom level provided by `flutter_map`.

---

## Current Capabilities

### Implemented Features

| Category | Features |
|----------|----------|
| **Architecture** | Provider-agnostic MapEngine abstraction, FlutterMapEngine implementation |
| **Rendering** | OpenStreetMap tile rendering, AppMap widget |
| **Domain Models** | GeoPoint, CameraPosition, MapMarker, MapPolyline, MapBounds |
| **Location** | PositionEntity integration, Current position stream |
| **User Marker** | Live user location updates, Custom user location marker |
| **Animations** | Heading animation (shortest-path), Accuracy pulse animation |
| **Foundations** | Marker system, Polyline system |

---

## Future Map Enhancements

These improvements remain **within the map foundation** and can be implemented independently of ride functionality.

### Camera

| Enhancement | Description |
|-------------|-------------|
| Camera controller abstraction | Unified camera control interface |
| Animated camera movement | Smooth transitions with easing |
| Fit bounds | Auto-fit markers/polylines |
| Camera state management | Persist/restore camera position |

### Map Interaction

| Enhancement | Description |
|-------------|-------------|
| Tap callbacks | Handle map taps |
| Long press callbacks | Handle long presses |
| Marker selection | Tap-to-select markers |
| Camera movement callbacks | Track camera changes |

### Layers

| Enhancement | Description |
|-------------|-------------|
| Additional marker layers | Multiple marker groups |
| Route rendering | Dedicated route layer |
| Traffic layer | Traffic overlay (provider dependent) |
| Configurable overlays | Dynamic layer composition |

### Provider Support

| Provider | Status |
|----------|--------|
| Google Maps | 📋 Planned |
| Mapbox | 📋 Planned |
| HERE Maps | 📋 Planned |

---

## Design Goals

The Map Foundation should:

| Goal | Description |
|------|-------------|
| **GPS Independence** | Remain independent from GPS implementations |
| **Ride Logic Independence** | Remain independent from ride business logic |
| **Provider Agnostic** | Allow new map providers without app changes |
| **Domain-Only Rendering** | Render only domain entities, not external models |
| **Logic-Free Widgets** | Keep rendering widgets free of application logic |
| **Extensible** | Allow future map providers to be added easily |

---

## Implementation Details

### Domain Entities

#### GeoPoint
```dart
class GeoPoint {
  final double latitude;
  final double longitude;
  
  const GeoPoint({required this.latitude, required this.longitude});
  
  LatLng toLatLng() => LatLng(latitude, longitude);
  static GeoPoint fromLatLng(LatLng latLng) => 
    GeoPoint(latitude: latLng.latitude, longitude: latLng.longitude);
}
```

#### CameraPosition
```dart
class CameraPosition {
  final GeoPoint center;
  final double zoom;
  final double bearing;
  final double tilt;
  
  const CameraPosition({
    required this.center,
    required this.zoom,
    this.bearing = 0.0,
    this.tilt = 0.0,
  });
}
```

#### MapMarker
```dart
class MapMarker {
  final String id;
  final GeoPoint position;
  final Widget icon;
  final Anchor anchor;
  final int zIndex;
  final Map<String, dynamic>? metadata;
  
  const MapMarker({
    required this.id,
    required this.position,
    required this.icon,
    this.anchor = Anchor.center,
    this.zIndex = 0,
    this.metadata,
  });
}
```

#### MapPolyline
```dart
class MapPolyline {
  final String id;
  final List<GeoPoint> points;
  final Color color;
  final double width;
  final StrokePattern? pattern;
  final bool isDotted;
  
  const MapPolyline({
    required this.id,
    required this.points,
    required this.color,
    this.width = 4.0,
    this.pattern,
    this.isDotted = false,
  });
}
```

#### MapBounds
```dart
class MapBounds {
  final GeoPoint northEast;
  final GeoPoint southWest;
  
  const MapBounds({
    required this.northEast,
    required this.southWest,
  });
  
  LatLngBounds toLatLngBounds() => LatLngBounds(
    LatLng(northEast.latitude, northEast.longitude),
    LatLng(southWest.latitude, southWest.longitude),
  );
}
```

#### UserLocationMarker
```dart
class UserLocationMarker {
  final GeoPoint position;
  final double heading;        // Degrees 0-360
  final double? speed;         // m/s
  final double accuracy;       // Meters
  final DateTime timestamp;
  
  const UserLocationMarker({
    required this.position,
    required this.heading,
    this.speed,
    required this.accuracy,
    required this.timestamp,
  });
}
```

### AppMap Widget

```dart
// features/map/presentation/widgets/app_map.dart
class AppMap extends ConsumerWidget {
  final CameraPosition? initialCameraPosition;
  final List<MapMarker> markers;
  final List<MapPolyline> polylines;
  final void Function(CameraPosition)? onCameraMove;
  final void Function(GeoPoint)? onTap;
  final void Function(GeoPoint)? onLongPress;
  final MapMode mode;
  
  const AppMap({
    super.key,
    this.initialCameraPosition,
    this.markers = const [],
    this.polylines = const [],
    this.onCameraMove,
    this.onTap,
    this.onLongPress,
    this.mode = MapMode.idle,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapEngine = ref.watch(mapEngineProvider);
    return mapEngine.build(context);
  }
}
```

### FlutterMapEngine Implementation

```dart
// features/map/data/engines/flutter_map_engine.dart
class FlutterMapEngine implements MapEngine {
  final MapController _mapController = MapController();
  final List<MapMarker> _markers = [];
  final List<MapPolyline> _polylines = [];
  CameraPosition? _currentCameraPosition;
  
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _currentCameraPosition?.center.toLatLng() 
          ?? const LatLng(0, 0),
        initialZoom: _currentCameraPosition?.zoom ?? 15.0,
        onTap: (_, point) => _onTap(point),
        onLongPress: (_, point) => _onLongPress(point),
        onPositionChanged: (position, hasGesture) => 
          _onPositionChanged(position),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.ridetogether.app',
        ),
        MarkerLayer(markers: _buildFlutterMapMarkers()),
        PolylineLayer(polylines: _buildFlutterMapPolylines()),
      ],
    );
  }
  
  @override
  void moveCamera(CameraPosition position) {
    _currentCameraPosition = position;
    _mapController.move(position.center.toLatLng(), position.zoom);
  }
  
  @override
  void animateCamera(CameraPosition position, Duration duration) {
    _currentCameraPosition = position;
    _mapController.move(
      position.center.toLatLng(), 
      position.zoom,
      duration: duration,
    );
  }
  
  @override
  void addMarker(MapMarker marker) {
    _markers.removeWhere((m) => m.id == marker.id);
    _markers.add(marker);
    _notifyMarkerChange();
  }
  
  @override
  void removeMarker(String markerId) {
    _markers.removeWhere((m) => m.id == markerId);
    _notifyMarkerChange();
  }
  
  // ... other implementations
}
```

---

## Key Classes and Interfaces

### Domain Layer (`features/map/domain/`)

| File | Purpose |
|------|---------|
| `engine/map_engine.dart` | Abstract map engine contract |
| `entities/geo_point.dart` | Latitude/longitude coordinate |
| `entities/camera_position.dart` | Camera state (center, zoom, bearing, tilt) |
| `entities/map_marker.dart` | Marker with position, icon, metadata |
| `entities/map_polyline.dart` | Polyline with points, color, styling |
| `entities/map_bounds.dart` | Visible map bounds (NE/SW corners) |
| `entities/user_location_marker.dart` | Specialized user location data |
| `repositories/map_provider.dart` | Map provider abstraction |

### Data Layer (`features/map/data/`)

| File | Purpose |
|------|---------|
| `engines/flutter_map_engine.dart` | flutter_map implementation of MapEngine |
| `constants/map_constants.dart` | Default zoom, tile URLs, etc. |
| `mappers/` | Domain ↔ flutter_map model conversion |

### Presentation Layer (`features/map/presentation/`)

| File | Purpose |
|------|---------|
| `widgets/app_map.dart` | Main map widget, composes engine |
| `providers/map_providers.dart` | Riverpod providers for map state |

---

## Relationship with Location Feature

### Location Provides

| Provider | Type | Purpose |
|----------|------|---------|
| `currentPositionProvider` | `Stream<PositionEntity>` | Live GPS positions |
| `userLocationMarkerProvider` | `UserLocationMarker` | Formatted marker data |

### Map Consumes

| Consumer | Purpose |
|----------|---------|
| `UserLocationMarker` widget | Renders user position |
| `AppMap` | Receives marker via MarkerLayer |

### Data Flow

```
Location Feature                          Map Feature
───────────────                          ───────────
currentPositionProvider ──▶              │
     │                                   │
     ▼                                   │
userLocationMarkerProvider ──▶           │
     │                                   │
     ▼                                   ▼
UserLocationMarker (widget) ──▶ AppMap ──▶ MarkerLayer
```

---

## Testing Strategy

### Unit Tests (Domain)

- Test `GeoPoint` calculations
- Test `CameraPosition` interpolation
- Test `MapBounds` contains logic
- Test `MapMarker` equality

### Widget Tests (Presentation)

- Test `AppMap` renders correctly
- Test marker display
- Test polyline display
- Test camera movement

### Integration Tests

- Test full map + location flow
- Test provider switching

---

## Migration Guide: Adding a New Map Provider

1. **Create new engine class:**
   ```dart
   class GoogleMapsEngine implements MapEngine { ... }
   ```

2. **Implement all MapEngine methods:**
   - Use Google Maps SDK for Flutter
   - Convert domain entities to Google Maps models
   - Handle platform channels appropriately

3. **Register in providers:**
   ```dart
   final mapEngineProvider = Provider<MapEngine>((ref) {
     switch (config.mapProvider) {
       case MapProvider.google:
         return GoogleMapsEngine();
       case MapProvider.flutterMap:
         return FlutterMapEngine();
     }
   });
   ```

4. **No application code changes required.**

---

## Performance Considerations

| Concern | Mitigation |
|---------|------------|
| Marker count | Use clustering for >100 markers |
| Polyline complexity | Simplify points (Douglas-Peucker) |
| Tile caching | Configure tile cache size |
| Rebuild frequency | Use `ref.listen` for selective updates |
| Animation performance | Use `AnimationController` with `TickerProvider` |

---

## Security Considerations

| Aspect | Implementation |
|--------|----------------|
| Tile URLs | Use HTTPS only |
| API Keys | Never hardcode; use `--dart-define` or native config |
| Location data | Never log raw coordinates |
| Map style | Validate custom styles |

---

## Monitoring and Debugging

### Debug Overlays

```dart
// Development only
if (kDebugMode) {
  children.add(DebugLayer());
}
```

### Logging

```dart
// MapEngine implementations should log:
log('MapEngine: moveCamera to $position', name: 'MapEngine');
log('MapEngine: added marker ${marker.id}', name: 'MapEngine');
```

---

*Document Version 4.0 — Updated after Map Foundation completion.*