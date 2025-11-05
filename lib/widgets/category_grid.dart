import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:wallpaper_app/screens/wallpaper_screen.dart';
import 'package:wallpaper_app/utils/responsive.dart';
import 'package:wallpaper_app/widgets/wallpaper_card.dart';

import 'package:provider/provider.dart';
import 'package:wallpaper_app/provider/favorite_provider.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

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

    final columns = Responsive.getGridColumns(context);
    final aspectRatio = Responsive.getAspectRatio(context);
    final crossSpacing = Responsive.getGridSpacing(context);

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: aspectRatio,
        crossAxisSpacing: crossSpacing.toDouble(),
        mainAxisSpacing: 20,
      ),
      itemCount: wallpapers.length,
      itemBuilder:
          (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (context) => WallpaperScreen(
                        categoryName: wallpapers[index].title,
                        categoryDescription: wallpapers[index].category!,
                      ),
                ),
              );
            },
            child: WallpaperCard(wallpaper: wallpapers[index]),
          ),
    );
  }
}
