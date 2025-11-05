# Wallpaper App

A modern wallpaper application built with Flutter that allows users to browse, favorite, and set wallpapers on their device.

## Features

- Browse wallpapers in a grid or list view
- Favorite wallpapers for quick access
- Set wallpapers on your device
- Responsive design that works across different screen sizes
- Category-based wallpaper organization
- Settings customization

## Project Structure

```
lib/
├── constants/
│   └── colors.dart          # Color constants used throughout the app
├── dialog/
│   └── wallpaper_setup_dialog.dart  # Dialog for wallpaper setup options
├── models/
│   └── wallpaper.dart       # Wallpaper data model
├── provider/
│   ├── favorite_provider.dart    # State management for favorites
│   ├── navigation_provider.dart  # Navigation state management
│   └── wallpaper_provider.dart   # Wallpaper data state management
├── screens/
│   ├── browse_screen.dart       # Browse wallpapers screen
│   ├── favorite_screen.dart     # Favorited wallpapers screen
│   ├── home_screen.dart         # Main home screen
│   ├── main_navigation.dart     # Navigation handling
│   ├── settings_screen.dart     # App settings screen
│   └── wallpaper_screen.dart    # Individual wallpaper view
├── utils/
│   └── responsive.dart          # Responsive design utilities
├── widgets/
│   ├── category_grid.dart       # Grid view for categories
│   ├── category_listview.dart   # List view for categories
│   ├── custom_appbar.dart       # Custom app bar component
│   ├── custom_buttons.dart      # Reusable button components
│   ├── gradient_text.dart       # Gradient text component
│   └── wallpaper_card.dart      # Wallpaper preview card
└── main.dart                    # App entry point
```

## Assets

- `assets/fonts/` - Custom fonts used in the application
- `assets/images/`
  - `random/` - Random wallpaper images
  - `wallpaper/` - Categorized wallpaper images

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Windows SDK (for Windows desktop support)

### Installation

1. Clone the repository

```bash
git clone [repository-url]
```

2. Navigate to the project directory

```bash
cd wallpaper_app
```

3. Install dependencies

```bash
flutter pub get
```

4. Run the app

```bash
flutter run
```

## Building

To build the Windows application:

```bash
flutter build windows
```

The built application will be available in the `build/windows` directory.

## Dependencies

Check `pubspec.yaml` for the complete list of dependencies. Key dependencies include:

- window_manager: For Windows desktop window management
- provider: For state management

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
