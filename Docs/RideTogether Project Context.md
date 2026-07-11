# RideTogether Project Context


## Project Name

RideTogether


---

# Project Goal


RideTogether is a mobile-first group ride management application designed for:


- Motorcycle riders
- Cyclists
- Road trips
- Convoys
- Adventure groups


The goal is not to replace Google Maps.


The goal is to add live group ride management on top of Google Maps.


Concept:


Google Maps

+

Discord

+

Life360

+

Group Ride Management


The app should feel like a co-pilot for group rides.


Core question for every feature:


"Does this make riding in a group easier and safer?"


If not, do not build it.



---

# Current Development Status


## Current Version

v0.0.1 — Foundation Setup


## Environment


Completed:


- Flutter SDK installed
- VS Code configured
- Android SDK Command Line Tools installed
- Java 17+ installed
- Android Platform Tools installed
- Android Build Tools installed
- Flutter doctor passing for Android development


Current environment:


- Windows 10 Pro 64-bit
- Flutter stable channel
- Android physical device available for testing
- OnePlus 12 verified



---

# Completed Development


## Application Foundation


Completed:


✅ Flutter project created

✅ Android build verified

✅ Physical device testing verified

✅ Default Flutter counter app removed

✅ RideTogether application shell created

✅ Centralized design system created

✅ Material 3 theme foundation created

✅ Light and dark theme support created

✅ Application name updated

✅ Application launcher icon updated

✅ GoRouter navigation implemented

✅ Splash screen flow implemented

✅ Login screen placeholder created

✅ Home screen placeholder created

✅ Application navigation flow verified


Application flow:


Android Device

↓

main.dart

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

LoginScreen

↓

HomeScreen



---

# Current Architecture


Architecture:


- Feature-first architecture
- Repository pattern
- Riverpod state management
- Strong typing
- Null safety
- Immutable models where possible


Rules:


- No business logic inside widgets
- Providers manage application state
- Repositories handle data access
- Services handle external systems



---

# Current Folder Structure


lib/


app/


Application configuration


core/


config/


services/


themes/


utils/


features/


auth/


profile/


home/


map/


ride/


navigation/


checkpoints/


chat/


hazards/


notifications/


history/


settings/


shared/


models/


widgets/



---

# Technology Stack


## Mobile


Flutter


Reasons:


- Android and iOS support
- Single codebase
- Strong Firebase ecosystem
- Google Maps support



---

## State Management


Riverpod


Rules:


- No business logic inside widgets
- Avoid setState for application state
- Features expose providers
- Keep state predictable and testable



---

## Architecture


Feature-first architecture.


Each feature should contain:


data/


- models
- repositories
- datasources


domain/


- entities
- usecases


presentation/


- screens
- widgets
- providers



---

# Backend


Firebase ecosystem:


- Firebase Authentication
- Cloud Firestore
- Realtime Database
- Cloud Functions
- Firebase Messaging
- Firebase Storage
- Crashlytics
- Analytics



---

# Maps


Google services:


- Google Maps SDK
- Google Directions API
- Google Places API
- Google Geocoding API


Google Maps handles:


- Map rendering
- Navigation
- Directions
- Places


RideTogether handles:


- Rider groups
- Live locations
- Ride synchronization
- Checkpoints
- Communication
- Safety features



---

# Main User Roles


## Leader


Can:


- Create rides
- Manage checkpoints
- Change destination
- Reroute riders
- Start rides
- End rides



## Co-Leader


Can:


- Manage rides if leader disconnects



## Sweep Rider


Last rider in formation.


Receives:


- Rider behind alerts
- Safety notifications



## Participant


Can:


- Follow rides
- Share location
- Receive updates



---

# Core Features


## Authentication


- Google Login
- Apple Login
- Email Login



## Ride Creation


- Ride name
- Destination
- Departure time
- Visibility
- Invite code
- QR code
- Share link



## Live Ride


Map-first experience:


- Google Map
- Rider locations
- Leader position
- Destination
- ETA
- Distance
- Heading
- Speed
- Status
- Battery level
- Offline status



## Navigation


Leader changes route.


Followers receive:


"Leader updated the route"


Actions:


- Navigate
- Dismiss



## Checkpoints


Types:


- Fuel stop
- Breakfast
- Lunch
- Photo stop
- Scenic view
- Rest stop
- Custom



## Ride Chat


Includes:


- Messages
- Location sharing
- Quick actions


Quick actions:


- Running late
- Need fuel
- Mechanical issue
- Emergency



## Rider Status


States:


- Moving
- Stopped
- Offline
- Off route
- Low battery
- Emergency



## Smart Notifications


Events:


- Leader changed route
- Checkpoint reached
- Rider stopped
- Rider left ride
- Rider joined
- Ride starting
- Ride ending



---

# Future Features


- Crash Detection
- Ride Replay
- Offline Maps
- GPX Import
- Voice Announcements
- Weather
- Road Hazards
- Club Management
- Ride Analytics
- Achievements
- Wear OS
- Apple Watch
- Android Auto
- CarPlay



---

# UI Philosophy


Dark mode first, with light mode available through the device appearance
setting.


Design goals:


- Large buttons
- Minimal text
- Glove friendly
- Few taps while riding
- Map is always the primary screen



Design language:


Primary:

Royal Blue


Accent:

Orange


Danger:

Red


Success:

Green


Dark:

#121212


Light:

#F8F9FC


Components:


- Rounded cards
- Large floating action buttons
- Icons over text wherever possible



---

# Main Map Screen


Top:


- Ride name
- Ride status
- Time
- Leader


Center:


- Full screen Google Map


Floating buttons:


- Navigate
- Regroup
- Chat
- Hazards
- Layers


Bottom sheet:


- Next checkpoint
- ETA
- Distance remaining
- Ride members



---

# Data Architecture


## Firestore


Long-lived data:


Collections:


- users
- rides
- rideMembers
- checkpoints
- messages
- hazards



## Realtime Database


Fast changing data:


- liveLocations
- ridePresence



---

# Services Layer


Required services:


- LocationService
- PermissionService
- RideService
- ChatService
- NotificationService
- NavigationService
- HazardService
- StorageService
- AnalyticsService
- CrashDetectionService



---

# Repository Layer


Repositories:


- AuthRepository
- RideRepository
- MapRepository
- LocationRepository
- ChatRepository
- HistoryRepository
- UserRepository
- NotificationRepository



---

# Development Order


Completed:


1. Project architecture setup

2. Theme system setup

3. Application routing setup


Current:


4. Authentication foundation


Next:


5. Firebase setup

6. Firebase Authentication

7. User profile

8. Home screen implementation

9. Google Maps integration

10. Ride creation

11. Joining rides

12. Live location tracking

13. Real-time rider markers

14. Navigation updates

15. Checkpoints

16. Chat

17. Notifications

18. History

19. Testing

20. Performance optimization



---

# Coding Rules


Always:


- Keep business logic outside widgets
- Use repositories for external APIs
- Use providers for state
- Prefer composition
- Write reusable components
- Write tests for business logic
- Optimize battery usage
- Optimize Firestore reads
- Avoid unnecessary rebuilds



---

# Current Next Task


Continue with foundation development.


Next milestone:


## Authentication Foundation


Create:


features/auth/


Goal:


Create the authentication architecture before integrating Firebase.


Required foundation:


- Auth provider
- Auth state model
- Authentication repository structure
- Login flow integration with routing



---

# Product Vision


Become the default application for organized group rides.


Not just navigation.


Not just tracking.


The operating system for group riding.