import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/constants/colors.dart';
import 'package:wallpaper_app/provider/favorite_provider.dart';
import 'package:wallpaper_app/provider/navigation_provider.dart';
import 'package:wallpaper_app/provider/wallpaper_provider.dart';
import 'package:wallpaper_app/screens/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final wallpaperProvider = WallpaperProvider();
  await wallpaperProvider.loadActiveWallpaper();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider.value(value: wallpaperProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Wallpaper Selector',
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            scaffoldBackgroundColor: AppColors.white.withAlpha(250),
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.orange),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const MainNavigation(),
        );
      },
    );
  }
}
