import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/provider/navigation_provider.dart';
import 'package:wallpaper_app/screens/browse_screen.dart';
import 'package:wallpaper_app/screens/favorite_screen.dart';
import 'package:wallpaper_app/screens/home_screen.dart';
import 'package:wallpaper_app/screens/settings_screen.dart';
import 'package:wallpaper_app/widgets/custom_appbar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final List _pages = const [
    HomeScreen(),
    BrowseScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = context.watch<NavigationProvider>();

    return Scaffold(
      body: Column(
        children: [
          const CustomAppbar(),
          Expanded(child: _pages[navigationProvider.selectedIndex]),
        ],
      ),
    );
  }
}
