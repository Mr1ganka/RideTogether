# RideTogether In-App Sideload Updates Guide

This guide documents the in-app update mechanism for **RideTogether**, enabling direct APK sideloading updates from **GitHub Releases** using **Firestore** as the configuration bus.

---

## 🏗️ Architecture

```
+------------------+         1. Fetch version info        +-----------------------+
|  Flutter App     | -----------------------------------> | Firestore             |
|  (AppUpdateCheck)| <----------------------------------- | (app_config/version)  |
+------------------+     {version, url, update_type}      +-----------------------+
         |
         | 2. If update required
         v
+------------------+     3. Download APK & Install        +-----------------------+
|  UpdateDialog /  | -----------------------------------> | GitHub Releases       |
|  Silent Pre-fetch| <----------------------------------- | (app-release.apk)     |
+------------------+                                      +-----------------------+
```

---

## 📄 Firestore Document Schema

Document Path: `app_config/version`

```json
{
  "latest_version": "1.0.1",
  "min_supported_version": "1.0.0",
  "build_number": 2,
  "download_url": "https://github.com/YourUsername/RideTogether/releases/download/v1.0.1/app-release.apk",
  "release_notes": "• New real-time ride tracking feature\n• Performance optimizations and bug fixes",
  "update_type": "optional", 
  "sha256": null
}
```

### Supported Update Types (`update_type`)
* `"optional"`: Displays an update dialog with "Later" and "Update Now" buttons.
* `"mandatory"`: Displays a non-dismissible screen requiring the user to update to proceed.
* `"silent"`: Pre-downloads the APK in the background while the user continues using the app, displaying a toast when ready to install.

---

## 📌 TODO: GitHub Actions CI/CD Workflow

> **TODO**: Set up automated GitHub Actions workflow (`.github/workflows/release.yml`) to automatically:
> 1. Trigger when a git tag like `v*.*.*` is pushed.
> 2. Build the Flutter release APK (`flutter build apk --release`).
> 3. Create a GitHub Release with the tag name.
> 4. Upload `app-release.apk` to the Release Assets.
> 5. Update the Firestore `app_config/version` document via Firebase Admin SDK with the new download link and version number.

---

## 🚀 Manual Release Workflow (Current)

Until the CI/CD workflow is set up:

1. **Build the Release APK**:
   ```bash
   flutter build apk --release --build-name=1.0.1 --build-number=2
   ```

2. **Publish on GitHub Releases**:
   - Go to your GitHub repository -> Releases -> Create a new release.
   - Tag: `v1.0.1`
   - Attach file: `build/app/outputs/flutter-apk/app-release.apk`

3. **Update Firestore**:
   - Open Firebase Console -> Firestore -> Collection `app_config` -> Document `version`.
   - Update `latest_version` to `"1.0.1"`, `build_number` to `2`, and paste the GitHub Release APK asset link in `download_url`.
