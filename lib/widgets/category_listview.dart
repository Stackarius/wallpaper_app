import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:wallpaper_app/screens/wallpaper_screen.dart';

import '../constants/colors.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final wallpapers = [
      Wallpaper(
        title: 'Nature',
        subtitle: 'Mountains, Forest and Landscapes',
        category: 'Nature',
        totalNo: 3,
        imagePath: "assets/images/image1.png",
        tags: [],
      ),
      Wallpaper(
        title: 'Abstract',
        subtitle: 'Modern Geomentric and artistic designs',
        category: 'Abstract',
        totalNo: 4,
        imagePath: "assets/images/image2.png",
        tags: [],
      ),
      Wallpaper(
        title: 'Urban',
        subtitle: 'Cities, architecture and street',
        category: 'Urban',
        totalNo: 6,
        imagePath: "assets/images/image3.png",
        tags: [],
      ),
      Wallpaper(
        title: 'Space',
        subtitle: 'Cosmos, planets, and galaxies',
        category: 'Space',
        totalNo: 3,
        imagePath: "assets/images/image4.png",
        tags: [],
      ),
      Wallpaper(
        title: 'Minimalist',
        subtitle: 'Clean, simple, and elegant',
        category: 'Minimalist',
        totalNo: 6,
        imagePath: "assets/images/image5.png",
        tags: [],
      ),
      Wallpaper(
        title: 'Animal',
        subtitle: 'Wildlife and nature photography',
        category: 'Animal',
        totalNo: 4,
        imagePath: "assets/images/image6.png",
        tags: [],
      ),
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: wallpapers.length,
      separatorBuilder: (context, index) => SizedBox(height: 20.h),
      itemBuilder: (context, index) {
        final category = wallpapers[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (context) => WallpaperScreen(
                      categoryName: category.title,
                      categoryDescription: category.category!,
                    ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                // Icon/Image
                Container(
                  width: 277.21.w,
                  height: 185.12.h,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16.56.r),
                  ),
                  child: Image(
                    image: AssetImage(category.imagePath as String),
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(width: 20.w),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.title,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        category.subtitle,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.blackSecondary.withAlpha(40),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.grayBg.withAlpha(20),
                        ),
                        child: Text(
                          '${category.totalNo} wallpapers',
                          style: TextStyle(
                            color: AppColors.blackSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
