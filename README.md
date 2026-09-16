# 🌤️ Weather App

A modern, responsive weather forecast application built with **Flutter** and **Dart**. The app provides real-time atmospheric updates, dynamic weather alerts, hourly forecasts, and seamless city search using RESTful APIs and clean architecture patterns.

---

## ✨ Features

- **Live Weather Updates:** Real-time temperature, condition metrics, humidity, wind speed, pressure, and visibility based on current GPS location.
- **Hourly & Weekly Forecast:** Detailed weather timeline breakdowns to plan ahead.
- **Dynamic City Search:** Fast search functionality to check live weather across global locations.
- **Persistent Preferences:** Local caching of user settings and session states powered by `shared_preferences`.
- **Modern UI / UX:** Glassmorphism accents, smooth bottom navigation, and fully responsive layouts.

---

## 🛠️ Tech Stack & Architecture

- **Framework:** Flutter (Dart)
- **State Management:** Provider
- **Networking:** HTTP / RESTful APIs
- **Storage:** `shared_preferences` (Local key-value persistence)
- **Location Services:** `geolocator`
- **Architecture:** Feature-first layered structure (Presentation, Data, Domain, Core)

---

## 📁 Project Structure

```text
lib/
├── core/
│   ├── theme/          # App colors, typography, and theme styling
│   └── widgets/        # Reusable global widgets (Backgrounds, CustomNavBar)
├── features/
│   ├── home/           # Weather overview, live cards, and forecasts
│   ├── search/         # City search and location query handling
│   └── forecast/       # Multi-day and detailed forecast metrics
└── main.dart           # App entry point and service initializations
