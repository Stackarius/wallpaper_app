import 'dart:io';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/constants/colors.dart';
import 'package:wallpaper_app/dialog/wallpaper_setup_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:ffi/ffi.dart';
import '../models/wallpaper.dart';
import '../provider/favorite_provider.dart';
import '../provider/wallpaper_provider.dart';
import '../widgets/custom_buttons.dart';

class WallpaperScreen extends StatefulWidget {
  final String categoryName;
  final String categoryDescription;

  const WallpaperScreen({
    super.key,
    required this.categoryName,
    required this.categoryDescription,
  });

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  int _selectedWallpaperIndex = 0;
  bool _isSettingWallpaper = false;

  final List<Map<String, dynamic>> wallpapers = [
    {
      'id': 1,
      'name': 'Nature 1',
      'image': 'assets/images/wallpaper/wallpaper1.png',
      'tags': ['Nature', 'Mountains', 'Flowers'],
      'description':
          'Discover the pure beauty of natural essence - your gateway to authentic, breathtaking landscapes. This unique collection elevate your senses and connect you with the undefined...',
    },
    {
      'id': 2,
      'name': 'Nature 2',
      'image': 'assets/images/wallpaper/wallpaper2.png',
      'tags': ['Nature', 'Forest'],
      'description': 'Beautiful forest scenery with morning mist',
    },
    {
      'id': 3,
      'name': 'Nature 3',
      'image': 'assets/images/wallpaper/wallpaper3.png',
      'tags': ['Nature', 'Sunset'],
      'description': 'Stunning sunset over the mountains',
    },
    {
      'id': 4,
      'name': 'Nature 4',
      'image': 'assets/images/wallpaper/walpaper4.png',
      'tags': ['Nature', 'Ocean'],
      'description': 'Peaceful ocean view at sunset',
    },
    {
      'id': 5,
      'name': 'Nature 5',
      'image': 'assets/images/wallpaper/wallpaper5.png',
      'tags': ['Nature', 'Night'],
      'description': 'Starry night sky over the lake',
    },
    {
      'id': 6,
      'name': 'Nature 6',
      'image': 'assets/images/wallpaper/wallpaper6.png',
      'tags': ['Nature', 'Waterfall'],
      'description': 'Majestic waterfall in the forest',
    },
  ];

  Map<String, dynamic> get selectedWallpaper =>
      wallpapers[_selectedWallpaperIndex];

