# RideTogether In-App Sideload Updates Guide

This guide documents the in-app update mechanism for **RideTogether**, enabling direct APK sideloading updates from **GitHub Releases** using **Firestore** as the configuration bus.

---

## 🏗️ Architecture & Component Flow

```
+------------------+         1. Fetch version info        +-----------------------+
|  Flutter App     | -----------------------------------> | Firestore             |
|  (AppUpdateCheck)| <----------------------------------- | (app_config/version)  |
+------------------+     {version, url, update_type}      +-----------------------+
         |
         | 2. If update required
         v
+------------------+     3. Download APK & Install        +-----------------------+
| NotchUpdateBanner| -----------------------------------> | GitHub Releases       |
|  / UpdateDialog  | <----------------------------------- | (app-release.apk)     |
+------------------+                                      +-----------------------+
```

### Key UI Features
* **Notch-Aligned Hardware Pill**: Automatically reads `MediaQuery.of(context).padding.top` to align directly around camera cutouts and Dynamic Islands.
* **Interactive Expand/Minimize**:
  * Tapping **"Later"** minimizes the banner into a compact top notch capsule.
  * Tapping **anywhere on the minimized notch pill** expands it back to the full banner.
  * Tapping the version badge or release notes opens the full `UpdateDialog` modal.
* **Live Progress Bar**: Displays real-time download percentage inside the banner while fetching the `.apk`.
* **System Theme Adaptability**: Uses `Theme.of(context)` system tokens (`colorScheme.surface`, `primary`, `onSurface`, etc.) adapting dynamically to Light and Dark modes.
* **Android Settings Auto-Resume**: Uses `WidgetsBindingObserver` to automatically re-launch the APK installer when returning from Android System Settings (*"Allow from this source"*).

---

## 📄 Firestore Document Schema

Document Path: `app_config/version`

```json
{
  "latest_version": "1.0.1",
  "min_supported_version": "1.0.0",
  "build_number": 2,
  "download_url": "https://github.com/Mr1ganka/RideTogether/releases/download/v1.0.1/app-release.apk",
  "release_notes": "• Added real-time ride tracking\n• Added notch update banner",
  "update_type": "optional", 
  "sha256": null
}
```

### Supported Update Types (`update_type`)
* `"optional"`: Displays the `NotchUpdateBanner` (on notched phones) or `UpdateDialog` with "Later" and "Update Now" buttons.
* `"mandatory"`: Displays a non-dismissible screen requiring the user to update before using the app.
* `"silent"`: Pre-downloads the APK in the background while the user continues using the app, displaying a toast when ready to install.

---

## 📌 TODO: GitHub Actions CI/CD Workflow

> **TODO**: Set up automated GitHub Actions workflow (`.github/workflows/release.yml`) to automatically:
> 1. Trigger when a git tag like `v*.*.*` is pushed to GitHub.
> 2. Build the Flutter release APK (`flutter build apk --release`).
> 3. Create a GitHub Release on repository `Mr1ganka/RideTogether` with the tag name.
> 4. Upload `app-release.apk` to the Release Assets.
> 5. Update the Firestore `app_config/version` document via Firebase Admin SDK with the new download link and version number.

---

## 🚀 Manual Release Workflow (Current)

Until the CI/CD workflow is set up:

1. **Bump Version**: Update `version: 1.0.1+2` in `pubspec.yaml`.
2. **Build the Release APK**:
   ```bash
   flutter build apk --release
   ```
3. **Publish on GitHub Releases**:
   - Go to [GitHub Releases](https://github.com/Mr1ganka/RideTogether/releases/new).
   - Create tag `v1.0.1`.
   - Attach file: `build/app/outputs/flutter-apk/app-release.apk`.
4. **Update Firestore**:
   - Open Firebase Console -> Firestore -> Collection `app_config` -> Document `version`.
   - Update `latest_version` to `"1.0.1"`, `build_number` to `2`, and paste the GitHub Release APK asset link in `download_url`.
