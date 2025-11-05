import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/wallpaper.dart';

class WallpaperProvider extends ChangeNotifier {
  Wallpaper? _activeWallpaper;
  Wallpaper? get activeWallpaper => _activeWallpaper;

  static const _keyImagePath = 'active_wallpaper_image';
  static const _keyTitle = 'active_wallpaper_title';
  static const _keySubtitle = 'active_wallpaper_subtitle';
  static const _keyCategory = 'active_wallpaper_category';
  static const _keyTotal = 'active_wallpaper_total';

  // load the wallpaper from shated preferences
  Future<void> loadActiveWallpaper() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString(_keyImagePath);
    final title = prefs.getString(_keyTitle);
    final subtitle = prefs.getString(_keySubtitle);
    final category = prefs.getString(_keyCategory);
    final total = prefs.getInt(_keyTotal);

    if (imagePath != null && title != null && subtitle != null) {
      _activeWallpaper = Wallpaper(
        title: title,
        subtitle: subtitle,
        imagePath: imagePath,
        category: category,
        totalNo: total,
        tags: [],
      );

      notifyListeners();
    }
  }

  Future<void> setActiveWallpaper(Wallpaper wallpaper) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyImagePath, wallpaper.imagePath as String);
    await prefs.setString(_keyTitle, wallpaper.title);
    await prefs.setString(_keySubtitle, wallpaper.subtitle);
    await prefs.setString(_keyCategory, wallpaper.category!);
    await prefs.setInt(_keyTotal, wallpaper.totalNo!);

    _activeWallpaper = wallpaper;
    notifyListeners();
  }

  /// Clear the active wallpaper
  Future<void> clearActiveWallpaper() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyImagePath);
    await prefs.remove(_keyTitle);
    await prefs.remove(_keySubtitle);

    _activeWallpaper = null;
    notifyListeners();
  }
}
