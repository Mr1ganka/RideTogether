# RideTogether - AI Development Instructions


# Project Overview


RideTogether is a mobile-first group ride management application designed for:

- Motorcycle riders
- Cyclists
- Road trips
- Convoys
- Adventure groups


The goal is not to replace Google Maps.


The goal is to add live group ride management on top of existing navigation services.


Think of it as:


Google Maps

+

Discord

+

Life360

+

Group Ride Management


into one application.


RideTogether should feel like a co-pilot for group rides.



---

# Core Philosophy


Every feature must answer one question:


> "Does this make riding in a group easier and safer?"


If the answer is no, do not build it.


The application should remain:

- Simple
- Fast
- Reliable
- Safe
- Distraction-free


No feature should require unnecessary interaction while riding.


The map is always the primary experience.



---

# Current Development Status


## Version

v0.0.1 — Application Foundation


## Completed


✅ Flutter project created

✅ Android development environment configured

✅ OnePlus 12 physical device testing verified

✅ Feature-first folder architecture created

✅ Riverpod added

✅ GoRouter added

✅ Google Fonts added

✅ Default Flutter counter application removed

✅ RideTogether application shell created


## Current Application Structure


Application startup:


Android

↓

lib/main.dart

↓

ProviderScope

↓

RideTogetherApp

↓

MaterialApp

↓

Application UI



## Current Files


lib/


main.dart

Responsible for:

- Application startup
- Flutter initialization
- Global dependency initialization
- Riverpod ProviderScope setup


app/


app.dart

Responsible for:

- MaterialApp configuration
- Theme configuration
- Routing configuration
- Application-level settings



---

# Architecture Rules


RideTogether uses:


- Flutter
- Riverpod
- Feature-first architecture
- Repository pattern
- Strong typing
- Null safety


Architecture principle:


Widgets display information.

Providers manage state.

Repositories manage application data.

Services communicate with external systems.



Flow:


UI Widgets

↓

Riverpod Providers

↓

Repositories

↓

Services

↓

External Systems



Examples:


UI

↓

RideProvider

↓

RideRepository

↓

Firebase



UI

↓

LocationProvider

↓

LocationRepository

↓

GPS Service



---

# Folder Structure


Current structure:


lib/


app/

Application-level configuration


core/

Shared application infrastructure


config/

Environment and configuration


services/

External integrations


themes/

Application styling


utils/

Common helpers


features/

Feature modules


shared/

Reusable components and models



Feature structure:


feature/


data/

models/

repositories/

datasources/


domain/

entities/

usecases/


presentation/

screens/

widgets/

providers/



---

# Coding Rules


## Widgets


Widgets should:

- Focus on UI rendering
- Be reusable
- Avoid business logic


Avoid:

- Firebase calls inside widgets
- API calls inside widgets
- Complex calculations inside widgets


Business logic belongs outside widgets.



---

# State Management


Technology:


Riverpod


Rules:


- Do not use global mutable variables
- Avoid unnecessary StatefulWidget usage
- Application state belongs in providers
- Providers expose feature state


Examples of provider state:


Authentication:

authProvider


Current ride:

rideProvider


Location:

locationProvider


Chat:

chatProvider



Use StatefulWidget only for local UI state:


Examples:

- Animations
- Password visibility
- Temporary UI toggles
- Controllers


Do not use StatefulWidget for:


- User data
- Ride data
- GPS state
- Firebase data



---

# Navigation


Technology:


GoRouter


Routing should handle:


- Splash screen
- Authentication state
- Protected routes
- Main application flow



Expected flow:


Splash

↓

Authentication Check

↓

Login

↓

Home Map



---

# Main User Roles


## Leader


Can:

- Create rides
- Manage checkpoints
- Change destinations
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

- Join rides
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


- Google Maps
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


Uses:

- Google Maps SDK
- Google Directions API


Leader actions:

- Change route
- Update destination


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

# Data Models


Primary models:


- User
- Ride
- RideMember
- Checkpoint
- ChatMessage
- Hazard
- RideHistory
- Notification
- Club
- Achievement



---

# Performance Requirements


The application must:


- Minimize battery usage
- Optimize GPS frequency
- Avoid unnecessary rebuilds
- Minimize Firestore reads
- Handle poor network conditions


Location updates target:


Every 3-5 seconds during active rides.



Background tracking should only run when required.



---

# Security Rules


Users should only access rides they belong to.


Location sharing:


- Starts when ride begins
- Ends when ride completes


Never expose sensitive backend credentials.


Validate all backend writes.



---

# UI Philosophy


Dark mode first.


Design goals:


- Large buttons
- Minimal text
- Glove friendly
- Few taps while riding
- Map-first experience


Avoid:

- Small controls
- Dense screens
- Excessive menus



---

# Design Language


Primary:

Royal Blue


Accent:

Orange


Danger:

Red


Success:

Green


Dark Background:

#121212



Components:


- Rounded cards
- Large floating action buttons
- Icons over text where possible



---

# Main Map Screen


Layout:


Top:


- Ride name
- Ride status
- Time
- Leader



Center:


Full screen Google Map



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

# Product Principles


RideTogether should be:


Fast.

Reliable.

Safe.

Simple.

Fun.


The application should feel like it was built by riders, for riders.