  Future<void> _saveWallpaper() async {
    setState(() {
      _isSettingWallpaper = true;
    });

    try {
      final wallpaperProvider = Provider.of<WallpaperProvider>(
        context,
        listen: false,
      );

      final wallpaper = Wallpaper(
        title: selectedWallpaper['name'],
        subtitle: selectedWallpaper['tags'].join(', '),
        imagePath: selectedWallpaper['image'],
        category: widget.categoryName,
        totalNo: wallpapers.length,
        tags: List<String>.from(selectedWallpaper['tags']),
      );

      await wallpaperProvider.setActiveWallpaper(wallpaper);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Wallpaper "${selectedWallpaper['name']}" set successfully!',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to set wallpaper: $e')));
    } finally {
      setState(() {
        _isSettingWallpaper = false;
      });
    }
  }

  void _showWallpaperSetupDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => const WallpaperSetupDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 47.w, vertical: 30.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLeftPanel(),
            SizedBox(width: 40.w),
            _buildRightPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftPanel() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBackButton(),
          SizedBox(height: 20.h),
          _buildHeader(),
          SizedBox(height: 30.h),
          Expanded(child: _buildWallpaperGrid()),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return TextButton.icon(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back, size: 20.sp),
      label: Text('Back to Categories', style: TextStyle(fontSize: 16.sp)),
      style: TextButton.styleFrom(foregroundColor: AppColors.blackPrimary),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.categoryName,
          style: TextStyle(fontSize: 48.sp, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.grid_view, size: 24.sp),
          color: AppColors.orange,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.view_list_outlined, size: 24.sp),
          color: Colors.grey[400],
        ),
      ],
    );
  }

  Widget _buildWallpaperGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.7,
      ),
      itemCount: wallpapers.length,
      itemBuilder: (context, index) => _buildWallpaperCard(index),
    );
  }

  Widget _buildWallpaperCard(int index) {
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
            _buildFavoriteIcon(isSelected),
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

  Widget _buildFavoriteIcon(bool isSelected) {
    return Positioned(
      top: 12.h,
      right: 12.w,
      child: Container(
        padding: EdgeInsets.all(6.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isSelected ? Icons.favorite : Icons.favorite_border,
          size: 20.sp,
          color: isSelected ? AppColors.orange : Colors.grey[600],
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
              wallpaper['tags'].isNotEmpty ? wallpaper['tags'][0] : 'Nature',
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightPanel() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(40.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildPreviewPanel(),
            const Spacer(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewPanel() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildWallpaperDetails()),
        _buildPhonePreview(),
      ],
    );
  }

  Widget _buildWallpaperDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Preview",
          style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 37.h),
        _buildNameSection(),
        SizedBox(height: 37.h),
        _buildTagsSection(),
        SizedBox(height: 37.h),
        _buildDescriptionSection(),
        SizedBox(height: 20.h),
        _buildIconButtons(),
      ],
    );
  }

  Widget _buildNameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGray,
          ),
        ),
        Text(
          selectedWallpaper['name'],
          style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTagsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tags",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGray,
          ),
        ),
        SizedBox(height: 4.sp),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: List<Widget>.generate(
            selectedWallpaper['tags'].length,
            (index) => _buildTag(selectedWallpaper['tags'][index]),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.blackSecondary.withAlpha(40),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(30),
        color: AppColors.grayBg.withAlpha(20),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: AppColors.blackSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Text(
      selectedWallpaper['description'],
      style: TextStyle(fontSize: 16.sp, color: Colors.grey[700], height: 1.5),
      maxLines: 5,
      overflow: TextOverflow.fade,
    );
  }

  Widget _buildIconButtons() {
    return Row(
      children: [
        _buildIconButton(Icons.ios_share_outlined, () {}),
        SizedBox(width: 12.w),
        _buildIconButton(Icons.compare_arrows_rounded, () {}, rotation: 40),
        SizedBox(width: 12.w),
        _buildIconButton(Icons.settings_outlined, _showWallpaperSetupDialog),
      ],
    );
  }

  Widget _buildIconButton(
    IconData icon,
    VoidCallback onPressed, {
    double rotation = 0,
  }) {
    return Container(
      padding: EdgeInsets.all(6.53.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.r),
        color: AppColors.blackPrimary.withAlpha(30),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon:
            rotation != 0
                ? Transform.rotate(
                  angle: rotation,
                  child: Icon(icon, color: AppColors.blackPrimary, size: 24.sp),
                )
                : Icon(icon, color: AppColors.blackPrimary, size: 24.sp),
      ),
    );
  }

  Widget _buildPhonePreview() {
    return SizedBox(
      height: 524.99.h,
      width: 258.04.w,
      child: DeviceFrame(
        device: Devices.ios.iPhone16,
        orientation: Orientation.portrait,
        screen: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: Image.asset(
            selectedWallpaper['image'],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            context.read<FavoriteProvider>().toggleFavorite(selectedWallpaper);
            debugPrint("Wallpaper toggled: ${selectedWallpaper['name']}");
          },
          child: Consumer<FavoriteProvider>(
            builder: (context, favoriteProvider, _) {
              final wallpaperName = selectedWallpaper['name'] ?? 'Unknown';
              final isFavorite = favoriteProvider.isFavorite(wallpaperName);

              return CustomButtons(
                border: 1,
                child: Row(
                  children: [
                    Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: isFavorite ? AppColors.orange : null,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      isFavorite ? "Added to Favorites" : "Save to Favorite",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: _saveWallpaper,
          child: CustomButtons(
            border: 0,
            buttonColor: AppColors.orange,
            child:
                _isSettingWallpaper
                    ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                        strokeWidth: 2,
                      ),
                    )
                    : Row(
                      children: [
                        Text(
                          "Set to Wallpaper",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ],
    );
  }
}
