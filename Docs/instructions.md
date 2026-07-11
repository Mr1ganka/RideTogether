# RideTogether - AI Development Instructions

Version: 1.2

# Project Overview

RideTogether is a mobile-first group ride management application designed for:

* Motorcycle riders
* Cyclists
* Road trips
* Convoys
* Adventure groups

The goal is not to replace Google Maps.

The goal is to add live group ride management on top of existing navigation services.

Think of it as:

Google Maps

*

Discord

*

Life360

*

Group Ride Management

into one application.

RideTogether should feel like a co-pilot for group rides.

---

# Core Philosophy

Every feature must answer one question:

> "Does this make riding in a group easier and safer?"

If the answer is no, do not build it.

The application should remain:

* Simple
* Fast
* Reliable
* Safe
* Distraction-free

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

✅ Centralized design system created

✅ Material 3 theme foundation created

✅ MaterialApp.router navigation implemented

✅ GoRouter route configuration created

✅ Splash screen flow implemented

✅ Login screen placeholder created

✅ Home screen placeholder created

✅ Application navigation flow verified

✅ Application name updated

✅ Application launcher icon updated

---

# Current Application Structure

Application startup:

Android

↓

lib/main.dart

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


## Current Files

lib/

main.dart

Responsible for:

* Application startup
* Flutter initialization
* Global dependency initialization
* Riverpod ProviderScope setup


app/

app.dart

Responsible for:

* MaterialApp.router configuration
* Theme configuration
* Routing configuration
* Application-level settings


app/router/

Responsible for:

* Application route definitions
* Navigation configuration
* Route management

Files:

* app_router.dart
* app_routes.dart

---

# Architecture Rules

RideTogether uses:

* Flutter
* Riverpod
* Feature-first architecture
* Repository pattern
* Strong typing
* Null safety

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

* Focus on UI rendering
* Be reusable
* Avoid business logic

Avoid:

* Firebase calls inside widgets
* API calls inside widgets
* Complex calculations inside widgets

Business logic belongs outside widgets.

---

# Centralized Design System

RideTogether uses a centralized design token system.

Location:

lib/core/themes/

All UI styling should use the design system.

Do not create random styling values inside widgets.

The design system contains:

## Colors

File:

app_colors.dart

Rules:

* Never hardcode colors
* Use semantic color names

Example:

```dart
AppColors.primary