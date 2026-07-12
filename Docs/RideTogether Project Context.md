# BROKEN NEED TO FIX THIS AGAIN
## RideTogether Project Context

Version: 1.5

Last Updated:
2026-07-13

---

# Purpose of This Document

This document is the primary context file for RideTogether.

It exists so that any developer or AI assistant can understand:

- What RideTogether is
- Why the project exists
- Current implementation status
- Project architecture
- Important file locations
- Development rules
- Current priorities
- Future direction

Before making changes, read this document first.

This document should evolve with the project.

Whenever a major feature is completed:

- Update the current status
- Update architecture changes
- Update important file locations
- Update the next development priorities

Do not allow this file to become outdated.

---

# Product Overview

RideTogether is a mobile-first group ride management application.

Target users:

- Motorcycle riders
- Cyclists
- Road trip groups
- Convoys
- Adventure groups

RideTogether is not a replacement for navigation applications.

Navigation applications answer:

"How do I get there?"

RideTogether answers:

"How do we get there together?"

The application adds a coordination layer on top of navigation services.

Core capabilities:

- Group ride management
- Rider identity
- Rider synchronization
- Live rider locations
- Communication
- Safety features
- Ride organization

The product goal:

Make group riding easier, safer, and more connected.

Every feature must answer:

> Does this make riding in a group easier or safer?

If not, it should not be built.

---

# Product Principles

RideTogether should remain:

- Simple
- Fast
- Reliable
- Safe
- Distraction-free

Important principles:

- The map becomes the primary experience.
- Riders should interact with the app as little as possible while riding.
- Controls should be usable with gloves.
- Battery usage must be considered.
- Network usage must be optimized.
- Safety takes priority over unnecessary features.

---

# Current Development Status

## Current Version