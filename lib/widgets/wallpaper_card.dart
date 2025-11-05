import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/constants/colors.dart';
import 'package:wallpaper_app/models/wallpaper.dart';

class WallpaperCard extends StatelessWidget {
  final Wallpaper wallpaper;

  const WallpaperCard({super.key, required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 435.w,
      height: 290.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26.r),
        image: DecorationImage(
          image: AssetImage(wallpaper.imagePath ?? "assets/images/image1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26.r),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.55), Colors.transparent],
              ),
            ),
          ),

          Positioned(
            left: 28.w,
            bottom: 28.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wallpaper.title,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  wallpaper.subtitle,
                  style: TextStyle(
                    color: AppColors.white.withOpacity(0.9),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                  ),
                ),

                //
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.15),
                  ),
                  child: Text(
                    '${wallpaper.totalNo} wallpapers',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
