# RideTogether AI Development Instructions

Version: 1.3

---

# Project Overview

RideTogether is a mobile-first group ride management application designed for:

- Motorcycle riders
- Cyclists
- Road trips
- Convoys
- Adventure groups

RideTogether is not a replacement for navigation applications.

The purpose of RideTogether is to add a group management layer on top of existing navigation services.

The application provides:

- Group ride management
- Rider synchronization
- Live rider locations
- Communication
- Safety features
- Ride coordination

RideTogether should feel like a co-pilot for group rides.

---

# Core Philosophy

Every feature must answer:

"Does this make riding in a group easier or safer?"

If the answer is no, do not build it.

The application should remain:

- Simple
- Fast
- Reliable
- Safe
- Distraction-free

The map is the primary experience.

Features should minimize interaction while riding.

---

# Current Development Status

## Version

v0.0.2 — Authentication Foundation


## Completed

### Application Foundation

- Flutter project created
- Android environment configured
- Physical device testing completed
- Feature-first architecture created
- Riverpod integrated
- GoRouter integrated
- Google Fonts integrated
- Application shell created
- Material 3 theme foundation created
- Light and dark theme support implemented
- Splash screen implemented
- Login screen implemented
- Home screen implemented


### Firebase Foundation

- Firebase project created
- Firebase Android application configured
- FlutterFire CLI configured
- Firebase initialization completed


### Authentication

- Authentication repository architecture created
- Google Sign-In implemented
- Firebase Authentication implemented
- AppUser domain model created
- Login flow implemented
- Logout flow implemented


---

# Application Architecture

RideTogether uses:

- Flutter
- Riverpod
- GoRouter
- Feature-first architecture
- Repository pattern
- Strong typing
- Null safety


Architecture rules:

Widgets display information.

Providers manage state.

Repositories manage application data.

Services communicate with external systems.


The architecture flow:

UI

↓

Riverpod Providers

↓

Repositories

↓

Services

↓

External Systems


Example:

Login Screen

↓

Auth Provider

↓

Auth Repository

↓

Firebase Authentication


---

# Application Structure

Current structure:

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


Feature structure:

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


---

# Android Application Identity

Current Android identity:

Package:

com.ridetogether.app


Namespace:

com.ridetogether.app


Application ID:

com.ridetogether.app


Do not change these values without updating:

- Firebase Android configuration
- google-services.json
- MainActivity package
- Gradle namespace
- Gradle applicationId


---

# Coding Rules

## Widgets

Widgets should only handle UI rendering.

Widgets should:

- Display information
- Receive state
- Trigger user actions


Widgets should not contain:

- Firebase calls
- API calls
- Business logic
- Data processing


Business logic belongs in:

- Providers
- Repositories
- Services


---

# Riverpod Rules

Riverpod manages:

- Application state
- Feature state
- Dependency injection
- Reactive updates


Rules:

- Widgets consume providers
- Providers communicate with repositories
- Repositories communicate with services


---

# Repository Rules

Repositories separate application logic from external systems.


Example:

AuthRepository

↓

FirebaseAuthRepository

↓

Firebase


Features should depend on repository abstractions rather than directly accessing external services.


---

# Design System Rules

All UI styling must use:

lib/core/themes/


The design system controls:

- Colors
- Typography
- Spacing
- Radius
- Shadows
- Animations
- Component styling


Do not:

- Hardcode colors
- Add random spacing values
- Create feature-specific theme systems


Use Flutter theme values:

Theme.of(context)


---

# Current Development Priorities

Development order:

1. Stabilize authentication
2. Improve application shell
3. Implement map foundation
4. Create Ride feature
5. Add live location tracking
6. Add group synchronization


---

# Future Journey Architecture

RideTogether currently focuses only on Ride mode.

Reach is a future feature.

Do not implement Reach during MVP.


Future architecture:

Journey

- Ride
- Reach


A Journey represents a shared group movement activity.


---

# Shared Journey Capabilities

Future shared Journey functionality may include:

- Members
- Destination
- Location tracking
- Map visualization
- Status
- Notifications
- Chat
- Events
- History


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

- Leader
- Route control
- Checkpoints
- Regroup commands
- Group synchronization


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

- Shared destination
- Individual navigation
- Arrival tracking
- Participant progress


Example:

"Everyone meet at this café."


---

# Future Journey Domain

Future Journey model:

- id
- creatorId
- destination
- members
- status
- type


Journey types:

- Ride
- Reach


Mode-specific behavior should extend Journey.

Do not duplicate:

- Membership
- Location tracking
- Status handling
- Notifications
- Chat
- History


---

# Future Feature Direction

Do not restructure the current project for Reach.

After MVP completion, future Journey functionality may be organized as:

features/

journey/

data/

domain/

presentation/


Reach should only be implemented after current MVP priorities are complete.