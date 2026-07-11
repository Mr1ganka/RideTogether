# RideTogether Architecture

Version: 1.2

---

# Overview

RideTogether is a real-time group ride management platform.

The application is designed as a companion layer on top of navigation services.

Google Maps is responsible for:

* Map rendering
* Navigation
* Directions
* Places
* Geographical services

RideTogether is responsible for:

* Group management
* Rider synchronization
* Live rider locations
* Communication
* Checkpoints
* Safety features
* Smart ride features

The architecture is designed to be:

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

v0.0.1 — Foundation Setup

## Completed

✅ Flutter application created

✅ Android environment configured

✅ Physical device testing verified

✅ Feature-first directory structure created

✅ Riverpod integrated

✅ GoRouter integrated

✅ Google Fonts integrated

✅ Application shell created

✅ Centralized theme system created

✅ Application routing implemented

✅ Splash screen flow implemented

✅ Login screen placeholder created

✅ Home screen placeholder created

✅ Application navigation flow verified

✅ Application name updated

✅ Application launcher icon updated

## Current Application Flow

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

# Application Entry Layer

## main.dart

Location:

lib/main.dart

Responsibilities:

* Application startup
* Flutter initialization
* Global dependency initialization
* ProviderScope setup
* Launching the application

main.dart should remain lightweight.

It should not contain:

* Business logic
* API calls
* Firebase logic
* Feature logic

---

## app.dart

Location:

lib/app/app.dart

Responsibilities:

* MaterialApp.router configuration
* Global application configuration
* Theme configuration
* Routing configuration
* Application-wide settings

The app layer connects the application foundation with features.

Current application flow:

MaterialApp.router

↓

AppRouter

↓

Application Routes

↓

Feature Screens

---

# Navigation Architecture

RideTogether uses GoRouter for application navigation.

Location:

lib/app/router/

Files:

* app_router.dart
* app_routes.dart

Current navigation flow:

Application Launch

↓

SplashScreen

↓

LoginScreen

↓

HomeScreen

Current splash behavior:

* Application starts on SplashScreen
* SplashScreen displays RideTogether branding
* SplashScreen waits for 2 seconds
* User proceeds to LoginScreen
* Login action navigates to HomeScreen

Future navigation behavior:

SplashScreen will evaluate application state.

Authenticated user:

SplashScreen

↓

HomeScreen


Unauthenticated user:

SplashScreen

↓

LoginScreen

---

# Technology Stack

## Mobile

Flutter

Reasons:

* Android and iOS support
* Single codebase
* Strong ecosystem
* Google Maps compatibility
* Firebase integration

---

## State Management

Riverpod

Responsibilities:

* Application state
* Feature state
* Dependency injection
* Reactive updates

Rules:

* Widgets should not contain business logic
* Providers expose state
* Providers communicate with repositories
* State should be predictable and testable

---

## Backend

Firebase ecosystem:

* Authentication
* Cloud Firestore
* Realtime Database
* Cloud Functions
* Firebase Messaging
* Storage
* Crashlytics
* Analytics

---

## Maps

Google services:

* Google Maps SDK
* Google Directions API
* Google Places API
* Google Geocoding API

---

# Design System Architecture

RideTogether uses a centralized design token system.

Location:

lib/core/themes/

The design system separates visual values from UI implementation.

The design system contains:

## Colors

File:

app_colors.dart

Responsibilities:

* Brand colors
* Application colors
* Status colors
* Map-related colors

Colors are accessed through semantic names.

Example:

AppColors.primary

---

## Typography

File:

app_text_styles.dart

Responsibilities:

* Font family
* Font sizes
* Font weights
* Letter spacing

Typography does not define colors.

Colors are applied through AppTheme.

---

## Spacing

File:

app_spacing.dart

Responsibilities:

* Layout spacing values
* Screen padding values
* Component spacing

Spacing values should replace hardcoded layout numbers.

---

## Radius

File:

app_radius.dart

Responsibilities:

* Border radius system
* Component shapes
* Rounded UI elements

All rounded components should use the centralized radius system.

---

## Shadows

File:

app_shadows.dart

Responsibilities:

* Elevation shadows
* Floating surfaces
* Overlay depth

Shadows are kept subtle because RideTogether uses a dark-first interface.

---

## Animation Durations

File:

app_durations.dart

Responsibilities:

* Animation timing
* Transition speeds
* Interaction feedback

All animations should use centralized durations.

---

## Theme Composition

File:

app_theme.dart

Responsibilities:

* Combines design tokens
* Creates Flutter ThemeData
* Configures Material 3
* Defines application-wide component styling

Architecture flow:

Design Tokens

↓

AppTheme

↓

MaterialApp

↓

Application UI

### Color modes

`AppTheme` provides separate Material 3 light and dark `ThemeData` instances.

`MaterialApp` uses `ThemeMode.system`, so it follows the device preference:

* `theme`: the light palette, including light surfaces, dark text, and subtle dividers
* `darkTheme`: the existing dark-first palette

Shared brand and status colors remain consistent between modes. Widgets should continue to use `Theme.of(context)` for colors and typography so they adapt automatically when the system appearance changes.

---

# High Level Architecture