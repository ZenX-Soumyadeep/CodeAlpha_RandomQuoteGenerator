# CodeAlpha_RandomQuoteGenerator

A clean, minimalist mobile application built with **Flutter** and **Material 3** that displays inspirational quotes at random with smooth animations and clipboard support. Developed as part of the **CodeAlpha App Development Internship** (Task 2)[cite: 1, 2].

---

## 📱 Features

- **Dynamic Quote Loading:** Automatically presents an initial quote upon app launch.
- **Duplicate Prevention:** The "New Quote" button is programmed to prevent consecutive duplicate quotes[cite: 2].
- **Clear Author Attribution:** Displays both the quote body and author name distinctly in Material 3 typography[cite: 2].
- **Animated Transitions:** Uses `AnimatedSwitcher` for smooth fade transitions when refreshing cards.
- **Copy to Clipboard:** Includes a one-tap action button with floating `SnackBar` visual feedback.
- **Adaptive Theme:** Supports both Light and Dark modes based on device system settings.

---

## 🛠️ Tech Stack & Architecture

- **Framework:** [Flutter](https://flutter.dev/) (Channel stable)
- **Language:** [Dart](https://dart.dev/)
- **UI Design System:** Material Design 3 (`useMaterial3: true`)
- **State Management:** Native `StatefulWidget` (`setState`)

### Project Structure

```text
lib/
├── data/
│   └── quotes_data.dart     # Static quotes collection
├── models/
│   └── quote_model.dart     # Quote data model
├── screens/
│   └── quote_screen.dart    # Primary Material 3 user interface
└── main.dart                # Application entry point & theme setup