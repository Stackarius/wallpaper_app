import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/provider/favorite_provider.dart';
import 'package:wallpaper_app/widgets/gradient_text.dart';
import 'package:wallpaper_app/provider/navigation_provider.dart';

import '../constants/colors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _selectedWallpaperIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 47.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
              "Saved Wallpapers",
              gradient: LinearGradient(
                colors: [AppColors.orange, AppColors.pink],
              ),
              style: TextStyle(
                fontFamily: 'Clash Display',
                fontSize: 60.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Your saved wallpapers collection.",
              style: TextStyle(
                fontSize: 24.sp,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            SizedBox(height: 50.h),
            Expanded(
              child: Consumer<FavoriteProvider>(
                builder: (context, favoriteProvider, _) {
                  if (favoriteProvider.isEmpty) {
                    return _buildEmptyState();
                  }

                  return _buildWallpaperGrid(favoriteProvider.favorites);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/images/random/icon1.png"),
            height: 185.29.h,
            width: 197.57.w,
          ),
          SizedBox(height: 24.h),
          Text(
            "No Saved Wallpapers",
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Start saving your favorite wallpapers to see them here",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          SizedBox(height: 32.h),
          ElevatedButton(
            onPressed: () {
              // Switch to the Browse tab (index 1)
              Provider.of<NavigationProvider>(
                context,
                listen: false,
              ).setSelectedIndex(1);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orange,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
            child: Text(
              "Browse Wallpapers",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWallpaperGrid(List<Map<String, dynamic>> wallpapers) {
    return Padding(
      padding: EdgeInsets.only(bottom: 23.h),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 23.h,
          childAspectRatio: 0.7,
        ),
        itemCount: wallpapers.length,
        itemBuilder: (context, index) => _buildWallpaperCard(index, wallpapers),
      ),
    );
  }

  Widget _buildWallpaperCard(int index, List<Map<String, dynamic>> wallpapers) {
    final wallpaper = wallpapers[index];
    final isSelected = _selectedWallpaperIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedWallpaperIndex = index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border:
              isSelected ? Border.all(color: AppColors.orange, width: 3) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            _buildWallpaperImage(wallpaper, isSelected),
            _buildFavoriteIcon(wallpaper['name']),
            _buildWallpaperInfo(wallpaper),
          ],
        ),
      ),
    );
  }

  Widget _buildWallpaperImage(Map<String, dynamic> wallpaper, bool isSelected) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Image.asset(
        wallpaper['image'],
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        opacity: AlwaysStoppedAnimation(isSelected ? 1.0 : 0.8),
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFavoriteIcon(String wallpaperName) {
    return Positioned(
      top: 12.h,
      right: 12.w,
      child: GestureDetector(
        onTap: () {
          context.read<FavoriteProvider>().removeFavorite(wallpaperName);
        },
        child: Container(
          padding: EdgeInsets.all(6.w),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.favorite, size: 20.sp, color: AppColors.orange),
        ),
      ),
    );
  }

  Widget _buildWallpaperInfo(Map<String, dynamic> wallpaper) {
    return Positioned(
      bottom: 12.h,
      left: 12.w,
      right: 12.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            wallpaper['name'],
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              wallpaper['tags'] != null && wallpaper['tags'].isNotEmpty
                  ? wallpaper['tags'][0]
                  : 'Nature',
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}
