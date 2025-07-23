
---

## ☁️ Feature: Cloud Upload (Firebase Storage)

This branch implements media uploading (images/videos) to the cloud using **Firebase Storage**. It is part of a modular Flutter app based on Clean Architecture and MVVM principles.

---

## 🎯 Purpose

To allow artists to upload their artwork media to the cloud, keeping the app lightweight and scalable without requiring a backend server.

---

## ✅ What’s Done in This Branch

* 🔌 Integrated Firebase Storage
* 📁 Created service: `firebase_cloud_storage_service.dart`
* 🧠 Created `UploadProvider` for managing upload state
* 🖼️ Built UI for uploading files via `upload_screen.dart`
* ✅ File picker and upload feedback
* 📦 `firebase_initializer.dart` for future Firebase scalability

---

## 📂 Code Structure

```plaintext
lib/
├── data/
│   └── cloud/
│       └── firebase_cloud_storage_service.dart    # Service to handle upload
├── providers/
│   └── upload_provider.dart                       # Upload state manager
├── services/
│   └── firebase_initializer.dart                  # Firebase initialization
├── screens/
│   └── artist/
│       └── upload_screen.dart                     # UI for artist to upload
```

---

## 🔧 How It Works

1. **User picks an image** from gallery via `image_picker`.
2. Image is passed to `UploadProvider`, which:

   * Updates UI state
   * Sends the file to Firebase using `FirebaseCloudStorageService`
   * Retrieves the download URL
3. URL is shown on screen.

---

## 💡 Why Firebase?

* ✅ No backend required
* ✅ Free up to 5GB on Spark Plan
* ✅ Fast integration with Flutter
* ✅ Easy to scale and switch if needed (e.g. Cloudinary)

---

## ⚠️ Limitation / Notes

* ❌ Firebase **Storage** requires a **billing plan upgrade** to allow uploads.
* ⚠️ Upload works **locally** but not fully functional unless billing is enabled.
* This branch is completed in structure, but currently **paused** due to billing issue.

---

## 📌 Next Steps

* Integrate `local_db` to cache metadata and media
* Use download URL to preview uploaded artwork
* Allow delete/edit functionality for artists

---

## 🧩 Related Branches

| Branch                 | Description                          |
| ---------------------- | ------------------------------------ |
| `feature/architecture` | Project structure and architecture   |
| `feature/i18n`         | Localization setup (AR/EN/FR)        |
| `feature/local_db`     | Local data storage using Hive/SQLite |

---

> 🔐 The Firebase credentials (google-services.json) are **not included** in this repo for security. You must provide your own config.

---
Let’s keep building. 💪

---
