# 📁 Feature: Architecture Setup

This branch establishes the foundation and folder structure for the Flutter Art Gallery application. It is focused on preparing a scalable, modular, and maintainable architecture following a simplified version of Clean Architecture principles.

---

## 🎯 Purpose of this Branch

To organize the codebase before development begins by:

* Separating concerns (UI, logic, services, models, etc.)
* Creating folders and placeholder files for each component
* Making the project easier to navigate and collaborate on
* Preparing for future scalability (multilingual, cloud, local DB...)

---

## 📂 Folder Structure Overview

```plaintext
/lib
├── main.dart                      # Entry point
├── app.dart                       # Root widget with MaterialApp
├── config/                        # Theme, styles, app assets
├── localization/                 # Language switching logic
├── router/                        # App navigation setup
├── screens/                      # UI: divided by user type
│   ├── artist/                   # Artist interface
│   └── visitor/                  # Visitor interface
├── models/                       # Data models (User, Artwork, etc.)
│   └── enums/                    # Enum values (categories...)
├── data/                         # Concrete local/cloud sources
│   ├── cloud/                    # Cloud sources (e.g., Firebase)
│   └── local/                    # Local sources (Hive, SQLite...)
├── services/                     # Shared service helpers (optional)
├── repository/                   # Abstractions over services
├── providers/                    # State management logic
├── widgets/                      # Reusable UI widgets
└── utils/                        # Helpers and constants

---

## 🧠 Why This Structure?

* ✅ **Clean Separation:** Presentation, logic, and data are split
* ✅ **Scalability:** Easy to expand and maintain
* ✅ **Reusable Components:** Widgets and services are modular
* ✅ **Performance:** Lazy loading and separation improves speed
* ✅ **Professional Practice:** Follows industry structure for Flutter

---

## 🧱 Next Steps After This Branch

* Implement localization logic in `feature/i18n`
* Setup cloud media uploads in `feature/cloud_upload`
* Add local DB logic in `feature/local_db`
* Start building UI for both `artist` and `visitor` under `screens/`

---

## ✅ Completed in This Branch

* Created full folder structure
* Added placeholder files for every module
* Defined structure to host Clean Architecture logic

---

## 📌 Notes

> This application does **not rely on a backend server**. All artist data is stored locally, while images and videos are uploaded to the cloud (e.g., Cloudinary) to keep the app lightweight and fast.

---

## 📖 Related Branches

* `feature/i18n`: Handles multilingual setup
* `feature/cloud_upload`: Media upload to cloud
* `feature/local_db`: Storing data locally
* `dev`: Integrating all features progressively

---

Ready to build on this solid base! 🚀
