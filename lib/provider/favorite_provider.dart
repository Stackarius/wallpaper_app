import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  int get favoriteCount => _favorites.length;

  bool get isEmpty => _favorites.isEmpty;

  /// Add a wallpaper to favorites
  void addFavorite(Map<String, dynamic> wallpaper) {
    final wallpaperName = wallpaper['name'] ?? '';

    // Check if already exists
    if (!_favorites.any((w) => w['name'] == wallpaperName)) {
      _favorites.add(wallpaper);
      notifyListeners();
    }
  }

  /// Remove a wallpaper from favorites by name
  void removeFavorite(String wallpaperName) {
    _favorites.removeWhere((w) => w['name'] == wallpaperName);
    notifyListeners();
  }

  /// Toggle favorite status for a wallpaper
  void toggleFavorite(Map<String, dynamic> wallpaper) {
    final wallpaperName = wallpaper['name'] ?? '';

    if (isFavorite(wallpaperName)) {
      removeFavorite(wallpaperName);
    } else {
      addFavorite(wallpaper);
    }
  }

  /// Check if a wallpaper is in favorites by name
  bool isFavorite(String wallpaperName) {
    return _favorites.any((w) => w['name'] == wallpaperName);
  }

  /// Clear all favorites
  void clearAllFavorites() {
    _favorites.clear();
    notifyListeners();
  }
}
