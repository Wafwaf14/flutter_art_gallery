# 🌍 Feature: Internationalization (i18n)

This branch introduces full internationalization support to the Flutter Art Gallery app using [`easy_localization`](https://pub.dev/packages/easy_localization).

## ✅ Features Implemented

- Language switching (English 🇬🇧, Arabic 🇸🇦, French 🇫🇷)
- JSON-based translation files
- `MaterialApp` fully localized
- RTL support for Arabic
- Reusable language switcher widget

---

## 📁 Folder Structure

```bash
lib/
├── app.dart                   # Main app widget
├── main.dart                  # Entry point with EasyLocalization
├── screens/
│   └── home/
│       └── home_page.dart     # Home page with localized text
├── widgets/
│   └── language_switcher.dart # Dropdown to change app locale
assets/
└── lang/
    ├── en.json                # English strings
    ├── ar.json                # Arabic strings
    └── fr.json                # French strings
