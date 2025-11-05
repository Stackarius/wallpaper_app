import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/constants/colors.dart';

class WallpaperSetupDialog extends StatefulWidget {
  const WallpaperSetupDialog({super.key});

  @override
  State<WallpaperSetupDialog> createState() => _WallpaperSetupDialogState();
}

class _WallpaperSetupDialogState extends State<WallpaperSetupDialog> {
  String _displayMode = 'fit';
  bool _autoRotation = true;
  bool _lockWallpaper = true;
  bool _syncDevices = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.centerRight,
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 656.w,
        height: MediaQuery.of(context).size.height,
        color: AppColors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 37.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              SizedBox(height: 26.h),
              _buildActivateWallpaperCard(),
              SizedBox(height: 32.h),
              _buildDisplayModeSection(),
              SizedBox(height: 32.h),
              _buildAutoRotationCard(),
              SizedBox(height: 32.h),
              _buildAdvancedSettingsSection(),
              SizedBox(height: 32.h),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Wallpaper Setup",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.blackSecondary,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Configure your wallpaper settings and enable auto-rotation",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textGray,
          ),
        ),
      ],
    );
  }

  Widget _buildActivateWallpaperCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: AppColors.grayBg),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Activate Wallpaper",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackSecondary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Set the selected wallpaper as your desktop background",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textGray,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.check_circle, color: Colors.green, size: 20),
                SizedBox(width: 8),
                Text(
                  'Activated',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplayModeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Display mode',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blackSecondary,
          ),
        ),
        SizedBox(height: 16.h),
        _buildRadioOption('Fit', 'Scale to fit without cropping', 'fit'),
        SizedBox(height: 12.h),
        _buildRadioOption('Fill', 'Scale to fill the entire screen', 'fill'),
        SizedBox(height: 12.h),
        _buildRadioOption('Stretch', 'Stretch to fill the screen', 'stretch'),
        SizedBox(height: 12.h),
        _buildRadioOption(
          'Tile',
          'Repeat the image to fill the screen',
          'tile',
        ),
      ],
    );
  }

  Widget _buildRadioOption(String title, String subtitle, String value) {
    final isSelected = _displayMode == value;
    return InkWell(
      onTap: () => setState(() => _displayMode = value),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? AppColors.orange : AppColors.grayBg,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.orange : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child:
                  isSelected
                      ? Center(
                        child: Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.orange,
                          ),
                        ),
                      )
                      : null,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackSecondary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textGray,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoRotationCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: AppColors.grayBg),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Auto - Rotation",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackSecondary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Automatically change your wallpaper at regular intervals",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textGray,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _autoRotation,
            onChanged: (value) => setState(() => _autoRotation = value),
            activeColor: AppColors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Advanced Settings',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blackSecondary,
          ),
        ),
        SizedBox(height: 16.h),
        _buildCheckboxOption(
          'Lock Wallpaper',
          'Prevent accidental changes',
          _lockWallpaper,
          (value) => setState(() => _lockWallpaper = value!),
        ),
        SizedBox(height: 12.h),
        _buildCheckboxOption(
          'Sync Across Devices',
          'Keep wallpaper consistent on all devices',
          _syncDevices,
          (value) => setState(() => _syncDevices = value!),
        ),
      ],
    );
  }

  Widget _buildCheckboxOption(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool?> onChanged,
  ) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.grayBg, width: 1),
      ),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14.sp, color: AppColors.textGray),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
          ),
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 16.sp, color: AppColors.textGray),
          ),
        ),
        SizedBox(width: 16.w),
        ElevatedButton(
          onPressed: () {
            // Save settings logic here
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.orange,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            'Save Settings',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
