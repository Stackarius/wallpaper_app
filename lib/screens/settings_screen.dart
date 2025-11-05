import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/constants/colors.dart';
import 'package:wallpaper_app/widgets/gradient_text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedQuality = 'High (Best Quality)';
  bool _notificationEnabled = true;

  final List<String> _qualityOptions = [
    'Low (Faster)',
    'Medium',
    'High (Best Quality)',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 47.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
              "Settings",
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
              "Customize your Wallpaper Studio experience",
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            SizedBox(height: 50.h),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 2, child: _buildSettingsPanel()),
                  SizedBox(width: 60.w),
                  Expanded(child: _buildDevicePreview()),
                ],
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsPanel() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 151.w, vertical: 35.h),

      decoration: BoxDecoration(
        color: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Wallpaper Setup",
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(
            "Configure your wallpaper settings and enable auto-rotation",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 40.h),
          _buildImageQualitySection(),
          SizedBox(height: 30.h),
          _buildNotificationSection(),
          const Spacer(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildImageQualitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Image Quality",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: DropdownButton<String>(
            value: _selectedQuality,
            isExpanded: true,
            underline: SizedBox(),
            items:
                _qualityOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedQuality = newValue;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notification",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4.h),
              Text(
                "Get notified about new wallpapers and updates",
                style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
              ),
            ],
          ),
          Transform.scale(
            scale: .8,
            child: Switch(
              value: _notificationEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationEnabled = value;
                });
              },
              activeColor: AppColors.white,
              activeTrackColor: AppColors.orange,
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
          onPressed: () {
            setState(() {
              _selectedQuality = 'High (Best Quality)';
              _notificationEnabled = true;
            });
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
              side: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: Text(
            "Cancel",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.blackPrimary,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Settings saved successfully!'),
                backgroundColor: AppColors.orange,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.orange,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
            ),
          ),
          child: Text(
            "Save Settings",
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

  Widget _buildDevicePreview() {
    return SizedBox(
      height: 524.99.h,
      width: 258.04.w,
      child: Image(image: AssetImage("assets/images/random/phone1.png")),
    );
  }
}
