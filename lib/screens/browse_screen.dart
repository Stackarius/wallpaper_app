import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper_app/widgets/category_grid.dart';
import 'package:wallpaper_app/widgets/category_listview.dart';
import 'package:wallpaper_app/widgets/gradient_text.dart';
import '../constants/colors.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  // current view
  bool _isGridView = true;

  // toggle view
  void toggleView() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50.h),
        // Browse section && action buttons
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 47.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildBrowseSection()),
              // Actions
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (!_isGridView) toggleView();
                    },
                    icon: Icon(
                      Icons.grid_view_outlined,

                      color:
                          _isGridView
                              ? AppColors.orange
                              : AppColors.blackPrimary.withAlpha(100),
                      size: 24.h,
                    ),
                    tooltip: 'Share',
                  ),
                  SizedBox(width: 8.w),
                  IconButton(
                    onPressed: () {
                      if (_isGridView) toggleView();
                    },
                    icon: SvgPicture.asset(
                      'assets/images/random/Rows.svg',
                      fit: BoxFit.contain,
                      height: 24.h,
                      width: 28.8.w,
                      theme: SvgTheme(
                        currentColor:
                            !_isGridView
                                ? AppColors.orange
                                : AppColors.blackPrimary.withAlpha(100),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 50.h),
        Expanded(
          child: SingleChildScrollView(
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.only(bottom: 50.h, right: 47.w, left: 47.w),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child:
                  _isGridView
                      ? CategoryGrid(key: ValueKey('grid'))
                      : CategoryListView(key: ValueKey('list')),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBrowseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          "Browse Categories",
          gradient: const LinearGradient(
            colors: [AppColors.orange, AppColors.pink],
          ),
          style: TextStyle(
            fontFamily: 'Clash Display',
            fontSize: 60.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          "Explore our curated collections of stunning wallpapers.",
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
