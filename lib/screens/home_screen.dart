import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_app/constants/colors.dart';
import 'package:wallpaper_app/widgets/category_grid.dart';
import 'package:wallpaper_app/widgets/gradient_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _activeWallpaperPath;
  String? _activeWallpaperCategory;
  int? _activeWallpaperTotal;

  @override
  void initState() {
    super.initState();
    _loadActiveWallpaper();
  }

  Future<void> _loadActiveWallpaper() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _activeWallpaperPath = prefs.getString('active_wallpaper_image');
      _activeWallpaperCategory = prefs.getString('active_wallpaper_category');
      _activeWallpaperTotal = prefs.getInt('active_wallpaper_total');
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasWallpaper =
        _activeWallpaperPath != null && _activeWallpaperPath!.isNotEmpty;

    return Column(
      children: [
        // SCROLLABLE CONTENT
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                // Dynamic Hero Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 47.w),
                  child:
                      hasWallpaper
                          ? _buildActiveWallpaperCard()
                          : _buildDiscoverSection(),
                ),

                SizedBox(height: 50.h),

                // Categories Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 47.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "See All",
                          style: TextStyle(
                            color: AppColors.blackPrimary.withOpacity(0.8),
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Category Grid
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 47.w),
                  child: const CategoryGrid(),
                ),

                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveWallpaperCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(26.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Wallpaper Image
          Container(
            width: 117.77.w,
            height: 210.33.h,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Image.asset(
              _activeWallpaperPath ?? "assets/images/wallpaper/wallpaper1.png",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.broken_image, size: 40.sp),
                );
              },
            ),
          ),

          SizedBox(width: 24.w),

          // Hero Text & Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientText(
                  "Your Active Wallpaper",
                  gradient: LinearGradient(
                    colors: [AppColors.orange, AppColors.pink],
                  ),
                  style: TextStyle(
                    fontFamily: 'Clash Display',
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "This wallpaper is currently set as your active background",
                  style: TextStyle(fontSize: 18.sp, color: Colors.grey[700]),
                ),

                SizedBox(height: 24.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Details Column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category
                        if (_activeWallpaperCategory != null)
                          _buildDetailRow(
                            'Category',
                            _activeWallpaperCategory!,
                          ),

                        SizedBox(height: 8.h),

                        if (_activeWallpaperTotal != null)
                          _buildDetailRow(
                            'Selection',
                            'Wallpaper $_activeWallpaperTotal',
                          ),
                      ],
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.53.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11.r),
                            color: AppColors.blackPrimary.withAlpha(30),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.ios_share_outlined,

                              color: AppColors.blackPrimary,
                              size: 24.sp,
                            ),
                            tooltip: 'Share',
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          padding: EdgeInsets.all(6.53.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11.r),
                            color: AppColors.blackPrimary.withAlpha(30),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.settings_outlined,

                              color: AppColors.blackPrimary,
                              size: 24.sp,
                            ),
                            tooltip: 'Share',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label ',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.blackPrimary.withOpacity(0.6),
          ),
        ),
        Text(
          '- $value',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.blackSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDiscoverSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          "Discover Beautiful Wallpapers",
          gradient: LinearGradient(colors: [AppColors.orange, AppColors.pink]),
          style: TextStyle(
            fontFamily: 'Clash Display',
            fontSize: 60.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          "Discover curated collections of stunning wallpapers. Browse by\ncategory, preview in full-screen, and set your favorites.",
          style: TextStyle(
            fontSize: 24.sp,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
