# RideTogether Architecture Documentation

**Version:** 4.1  
**Last Updated:** 2026-07-23

---

## Table of Contents

1. [Overview](#overview)
2. [Architecture Principles](#architecture-principles)
3. [Feature-First Architecture](#feature-first-architecture)
4. [Layered Architecture](#layered-architecture)
5. [State Management with Riverpod](#state-management-with-riverpod)
6. [Repository Pattern](#repository-pattern)
7. [Navigation with GoRouter](#navigation-with-gorouter)
8. [Theme System](#theme-system)
9. [Map Architecture](#map-architecture)
10. [Location Architecture](#location-architecture)
11. [Authentication Architecture](#authentication-architecture)
12. [Rider Identity Architecture](#rider-identity-architecture)
13. [Startup Architecture](#startup-architecture)
14. [Ride Architecture (Future)](#ride-architecture-future)
14. [External Provider Strategy](#external-provider-strategy)
15. [Design Goals](#design-goals)
16. [Development Roadmap](#development-roadmap)
17. [Future Architecture Direction](#future-architecture-direction)

---

## Overview

RideTogether is a mobile-first group ride coordination application built with Flutter. The architecture follows clean architecture principles with feature-first organization, ensuring separation of concerns, testability, and maintainability.

### Target Users

- Motorcycle riders
- Cyclists
- Road trip groups
- Convoys
- Adventure riders

### Core Philosophy

> **Every feature should answer: "Does this make group riding easier or safer?"**

### Priorities

| Priority | Description |
|----------|-------------|
| Simple User Experience | Intuitive interfaces that work while riding |
| Minimal Rider Interaction | Reduce distraction during rides |
| Reliable Operation | Consistent behavior across conditions |
| Low Battery Usage | Optimize for extended rides |
| Low Network Usage | Work in areas with poor connectivity |
| Safety Over Features | Safety-critical features take precedence |

**The map is the primary application experience.**

---

## Architecture Principles

### 1. Feature-First Organization

Code is organized by feature rather than by layer type. Each feature contains its own data, domain, and presentation layers.

```
lib/features/
├── auth/
│   ├── data/
│   ├── domain/
│   └── presentation/
├── map/
│   ├── data/
│   ├── domain/
│   └── presentation/
├── location/
│   ├── data/
│   ├── domain/
│   └── presentation/
├── profile/
│   ├── data/
│   ├── domain/
│   └── presentation/
└── ride/
    ├── data/
    ├── domain/
    └── presentation/
```

### 2. Layer Separation

Each feature follows a strict three-layer architecture:

```
┌─────────────────────────────────────┐
│         PRESENTATION LAYER          │
│  Widgets │ Screens │ Providers      │
│  - Render UI                         │
│  - Receive state                     │
│  - Trigger actions                   │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│           DOMAIN LAYER              │
│  Entities │ Repositories │ Use Cases │
│  - Business logic                    │
│  - Application contracts             │
│  - Pure Dart (no Flutter)            │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│           DATA LAYER                │
│  Repositories │ Data Sources │ Models│
│  - External system integration       │
│  - Firebase, GPS, APIs               │
│  - Data mapping                      │
└─────────────────────────────────────┘
```

### 3. Dependency Rule

**Inner layers must not depend on outer layers.** Dependencies point inward:

```
Presentation → Domain ← Data
```

The domain layer is the core—it contains no Flutter dependencies and defines the contracts (repositories, entities) that both presentation and data layers implement.

### 4. Single Responsibility

- **Widgets**: Render UI, receive state, trigger actions
- **Providers**: Manage state, coordinate features
- **Repositories**: Hide external systems, expose contracts
- **Entities**: Pure domain models
- **Data Sources**: Handle specific external APIs

---

## Feature-First Architecture

### Structure

```
lib/features/<feature_name>/
├── data/
│   ├── repositories/        # Repository implementations
│   ├── datasources/         # External API integrations
│   ├── models/              # DTOs for external systems
│   └── mappers/             # Model ↔ Entity conversion
├── domain/
│   ├── entities/            # Pure domain models
│   ├── repositories/        # Repository interfaces (contracts)
│   └── mappers/             # Domain-level mappers
└── presentation/
    ├── screens/             # Full-screen UI
    ├── widgets/             # Reusable UI components
    └── providers/           # Riverpod state management
```

### Benefits

| Benefit | Description |
|---------|-------------|
| **Isolation** | Features can be developed, tested, and removed independently |
| **Scalability** | New features follow the same pattern |
| **Team Ownership** | Teams can own entire features end-to-end |
| **Reusability** | Domain layer can be shared across platforms |

---

## Layered Architecture

### Presentation Layer

**Responsibilities:**
- Render UI components
- Consume state from providers
- Dispatch user actions to providers
- Handle navigation

**Must NOT:**
- Access Firebase directly
- Access GPS/location APIs directly
- Contain business logic
- Perform data transformations

**Example:**
```dart
// ✅ Good: Widget only renders and triggers actions
class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      body: authState.when(
        data: (_) => const HomeScreen(),
        loading: () => const CircularProgressIndicator(),
        error: (e, _) => Text('Error: $e'),
      ),
    );
  }
}
```

### Domain Layer

**Responsibilities:**
- Define business entities (pure Dart classes)
- Define repository interfaces (abstract contracts)
- Contain use cases / business logic
- Define application-specific exceptions

**Characteristics:**
- Zero Flutter dependencies
- Zero external dependencies
- Pure Dart
- Highly testable

**Example:**
```dart
// ✅ Good: Pure domain entity
class AppUser {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  
  const AppUser({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
  });
}

// ✅ Good: Repository contract
abstract class AuthRepository {
  Stream<AppUser?> get authStateChanges;
  Future<AppUser> signInWithGoogle();
  Future<void> signOut();
}
```

### Data Layer

**Responsibilities:**
- Implement repository interfaces
- Communicate with external systems (Firebase, GPS, REST APIs)
- Handle data serialization/deserialization
- Map external models to domain entities
- Handle caching and offline support

**Example:**
```dart
// ✅ Good: Repository implementation
class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  
  @override
  Stream<AppUser?> get authStateChanges => 
    _firebaseAuth.authStateChanges().map(_mapToAppUser);
  
  @override
  Future<AppUser> signInWithGoogle() async {
    // Firebase + Google Sign-In logic
    // Return domain entity
  }
  
  AppUser? _mapToAppUser(User? user) {
    if (user == null) return null;
    return AppUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? '',
      photoUrl: user.photoURL,
    );
  }
}
```

---

## State Management with Riverpod

### Provider Types

| Provider Type | Use Case | Example |
|---------------|----------|---------|
| `Provider` | Simple dependencies, computed values | Repository instances |
| `StateProvider` | Simple mutable state | UI toggle state |
| `StateNotifierProvider` | Complex state with logic | Auth state, ride state |
| `AsyncNotifierProvider` | Async initialization | User profile loading |
| `StreamProvider` | Real-time streams | Auth state changes, location updates |
| `FutureProvider` | One-time async operations | Initial config loading |

### Provider Organization

```dart
// features/auth/presentation/providers/auth_providers.dart

// Repository provider (dependency injection)
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository(
    firebaseAuth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn.instance,
  );
});

// State notifier for auth logic
final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<AppUser?>>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

// Derived providers
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).maybeWhen(
    data: (user) => user != null,
    orElse: () => false,
  );
});
```

### Best Practices

1. **Keep providers in presentation layer** - They coordinate UI state
2. **Use `ref.watch` for dependencies** - Enables automatic rebuilds
3. **Use `ref.read` for one-time actions** - In callbacks, not build methods
4. **Scope providers to features** - Avoid global providers when possible
5. **Use `AsyncValue` for loading/error states** - Built-in pattern handling

---

## Repository Pattern

### Purpose

Repositories abstract external systems behind clean interfaces, enabling:

- **Testability** - Mock repositories in tests
- **Swapability** - Change implementations without affecting domain
- **Separation** - Domain doesn't know about Firebase, GPS, etc.

### Structure

```
domain/repositories/
  └── auth_repository.dart      # Interface (contract)

data/repositories/
  └── firebase_auth_repository.dart  # Implementation
```

### Repository Contract Example

```dart
// domain/repositories/auth_repository.dart
abstract class AuthRepository {
  // Stream of authentication state
  Stream<AppUser?> get authStateChanges;
  
  // Actions
  Future<AppUser> signInWithGoogle();
  Future<void> signOut();
  Future<void> deleteAccount();
  
  // Queries
  Future<AppUser?> getCurrentUser();
}
```

### Implementation Example

```dart
// data/repositories/firebase_auth_repository.dart
class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final AuthMapper _mapper;
  
  FirebaseAuthRepository({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required AuthMapper mapper,
  }) : _firebaseAuth = firebaseAuth,
       _googleSignIn = googleSignIn,
       _mapper = mapper;
  
  @override
  Stream<AppUser?> get authStateChanges => 
    _firebaseAuth.authStateChanges()
      .map(_mapper.toDomain);
  
  @override
  Future<AppUser> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw AuthException.cancelled();
    
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return _mapper.toDomain(userCredential.user!);
  }
  
  @override
  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
```

---

## Navigation with GoRouter

### Router Configuration

```dart
// lib/app/router/app_router.dart
abstract final class AppRouter {
  static GoRouter createRouter(WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final startupState = ref.watch(startupProvider);
    final refreshNotifier = RouterRefreshNotifier();

    // Re-evaluate routes when auth or startup state changes
    ref.listen(authStateProvider, (_, _) => refreshNotifier.refresh());
    ref.listen(startupProvider, (_, _) => refreshNotifier.refresh());

    return GoRouter(
      initialLocation: AppRoutes.splash,
      refreshListenable: refreshNotifier,
      redirect: (context, state) {
        final location = state.matchedLocation;
        final startupResult = startupState.valueOrNull;

        // Wait for startup
        if (startupState.isLoading && startupResult == null) {
          return AppRoutes.splash;
        }

        // Location permission has priority over authentication
        if (startupResult is StartupLocationRequired) {
          if (location != AppRoutes.locationRequired) {
            return AppRoutes.locationRequired;
          }
          return null;
        }

        final isAuthenticated = authState.valueOrNull != null;

        // Not logged in → login
        if (!isAuthenticated && location != AppRoutes.login) {
          return AppRoutes.login;
        }

        // Logged in but on splash/login → home
        if (isAuthenticated && (location == AppRoutes.splash || location == AppRoutes.login)) {
          return AppRoutes.home;
        }

        return null;
      },
      routes: [
        GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
        GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/location-required', builder: (_, __) {
          final result = ref.read(startupProvider).valueOrNull;
          if (result is StartupLocationRequired) {
            return LocationRequiredScreen(status: result.status);
          }
          return const SplashScreen();
        }),
      ],
    );
  }
}
```

### Navigation Patterns

```dart
// Navigate with context
context.go('/home');              // Replace stack
context.push('/ride/123');        // Push on stack
context.pop();                    // Go back

// Navigate with ref (outside build)
ref.read(appRouterProvider).go('/home');
```

### Route Definitions

```dart
// lib/app/router/app_routes.dart
abstract final class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String locationRequired = '/location-required';
}
```

---

## Theme System

### Structure

```
lib/core/theme/
├── app_colors.dart       # Color definitions
├── app_text_styles.dart  # Typography
├── app_spacing.dart      # Spacing scale
├── app_radius.dart       # Border radius
├── app_shadows.dart      # Elevation/shadows
├── app_durations.dart    # Animation durations
└── app_theme.dart        # ThemeData composition
```

### Material 3 Implementation

```dart
// app_theme.dart
ThemeData createAppTheme(Brightness brightness) {
  final colorScheme = brightness == Brightness.light
      ? AppColors.lightColorScheme
      : AppColors.darkColorScheme;
  
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: AppTextStyles.textTheme(colorScheme),
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
    ),
    // ... other theme configurations
  );
}
```

### Dark/Light Mode

- System preference detection
- Manual toggle support
- Persisted user preference
- Smooth transitions

---

## Map Architecture

### Overview

The map system is **provider-agnostic**—the application communicates only with abstractions, never directly with map implementations.

### Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                        AppMap Widget                          │
└─────────────────────────────┬───────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                     MapEngine (Interface)                    │
│  - render()                                                  │
│  - moveCamera()                                              │
│  - addMarker()                                               │
│  - addPolyline()                                             │
│  - getVisibleBounds()                                        │
└─────────────────────────────┬───────────────────────────────┘
                              │
              ┌───────────────┼───────────────┐
              ▼               ▼               ▼
       ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
       │FlutterMapEng│ │GoogleMapsEng│ │  MapboxEng  │
       │  (current)  │ │  (future)   │ │  (future)   │
       └─────────────┘ └─────────────┘ └─────────────┘
              │               │               │
              ▼               ▼               ▼
       ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
       │flutter_map  │ │Google Maps  │ │   Mapbox    │
       │  + OSM      │ │   SDK       │ │    SDK      │
       └─────────────┘ └─────────────┘ └─────────────┘
```

### Domain Entities

| Entity | Description |
|--------|-------------|
| `GeoPoint` | Latitude/longitude coordinate |
| `CameraPosition` | Map camera state (center, zoom, bearing, tilt) |
| `MapMarker` | Marker with position, icon, anchor, metadata |
| `MapPolyline` | Polyline with points, color, width, pattern |
| `MapBounds` | Visible map bounds (northeast, southwest) |
| `MapMode` | Application map mode (`idle`, `searchingRide`, `activeRide`, `navigation`, `completedRide`) |
| `UserLocationMarker` | Specialized marker for current user |

### Current Implementation

- **Provider:** `flutter_map` + OpenStreetMap
- **Engine:** `FlutterMapEngine` implements `MapEngine`
- **Widget:** `AppMap` composes the engine, accepts `MapController` for external camera control
- **Controllers:** `mapControllerProvider` (shared `MapController`), `mapModeProvider` (`StateProvider<MapMode>`)
- **Overlays:** `FloatingMapControls` (navbar with auto-hide, Recenter button, JoinRide pill)

### Map Responsibilities

| Owns | Does NOT Own |
|------|--------------|
| Map rendering | GPS / Permissions |
| Camera movement | Ride logic |
| Markers | Rider synchronization |
| Polylines | Navigation logic |
| Layers | Business rules |
| Map interactions | |
| Overlays | |

---

## Location Architecture

### Overview

Location is **completely independent** from maps. The map *receives* location data but never *requests* it.

### Data Flow

```
┌──────────┐     ┌────────────────────────┐     ┌─────────────────┐
│   GPS    │────▶│ GeolocatorLocationRepo │────▶│ PositionEntity  │
│ (System) │     │   (Repository)         │     │  (Domain)       │
└──────────┘     └────────────────────────┘     └────────┬────────┘
                                                          │
                                                          ▼
┌──────────────────────────────────────────────────────────────────┐
│                     Riverpod Providers                            │
│  currentPositionProvider (Stream<PositionEntity>)                │
│  userLocationMarkerProvider (UserLocationMarker)                 │
└────────────────────────────────────────────────────┬─────────────┘
                                                     │
                                                     ▼
┌──────────────────────────────────────────────────────────────────┐
│                      Map Rendering                                │
│  UserLocationMarker ──▶ AppMap ──▶ MapEngine ──▶ flutter_map     │
└──────────────────────────────────────────────────────────────────┘
```

### Domain Entity: PositionEntity

```dart
class PositionEntity {
  final double latitude;
  final double longitude;
  final double? altitude;
  final double accuracy;      // Meters
  final double? speed;        // m/s
  final double? heading;      // Degrees (0-360)
  final DateTime timestamp;
  final double? speedAccuracy;
  final double? headingAccuracy;
  
  const PositionEntity({
    required this.latitude,
    required this.longitude,
    this.altitude,
    required this.accuracy,
    this.speed,
    this.heading,
    required this.timestamp,
    this.speedAccuracy,
    this.headingAccuracy,
  });
}
```

### Repository Contract

```dart
abstract class LocationRepository {
  // Permission handling
  Future<PermissionStatus> checkPermission();
  Future<PermissionStatus> requestPermission();
  
  // Position streams
  Stream<PositionEntity> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    Duration? distanceFilter,
  });
  
  // One-time position
  Future<PositionEntity> getCurrentPosition();
  
  // Geocoding
  Future<List<PlacemarkEntity>> placemarkFromCoordinates(
    double latitude,
    double longitude,
  );
  
  Future<List<PlacemarkEntity>> placemarkFromAddress(String address);
}
```

### Current Implementation

- **Provider:** `geolocator` package
- **Repository:** `GeolocatorLocationRepository`
- **Features:** Live updates, permission handling, geocoding
- **Permission flow:** Integrated into startup sequence via `startupProvider` → `StartupResult` → `LocationRequiredScreen`
- **Lifecycle:** `AppLifecycleObserver` invalidates startup on resume to re-check permissions

---

## Startup Architecture

### Purpose

The startup flow determines whether the app is ready to show the main map experience. It validates location permissions before proceeding, rather than handling them reactively.

### Flow

```
SplashScreen
     │
     ▼
startupProvider (Future<StartupResult>)
     │
     ├── checks location permission (ensurePermissionGranted)
     │
     ├── StartupLocationRequired
     │   └── LocationRequiredScreen
     │       ├── Enable Location → requestPermission → invalidate startup
     │       └── Open Settings → openAppSettings → on resume: AppLifecycleObserver invalidates startup
     │
     └── StartupReady
         └── HomeScreen (map experience)
```

### StartupResult (Sealed Class)

```dart
// features/startup/domain/entities/startup_result.dart
sealed class StartupResult {
  const StartupResult();
}

class StartupReady extends StartupResult {
  const StartupReady();
}

class StartupLocationRequired extends StartupResult {
  final PermissionStatusEntity status;
  const StartupLocationRequired(this.status);
}
```

### AppLifecycleObserver

```dart
// core/providers/app_lifecycle_providers.dart
class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // On resume, re-check permissions
    if (previous == paused && state == resumed) {
      ref.invalidate(startupProvider);
    }
  }
}
```

### Router Integration

The router checks `StartupResult` in redirect logic. If `StartupLocationRequired`, it routes to `/location-required` regardless of authentication state.

---

## Authentication Architecture

### Flow

```
App Startup
         │
         ▼
SplashScreen (startupProvider)
         │
    ┌────┴────┐
    ▼         ▼
Ready    Location Required
    │         │
    ▼         ▼
HomeScreen  LocationRequiredScreen
                │
                ▼
            Open Settings / Request Permission
                │
                ▼
        invalidate startupProvider → re-check
```

### Components

| Component | Location | Responsibility |
|-----------|----------|----------------|
| `AuthRepository` | `domain/repositories/` | Contract for auth operations |
| `FirebaseAuthRepository` | `data/repositories/` | Firebase + Google Sign-In implementation |
| `AppUser` | `domain/entities/` | Pure domain user model |
| `AuthMapper` | `domain/mappers/` | Firebase User ↔ AppUser |
| `AuthNotifier` | `presentation/providers/` | State management |
| `LoginScreen` | `presentation/screens/` | UI for authentication |
| `StartupResult` | `startup/domain/entities/` | Sealed class (`StartupReady` / `StartupLocationRequired`) |
| `LocationRequiredScreen` | `location/presentation/screens/` | Permission gate screen |
| `AppLifecycleObserver` | `core/providers/` | Re-checks permissions on app resume |

### Supported Methods

- ✅ Google Sign-In
- 🔄 Email/Password (planned)
- 🔄 Apple Sign-In (planned)

---

## Rider Identity Architecture

### Purpose

Separate **authentication** ("Who is this user?") from **rider profile** ("Who is this rider?").

### Flow

```
Firebase Auth
     │
     ▼
AppUser (UID, email, name)
     │
     ▼
Profile Repository
     │
     ▼
RiderProfile Entity
     │
     ▼
Profile Providers
```

### RiderProfile Entity

```dart
class RiderProfile {
  final String uid;           // Links to AppUser
  final String displayName;   // Rider name
  final String? bikeModel;    // Motorcycle/bicycle model
  final String? bikeType;     // sport, cruiser, adventure, etc.
  final String? phoneNumber;  // Emergency contact
  final String? emergencyContact;
  final Map<String, dynamic> preferences;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  const RiderProfile({
    required this.uid,
    required this.displayName,
    this.bikeModel,
    this.bikeType,
    this.phoneNumber,
    this.emergencyContact,
    required this.preferences,
    required this.createdAt,
    required this.updatedAt,
  });
}
```

### Features

- Automatic profile creation on first sign-in
- Firestore storage with real-time sync
- Profile editing screen
- Preferences management

---

## Ride Architecture (Future)

### Planned Structure

```
features/ride/
├── data/
│   ├── repositories/
│   │   └── firebase_ride_repository.dart
│   ├── datasources/
│   │   └── firestore_ride_datasource.dart
│   └── models/
│       └── ride_model.dart
├── domain/
│   ├── entities/
│   │   ├── ride.dart
│   │   ├── ride_role.dart
│   │   ├── checkpoint.dart
│   │   └── ride_status.dart
│   ├── repositories/
│   │   └── ride_repository.dart
│   └── use_cases/
│       ├── create_ride.dart
│       ├── join_ride.dart
│       ├── start_ride.dart
│       └── end_ride.dart
└── presentation/
    ├── screens/
    │   ├── create_ride_screen.dart
    │   ├── join_ride_screen.dart
    │   └── active_ride_screen.dart
    ├── widgets/
    │   ├── ride_panel.dart
    │   ├── rider_list.dart
    │   └── checkpoint_marker.dart
    └── providers/
        └── ride_providers.dart
```

### Ride Entity (Planned)

```dart
class Ride {
  final String id;
  final String leaderId;
  final String name;
  final String description;
  final RideStatus status;
  final List<String> memberIds;
  final List<Checkpoint> checkpoints;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final RideSettings settings;
  
  const Ride({
    required this.id,
    required this.leaderId,
    required this.name,
    required this.description,
    required this.status,
    required this.memberIds,
    required this.checkpoints,
    required this.createdAt,
    this.startedAt,
    this.endedAt,
    required this.settings,
  });
}

enum RideStatus {
  planned,
  recruiting,
  active,
  paused,
  completed,
  cancelled,
}

enum RideRole {
  leader,
  coLeader,
  rider,
}

### Core Ride Business Rules

1. **Join Anywhere / Anytime (`isJoinable`)**:
   - A ride is joinable as long as `status != RideStatus.completed` and `status != RideStatus.cancelled`.
   - Riders can join during `planned`, `recruiting`, `active`, and `paused` states.

2. **Ride Completion**:
   - **Leader Authority**: Leader has explicit "End Ride" action to transition status to `completed`.
   - **Smart Geofence Prompt**: System prompts leader when all active members are within destination geofence (~50m).

3. **Emergency Cancellation**:
   - Leader or Co-Leader can transition to `cancelled` from any state.
   - Instantly notifies all connected riders and halts active GPS session sharing for that ride.
```

### Map-Ride Separation

**Critical Rule:** The map displays ride information but knows nothing about ride logic.

```
Ride Feature                    Map Feature
─────────────                   ────────────
Ride state management    ──▶   Receives rider positions
Checkpoint logic         ──▶   Renders checkpoint markers
Leader election          ──▶   Highlights leader marker
Group synchronization    ──▶   Shows all rider markers
Route calculation        ──▶   Renders route polyline
```

---

## External Provider Strategy

### Maps

| Provider | Status | Implementation |
|----------|--------|----------------|
| `flutter_map` + OpenStreetMap | ✅ Current | `FlutterMapEngine` |
| Google Maps | 🔄 Planned | `GoogleMapsEngine` |
| Mapbox | 🔄 Planned | `MapboxEngine` |
| HERE Maps | 🔄 Planned | `HereMapsEngine` |

**Switching providers:** Implement new `MapEngine` - no application code changes.

### Location

| Provider | Status |
|----------|--------|
| `geolocator` | ✅ Current |
| Platform-specific GPS | 🔄 Future |
| Mock providers (testing) | 🔄 Future |
| Alternative GPS providers | 🔄 Future |

### Backend

| Service | Current | Future |
|---------|---------|--------|
| Authentication | Firebase Auth | - |
| Database | Cloud Firestore | Realtime Database |
| Messaging | - | Firebase Messaging |
| Functions | - | Cloud Functions |
| Storage | - | Firebase Storage |
| Analytics | - | Firebase Analytics |
| Crashlytics | - | Firebase Crashlytics |

---

## Design Goals

The RideTogether architecture should:

| Goal | Description |
|------|-------------|
| **Feature Isolation** | Features develop independently |
| **Provider Independence** | Swap maps, GPS, backend without rewrites |
| **Widget Simplicity** | Widgets render only - no business logic |
| **Map Independence** | Maps don't know about rides |
| **Location Independence** | Location doesn't know about maps |
| **Extensibility** | New ride capabilities build on map foundation |
| **Testability** | Domain layer 100% unit testable |
| **Maintainability** | Clear boundaries, single responsibilities |

---

## Development Roadmap

### Current Status: v0.3 — Map Experience Complete ✅

```
Application Foundation ✅
         │
         ▼
Authentication ✅
         │
         ▼
Rider Identity ✅
         │
         ▼
Map Foundation ✅
         │
         ▼
Map Experience ✅
         │
         ▼
Ride System 🔄 NEXT
         │
         ▼
Live Ride Experience
```

### Phase 1: Map Experience (v0.3) ✅

- [x] Map-first `HomeScreen` (no separate `MapScreen`)
- [x] Floating map controls (navbar with auto-hide, Recenter button, JoinRide pill)
- [x] Map modes (`idle`, `searchingRide`, `activeRide`, `navigation`, `completedRide`)
- [x] Camera state management via `mapControllerProvider` and `mapModeProvider`

### Phase 2: Ride Foundation (v0.4)

- [ ] Create Ride flow
- [ ] Join Ride flow
- [ ] Ride lifecycle management
- [ ] Rider roles (Leader, Co-Leader, Rider)

#### MVP Data Architecture & Decisions:
- **Ride Members List**: Typed as `members` (`List<RideMember>`). Stored as an embedded list inside the primary `rides/{rideId}` document for fast single-read operations.
  - *TODO (Post-MVP)*: Migrate to a dedicated subcollection (`rides/{rideId}/members`) when scaling to large event rides.
- **Member Profile Snapshot**: `RideMember` contains full `RiderProfile` for zero-join single-query reads.
  - *TODO (Post-MVP)*: Decouple to `riderId` references + dynamic profile stream/fetch if real-time profile syncing is needed.
- **Live Location Telemetry Subcollection**: Stored in `rides/{rideId}/locations/{userId}` for zero document write-lock contention.
  - *TODO (Scale Migration)*: Keep Firestore subcollections for MVP (100% free Spark plan). When scaling to 100+ concurrent riders per ride, migrate `RideRemoteDataSource` to Firebase Realtime Database (RTDB) or MQTT to eliminate $O(N^2)$ Firestore read fan-out costs while staying on Firebase free tiers.
- **Serialization Standard**: ISO-8601 strings used for all `DateTime` fields in `toMap()` / `fromMap()`.



### Phase 3: Live Ride Experience (v0.5)

- [ ] Rider synchronization
- [ ] Live location sharing
- [ ] Leader tracking
- [ ] Group map experience

### Phase 4: Production Release (v1.0)

- [ ] Stable Android/iOS release
- [ ] Motorcycle-focused group riding experience
- [ ] Performance optimization
- [ ] Safety features

---

## Future Architecture Direction

### Journey Platform (Post-MVP)

```
Journey (Shared Platform)
├── Ride (Follow the leader)
│   ├── Leader controls route
│   ├── Checkpoints
│   ├── Regroup commands
│   └── Group synchronization
│
└── Reach (Meet at destination)
    ├── Shared destination
    ├── Independent travel
    ├── Arrival tracking
    └── Participant progress
```

### Shared Journey Capabilities

- Members management
- Status tracking
- Notifications
- History
- Location sharing
- Communication

**Rule:** Do not build Journey abstraction before MVP completion.

### Ride Mode (Current MVP)

| Aspect | Description |
|--------|-------------|
| **Purpose** | Travel together |
| **Experience** | Follow the leader |
| **Capabilities** | Leader, Route control, Checkpoints, Regroup commands, Group sync |

### Reach Mode (Future)

| Aspect | Description |
|--------|-------------|
| **Purpose** | Meet at a destination |
| **Experience** | Everyone travels independently |
| **Capabilities** | Shared destination, Arrival tracking, Participant progress |

---

## Appendix: Key File Locations

| Purpose | Location |
|---------|----------|
| Application entry | `lib/main.dart` |
| App configuration | `lib/app/app.dart` |
| Routing | `lib/app/router/app_router.dart` |
| Route paths | `lib/app/router/app_routes.dart` |
| Theme system | `lib/core/theme/` |
| App lifecycle | `lib/core/providers/app_lifecycle_providers.dart` |
| Authentication | `lib/features/auth/` |
| Rider profile | `lib/features/profile/` |
| Startup/Splash | `lib/features/startup/` |
| Startup result | `lib/features/startup/domain/entities/startup_result.dart` |
| Map | `lib/features/map/` |
| Map floating controls | `lib/features/map/presentation/widgets/navbar/` |
| Location | `lib/features/location/` |
| Location required screen | `lib/features/location/presentation/screens/location_required_screen.dart` |
| Home screen | `lib/features/home/presentation/screens/home_screen.dart` |
| Ride (future) | `lib/features/ride/` |
| Firebase config | `lib/firebase_options.dart` |

---

*Document maintained by the RideTogether development team. Update after major milestones.*